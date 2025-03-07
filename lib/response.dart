import 'dart:io';
import 'dart:convert';

/// Класс для отправки HTTP-ответов с поддержкой различных форматов данных.
///
/// Обертывает [HttpResponse] и предоставляет удобные методы для отправки ответов
/// с автоматической установкой Content-Type и сериализацией данных.
class Response {
  final HttpResponse _response;

  /// Создает экземпляр Response, связанный с заданным [HttpResponse].
  ///
  /// Пример:
  /// ```dart
  /// final response = Response(request.response);
  /// ```
  Response(this._response);

  /// Отправляет HTTP-ответ с автоматическим определением типа контента.
  ///
  /// Устанавливает статус-код и отправляет данные:
  /// - Для [String] устанавливает Content-Type: text/html
  /// - Для [Map] сериализует в JSON и устанавливает Content-Type: application/json
  ///
  /// После отправки ответ закрывается. Данные других типов игнорируются.
  ///
  /// Пример:
  /// ```dart
  /// response.send(200, {'message': 'Success'}); // Отправит JSON
  /// response.send(404, '<h1>Not Found</h1>');  // Отправит HTML
  /// ```
  void send(int statusCode, dynamic data) {
    _response.statusCode = statusCode;
    
    if (data is String) {
      _response.headers.contentType = ContentType.html;
      _response.write(data);
    } else if (data is Map) {
      _response.headers.contentType = ContentType.json;
      _response.write(jsonEncode(data));
    }
    
    _response.close();
  }

  /// Отправляет JSON-ответ с указанным статус-кодом.
  ///
  /// Автоматически:
  /// - Устанавливает Content-Type: application/json
  /// - Сериализует [data] в JSON-строку
  ///
  /// Пример:
  /// ```dart
  /// response.json(200, {'status': 'ok', 'data': [1, 2, 3]});
  /// ```
  void json(int statusCode, Map data) {
    _response
      ..statusCode = statusCode
      ..headers.contentType = ContentType.json
      ..write(jsonEncode(data))
      ..close();
  }

  /// Отправляет HTML-ответ с указанным статус-кодом.
  ///
  /// Автоматически устанавливает Content-Type: text/html.
  ///
  /// Пример:
  /// ```dart
  /// response.html(200, '<html><body>Hello World!</body></html>');
  /// ```
  void html(int statusCode, String html) {
    _response
      ..statusCode = statusCode
      ..headers.contentType = ContentType.html
      ..write(html)
      ..close();
  }
}