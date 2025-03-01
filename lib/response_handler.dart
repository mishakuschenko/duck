import 'dart:convert';
import 'dart:io';

class ResponseHandler {
  void handleResponse(HttpRequest request, dynamic response) {
    if (response is Map) {
      request.response
        ..headers.set('Content-Type', 'application/json') 
        ..write(jsonEncode(response))
        ..close();
    } else if (response is String && response.startsWith('<xml>')) {
      request.response
        ..headers.set('Content-Type', 'application/xml')
        ..write(response)
        ..close();
    } else {
      request.response
        ..write(response)
        ..close();
    }
  }
}