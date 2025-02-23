import 'dart:io';

class Route {
  final String path;
  final String method;
  final Future<String> Function(HttpRequest) handler;

  Route(this.path, this.method, this.handler);
}