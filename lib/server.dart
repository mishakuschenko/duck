import 'dart:io';
import 'package:duck/utils/logger.dart';

import 'router.dart';
import 'request.dart';
import 'response.dart';

/// Основной класс сервера Duck для обработки HTTP-запросов.
///
/// Обеспечивает:
/// - Регистрацию маршрутов для различных HTTP-методов
/// - Запуск HTTP-сервера
/// - Автоматическую маршрутизацию запросов
/// - Обработку ошибок
///
/// {@category Core}
class Duck {
  final Logger _log = Logger();
  final Router _router = Router();

  /// Регистрирует обработчик для GET-запросов.
  ///
  /// Пример:
  /// ```dart
  /// app.get('/users', (req, res) {
  ///   res.json(200, {'users': ['Alice', 'Bob']});
  /// });
  /// ```
  void get(String path, Function handler) {
    _router.addRoute('GET', path, handler);
  }

  /// Регистрирует обработчик для POST-запросов.
  ///
  /// Пример:
  /// ```dart
  /// app.post('/submit', (req, res) async {
  ///   final data = await req.json();
  ///   res.send(200, 'Received: ${data['message']}');
  /// });
  /// ```
  void post(String path, Function handler) {
    _router.addRoute('POST', path, handler);
  }

  /// Регистрирует обработчик для PUT-запросов.
  ///
  /// Пример:
  /// ```dart
  /// app.put('/users/:id', (req, res) {
  ///   final id = req.params['id'];
  ///   res.json(200, {'status': 'Updated user $id'});
  /// });
  /// ```
  void put(String path, Function handler) {
    _router.addRoute('PUT', path, handler);
  }

  /// Регистрирует обработчик для DELETE-запросов.
  ///
  /// Пример:
  /// ```dart
  /// app.delete('/cache', (req, res) {
  ///   clearCache();
  ///   res.send(204);
  /// });
  /// ```
  void delete(String path, Function handler) {
    _router.addRoute('DELETE', path, handler);
  }

  /// Запускает HTTP-сервер на указанном хосте и порту.
  ///
  /// По умолчанию:
  /// - Хост: localhost
  /// - Порт: 1209
  ///
  /// {@macro server_lifecycle}
  Future<void> start({int port = 1209, String host = 'localhost'}) async {
    final server = await HttpServer.bind(host, port);
    _log.startServer(info: 'Server running in: ', host: host, port: port);

    await for (HttpRequest request in server) {
      _handleRequest(request);
    }
  }

  /// Обрабатывает входящие HTTP-запросы.
  ///
  /// Выполняет:
  /// 1. Поиск соответствующего обработчика
  /// 2. Извлечение параметров маршрута
  /// 3. Вызов пользовательского обработчика
  /// 4. Обработку исключений
  ///
  /// {@macro request_lifecycle}
  void _handleRequest(HttpRequest request) async {
    final method = request.method;
    final path = request.uri.path;

    final handler = _router.findHandler(method, path);
    final params = _router.getParams();

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
      _log.errorRes('Request failed: $e');
      res.send(HttpStatus.internalServerError, 'Server Error');
    }
  }
}