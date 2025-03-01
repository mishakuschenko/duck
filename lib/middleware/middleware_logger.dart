import 'dart:io';
import 'middleware.dart';
import 'package:duck/status_codes.dart';
import 'package:duck/logger.dart';

class MiddlewareLogger implements Middleware {

  final _log = Logger();

  @override
  Future<void> handle(HttpRequest request, Function next) async {
    final code = request.response.statusCode;
    final method = request.method;

    if (successCodes.contains(code)) {
      _log.succesRes(method);
    } else {
      _log.errorRes(method);
    }
  }
}