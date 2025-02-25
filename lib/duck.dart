import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:duck/logger.dart';

class Duck {
  final log = Logger();

  final Map<String, Function(HttpRequest)> _routes = {};

  Future<void> get(String path, Function(HttpRequest) handler) async {
    _routes['GET:$path'] = handler;
  }

  Future<void> post(String path, Function(HttpRequest) handler) async {
    _routes['POST:$path'] = handler;
  }

  Future<void> put(String path, Function(HttpRequest) handler) async {
    _routes['PUT:$path'] = handler;
  }

  Future<void> delete(String path, Function(HttpRequest) handler) async {
    _routes['DELETE:$path'] = handler;
  }

  Future<void> start({String host = 'localhost', int port = 8080}) async {
    final server = await HttpServer.bind(host, port);

    log.startServer('Server started on $host:$port');

    await for (var request in server) {
      final path = request.uri.path;
      final method = request.method;

      final handler = _routes['$method:$path'];

      if (handler != null) {
        final response = await handler(request);
        if (response is Map) {
          request.response
            ..headers.set('Content-Type', 'application/json')
            ..write(jsonEncode(response))
            ..close();
            log.succesRes(method);
        } else {
          request.response
            ..write(response)
            ..close();
          log.succesRes(method);
        }
      } else {
        request.response
          ..statusCode = 404
          ..write('404 Not Found')
          ..close();
        log.errorRes(method, '404 Not Found');
      }
    }
  }
}