import 'dart:convert';
import 'dart:io';

/// A class responsible for handling and sending HTTP responses based on the type of response data.
///
/// This class processes the response data and sets the appropriate `Content-Type` header
/// before sending the response back to the client.
class ResponseHandler {
  /// Handles the response by determining its type and sending it back to the client.
  ///
  /// [request] - the incoming HTTP request object.
  /// [response] - the response data to be sent back to the client. It can be a [Map],
  /// a [String], or any other type.
  ///
  /// If the response is a [Map], it is converted to JSON and sent with the `Content-Type`
  /// header set to `application/json`.
  ///
  /// If the response is a [String] starting with `<xml>`, it is sent with the `Content-Type`
  /// header set to `application/xml`.
  ///
  /// For all other types, the response is sent as-is without any specific `Content-Type` header.
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