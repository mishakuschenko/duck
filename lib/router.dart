/// Маршрутизатор для обработки HTTP-запросов с поддержкой параметризованных путей.
///
/// Позволяет регистрировать обработчики для различных HTTP-методов и путей,
/// включая динамические сегменты вида `/users/:id`.
///
/// {@category HTTP Routing}
class Router {
  /// Внутреннее хранилище маршрутов в формате:
  /// { HTTP_METHOD: { path: handler } }
  final Map<String, Map<String, Function>> _routes = {};

  /// Регистрирует новый маршрут с автоматической нормализацией пути.
  ///
  /// Удаляет завершающий слэш в пути для предотвращения дублирования.
  /// Регистрозависимо для методов HTTP (GET != get).
  ///
  /// Пример:
  /// ```dart
  /// router.addRoute('GET', '/users', getUsers);
  /// router.addRoute('POST', '/users/:id', updateUser);
  /// ```
  void addRoute(String method, String path, Function handler) {
    path = path.endsWith('/') ? path.substring(0, path.length - 1) : path;
    _routes.putIfAbsent(method, () => {})[path] = handler;
  }

  /// Ищет подходящий обработчик для запроса с поддержкой параметризованных путей.
  ///
  /// Выполняет:
  /// 1. Нормализацию пути запроса (удаление завершающего слэша)
  /// 2. Поиск по точному совпадению метода и пути
  /// 3. Сопоставление параметризованных сегментов (вида `:param`)
  ///
  /// Возвращает обработчик и сохраняет параметры, доступные через [getParams].
  ///
  /// {@macro route_matching}
  Function? findHandler(String method, String requestPath) {
    final routes = _routes[method] ?? {};
    
    requestPath = requestPath.endsWith('/') 
        ? requestPath.substring(0, requestPath.length - 1) 
        : requestPath;

    for (var routePath in routes.keys) {
      final routeSegments = routePath.split('/');
      final requestSegments = requestPath.split('/');

      if (routeSegments.length != requestSegments.length) continue;

      bool match = true;
      final params = <String, String>{};

      for (var i = 0; i < routeSegments.length; i++) {
        final routeSegment = routeSegments[i];
        final requestSegment = requestSegments[i];

        if (routeSegment.startsWith(':')) {
          params[routeSegment.substring(1)] = requestSegment;
        } else if (routeSegment != requestSegment) {
          match = false;
          break;
        }
      }

      if (match) {
        _lastParams = params;
        return routes[routePath];
      }
    }
    
    return null;
  }

  /// Возвращает параметры из последнего успешного сопоставления маршрута.
  ///
  /// Пример:
  /// ```dart
  /// // Для пути `/users/123` и маршрута `/users/:id`
  /// final params = router.getParams(); // {'id': '123'}
  /// ```
  Map<String, String> getParams() => _lastParams ?? {};
  Map<String, String> _lastParams = {};
}