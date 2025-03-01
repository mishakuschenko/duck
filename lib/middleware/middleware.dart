import 'dart:io';

abstract class Middleware {
  Future<void> handle(HttpRequest request, Function next);
}