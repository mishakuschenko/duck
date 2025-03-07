import 'dart:io';
import 'dart:convert';

/// Класс для работы с HTTP-запросами с поддержкой параметризованных маршрутов.
///
/// Обертывает [HttpRequest] и предоставляет удобный доступ к:
/// - Методу запроса
/// - Параметрам URL
/// - Телу запроса
/// - Параметрам маршрута (из Router)
///
/// {@category HTTP Handling}
class Request {
  /// Исходный объект [HttpRequest] из пакета dart:io
  final HttpRequest _request;
  
  /// Параметры маршрута, извлеченные из URL (например, {id: '123'} для пути '/users/:id')
  Map<String, String>? _params;

  /// Создает экземпляр Request на основе исходного [HttpRequest].
  ///
  /// Пример:
  /// ```dart
  /// final req = Request(httpRequest);
  /// ```
  Request(this._request);

  /// HTTP-метод запроса (GET, POST и т.д.).
  ///
  /// Всегда в верхнем регистре (например, 'GET', 'POST').
  String get method => _request.method;

  /// Полный URI запроса, включая query-параметры.
  ///
  /// Пример: `Uri(path: '/users', queryParameters: {'page': '2'})`
  Uri get uri => _request.uri;

  /// Query-параметры из URL.
  ///
  /// Для URL вида `/search?query=dart&page=2` вернет:
  /// ```dart
  /// {'query': 'dart', 'page': '2'}
  /// ```
  Map<String, String> get queryParameters => _request.uri.queryParameters;

  /// Асинхронно читает тело запроса как строку.
  ///
  /// Автоматически декодирует данные из UTF-8.
  ///
  /// Пример:
  /// ```dart
  /// final body = await req.body;
  /// final data = jsonDecode(body);
  /// ```
  Future<String> get body async {
    return await utf8.decoder.bind(_request).join();
  }

  /// Параметры маршрута, установленные через [Router].
  ///
  /// Доступны только после обработки запроса маршрутизатором.
  ///
  /// Пример:
  /// ```dart
  /// // Для маршрута '/users/:id' и URL '/users/123'
  /// final id = req.params['id']; // '123'
  /// ```
  Map<String, String> get params => _params ?? {};

  /// Устанавливает параметры маршрута (вызывается из [Router]).
  ///
  /// Используется для передачи параметров вида `:param` из URL.
  set params(Map<String, String> value) => _params = value;
}