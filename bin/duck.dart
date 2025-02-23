import 'dart:io';
import 'dart:async';
import 'package:duck/logger.dart';
import 'route.dart';
import 'middleware.dart';

class Duck {
  final String _host;
  final int _port;
  Duck(this._host, this._port);

  final List<Route> routes = [];
  final List<Middleware> middlewares = [];

  final log = Logger();

  void get(String path, Future<String> Function(HttpRequest) handler) {
    routes.add(Route(path, 'GET', handler));
  }

  void post(String path, Future<String> Function(HttpRequest) handler) {
    routes.add(Route(path, 'POST', handler));
  }

  void put(String path, Future<String> Function(HttpRequest) handler) {
    routes.add(Route(path, 'PUT', handler));
  }

  void delete(String path, Future<String> Function(HttpRequest) handler) {
    routes.add(Route(path, 'DELETE', handler));
  }

  void use(Middleware middleware) {
    middlewares.add(middleware);
  }

  Future<String> _find(HttpRequest request) async {
    for (var route in routes) {
      if (route.path == request.uri.path && route.method == request.method) {
        return await route.handler(request);
      }
    }
    return '''
      HTTP/1.1 404 Not Found
      Content-Type: text/html
      <h1>404 Not Found</h1>
      ''';
  }
  
  Future<void> _executeMiddlewares(HttpRequest request, int index, Function finalHandler) async {
    if (index >= middlewares.length) {
      await finalHandler();
      return;
    }
    await middlewares[index].handle(request, () => _executeMiddlewares(request, index + 1, finalHandler));
  }

  Future<void> _handleRequest(HttpRequest request) async {
    await _executeMiddlewares(request, 0, () async {
      final responseBody = await _find(request);
      request.response
        ..headers.contentType = ContentType.json
        ..write(responseBody)
        ..close();
    });
  }

  Future<void> start() async {
    final server = await HttpServer.bind(InternetAddress.anyIPv4, _port);
    log.startServer('Server start in $_host:$_port');
    await for (var request in server) {
      _handleRequest(request);
    }
  }
}