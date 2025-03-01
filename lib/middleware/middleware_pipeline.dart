import 'dart:io';
import 'middleware.dart';

class MiddlewarePipeline {
  final List<Middleware> _middlewares = [];

  void add(Middleware middleware) {
    _middlewares.add(middleware);
  }

  Future<void> execute(HttpRequest request, Function(HttpRequest) handler) async {
    int index = 0;

    Future<void> next() async {
      if (index < _middlewares.length) {
          final middleware = _middlewares[index++];
          await middleware.handle(request, next);
        } else {
          await handler(request);
      }
    }
    await next();
  }
}