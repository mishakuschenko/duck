import 'dart:io';

/// A simple router class that maps HTTP methods and paths to their corresponding handlers.
///
/// This class allows registering handlers for different HTTP methods (GET, POST, PUT, DELETE)
/// and retrieving the appropriate handler for a given method and path.
class Router {
  final Map<String, Function(HttpRequest)> _routes = {};

  /// Registers a handler for a GET request at the given path.
  ///
  /// [path] - the path where the handler will be registered.
  /// [handler] - a function that will be called when a GET request is received.
  /// It accepts a [HttpRequest] object and can use it to process the request.
  void get(String path, Function(HttpRequest) handler) {
    _routes['GET:$path'] = handler;
  }

  /// Registers a handler for a POST request at the given path.
  ///
  /// [path] - the path where the handler will be registered.
  /// [handler] - a function that will be called when a POST request is received.
  /// It accepts a [HttpRequest] object and can use it to process the request.
  void post(String path, Function(HttpRequest) handler) {
    _routes['POST:$path'] = handler;
  }

  /// Registers a handler for a PUT request at the given path.
  ///
  /// [path] - the path where the handler will be registered.
  /// [handler] - a function that will be called when a PUT request is received.
  /// It accepts a [HttpRequest] object and can use it to process the request.
  void put(String path, Function(HttpRequest) handler) {
    _routes['PUT:$path'] = handler;
  }

  /// Registers a handler for a DELETE request at the given path.
  ///
  /// [path] - the path where the handler will be registered.
  /// [handler] - a function that will be called when a DELETE request is received.
  /// It accepts a [HttpRequest] object and can use it to process the request.
  void delete(String path, Function(HttpRequest) handler) {
    _routes['DELETE:$path'] = handler;
  }

  /// Retrieves the handler for a given HTTP method and path.
  ///
  /// [method] - the HTTP method (e.g., GET, POST, PUT, DELETE).
  /// [path] - the path for which the handler is being retrieved.
  ///
  /// Returns the registered handler for the specified method and path, or `null` if no handler is found.
  Function(HttpRequest)? getHandler(String method, String path) {
    return _routes['$method:$path'];
  }
}