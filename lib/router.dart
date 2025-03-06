class Router {
  final Map<String, Map<String, Function>> _routes = {};

  void addRoute(String method, String path, Function handler) {
    path = path.endsWith('/') ? path.substring(0, path.length - 1) : path;
    _routes.putIfAbsent(method, () => {})[path] = handler;
  }

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

  Map<String, String> getParams() => _lastParams ?? {};
  Map<String, String> _lastParams = {};
}