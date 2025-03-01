import 'dart:io';
import 'dart:async';
import 'router.dart';
import 'response_handler.dart';
import 'logger.dart';

class Duck {
  final Router _router = Router();
  final Logger _log = Logger();
  final ResponseHandler _responseHandler = ResponseHandler();

  void get(String path, Function(HttpRequest) handler) {
    _router.get(path, handler);
  }

  void post(String path, Function(HttpRequest) handler) {
    _router.post(path, handler);
  }

  void put(String path, Function(HttpRequest) handler) {
    _router.put(path, handler);
  }

  void delete(String path, Function(HttpRequest) handler) {
    _router.delete(path, handler);
  }

  Future<void> start({String host = 'localhost', int port = 1209}) async {
    final server = await HttpServer.bind(host, port);
    _log.startServer(info: 'Server start at:', host: host, port: port);

    await for (var request in server) {
      final path = request.uri.path;
      final method = request.method;

      final handler = _router.getHandler(method, path);

      if (handler != null) {
        final response = await handler(request);
        _responseHandler.handleResponse(request, response);
        _log.succesRes(method);
      } else {
        request.response
          ..statusCode = 404
          ..write('404 Not Found')
          ..close();
        _log.errorRes(method, '404 Not Found');
      }
    }
  }
}