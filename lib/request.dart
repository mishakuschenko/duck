import 'dart:io';
import 'dart:convert';

class Request {
  final HttpRequest _request;
  Map<String, String>? _params;

  Request(this._request);

  String get method => _request.method;
  Uri get uri => _request.uri;

  Map<String, String> get queryParameters => _request.uri.queryParameters;

  Future<String> get body async {
    return await utf8.decoder.bind(_request).join();
  }

  Map<String, String> get params => _params ?? {};
  set params(Map<String, String> value) => _params = value;
}