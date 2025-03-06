import 'dart:io';
import 'dart:convert';

class Response {
  final HttpResponse _response;

  Response(this._response);

  void send(int statusCode, dynamic data) {
    _response.statusCode = statusCode;
    
    if (data is String) {
      _response.headers.contentType = ContentType.html;
      _response.write(data);
    } else if (data is Map) {
      _response.headers.contentType = ContentType.json;
      _response.write(jsonEncode(data));
    }
    
    _response.close();
  }

  void json(int statusCode, Map data) {
    _response
      ..statusCode = statusCode
      ..headers.contentType = ContentType.json
      ..write(jsonEncode(data))
      ..close();
  }

  void html(int statusCode, String html) {
    _response
      ..statusCode = statusCode
      ..headers.contentType = ContentType.html
      ..write(html)
      ..close();
  }
}