import 'dart:io';
import 'package:duck/utils/logger.dart';

import 'router.dart';
import 'request.dart';
import 'response.dart';

class Duck {
  final Logger _log = Logger();
  final Router _router = Router();

  void get(String path, Function handler) {
    _router.addRoute('GET', path, handler);
  }

  void post(String path, Function handler) {
    _router.addRoute('POST', path, handler);
  }

  void put(String path, Function handler) {
    _router.addRoute('PUT', path, handler);
  }

  void delete(String path, Function handler) {
    _router.addRoute('DELETE', path, handler);
  }

  Future<void> start({int port = 1209, String host = 'localhost'}) async {
    final server = await HttpServer.bind(host, port);
    _log.startServer(info: 'Server running in: ', host: host, port: port);

    await for (HttpRequest request in server) {
      _handleRequest(request);
    }
  }

  void _handleRequest(HttpRequest request) async {
  final method = request.method;
  final path = request.uri.path;

  final handler = _router.findHandler(method, path);
  final params = _router.getParams(); // Получаем параметры

  if (handler == null) {
    Response(request.response).send(HttpStatus.notFound, 'Not Found');
    return;
  }

  final req = Request(request)
    ..params = params;
  final res = Response(request.response);

  try {
    await handler(req, res);
  } catch (e) {
    res.send(HttpStatus.internalServerError, 'Server Error');
  }
}
}