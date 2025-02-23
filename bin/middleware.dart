import 'dart:io';
import 'package:duck/logger.dart';
import 'package:duck/status_codes.dart';


abstract class Middleware {
  Future<void> handle(HttpRequest request, Function next);
}

class LoggingMiddleware implements Middleware {
  final log = Logger();
  @override
  Future<void> handle(HttpRequest request, Function next) async {
    if (request.response.statusCode == 200) {
      log.succesRes('test succes message');
      await next();
    } else if (httpErrorStatusCodes.contains(request.response.statusCode)) {
      log.errorRes(request.method, 'test succes message');
      await next();
    }
  }
}