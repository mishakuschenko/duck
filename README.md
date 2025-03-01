<h1><h1>В РАЗРАБОТКЕ, В PUB.DEV НЕ ОПУБЛИКОВАН</h1></h1>

<h1>Duck — это простой веб-фреймворк на языке Dart для создания HTTP-серверов. Он поддерживает методы GET, POST, PUT, DELETE и позволяет легко работать с JSON.</h1>

Быстрый старт

Создайте простой сервер с помощью Duck:

```
import 'package:duck/duck.dart';

void main() async {
  final app = Duck('localhost', 8080);

  app.get('/', (request) async {
    return {'status': 'ok'};
  });

  app.start(); // По умолчанию - http://localhost:8080/
}
```

Теперь сервер будет доступен по адресу http://localhost:8080/.
