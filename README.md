<h1><h1>В РАЗРАБОТКЕ</h1></h1>

<h1>Duck — это простой веб-фреймворк на языке Dart для создания HTTP-серверов. Он поддерживает методы GET, POST, PUT, DELETE и позволяет легко работать с JSON.</h1>

Быстрый старт

Создайте простой сервер с помощью Duck:

```
import 'dart:io';
import 'duck.dart';

void main() async {
  final app = Duck('localhost', 8080);

  app.get('/', (HttpRequest request) async {
    return jsonResponse({"message": "Hello, World!"});
  });

  app.start();
}
```

Теперь сервер будет доступен по адресу http://localhost:8080/.

