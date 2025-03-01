import 'dart:io';

class Router {
  final Map<String, Function(HttpRequest)> _routes = {};

  void get(String path, Function(HttpRequest) handler) {
    _routes['GET:$path'] = handler;
  }

  void post(String path, Function(HttpRequest) handler) {
    _routes['POST:$path'] = handler;
  }

  void put(String path, Function(HttpRequest) handler) {
    _routes['PUT:$path'] = handler;
  }

  void delete(String path, Function(HttpRequest) handler) {
    _routes['DELETE:$path'] = handler;
  }

  Function(HttpRequest)? getHandler(String method, String path) {
    return _routes['$method:$path'];
  }
}