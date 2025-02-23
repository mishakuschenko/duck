import 'dart:io';
import 'duck.dart';
import 'json.dart';
import 'middleware.dart';

void main() async {
  final app = Duck();

  app.get('/', (HttpRequest request) async => jsonResponse({
    "data": "any text",
    "status": 200,
  }));

  app.use(LoggingMiddleware());

  app.start();
}
