import 'dart:io';
import 'dart:async';
import 'router.dart';
import 'response_handler.dart';
import 'utils/logger.dart';

/// A simple HTTP server class that allows registering handlers for different HTTP methods
/// (GET, POST, PUT, DELETE) and starting the server on a specified host and port.
///
/// The server uses a router to handle incoming requests, a logger to track server events,
/// and a response handler to manage server responses.
class Duck {
  final Router _router = Router();
  final Logger _log = Logger();
  final ResponseHandler _responseHandler = ResponseHandler();
  //final MiddlewarePipeline _middlewarePipeline = MiddlewarePipeline();

  /// Registers a handler for a GET request at the given path.
  ///
  /// [path] - the path where the handler will be registered.
  /// [handler] - a function that will be called when a GET request is received.
  /// It accepts a [HttpRequest] object and can use it to process the request.
  void get(String path, Function(HttpRequest) handler) {
    _router.get(path, handler);
  }

  /// Registers a handler for a POST request at the given path.
  ///
  /// [path] - the path where the handler will be registered.
  /// [handler] - a function that will be called when a POST request is received.
  /// It accepts a [HttpRequest] object and can use it to process the request.
  void post(String path, Function(HttpRequest) handler) {
    _router.post(path, handler);
  }

  /// Registers a handler for a PUT request at the given path.
  ///
  /// [path] - the path where the handler will be registered.
  /// [handler] - a function that will be called when a PUT request is received.
  /// It accepts a [HttpRequest] object and can use it to process the request.
  void put(String path, Function(HttpRequest) handler) {
    _router.put(path, handler);
  }

  /// Registers a handler for a DELETE request at the given path.
  ///
  /// [path] - the path where the handler will be registered.
  /// [handler] - a function that will be called when a DELETE request is received.
  /// It accepts a [HttpRequest] object and can use it to process the request.
  void delete(String path, Function(HttpRequest) handler) {
    _router.delete(path, handler);
  }

  /// Starting a HTTP-server on specified host and port. Default -> http://localhost:1209/
  /// 
  /// [host] - hostname for server. Default - localhost
  /// [port] - port for server. Default - 1209
  /// 
  /// This function creates a server that processes incoming HTTP requests,
  /// registers them using the router and returns the corresponding responses.
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
        // await _middlewarePipeline.execute(request, handler);
      } else {
        request.response
          ..statusCode = 404
          ..write('404 Not Found')
          ..close();
        _log.errorRes(method);
      }
    }
  }
}