<h1><h1>В РАЗРАБОТКЕ, В PUB.DEV НЕ ОПУБЛИКОВАН</h1></h1>

<h1>Duck — это простой веб-фреймворк на языке Dart для создания HTTP-серверов. Он поддерживает методы GET, POST, PUT, DELETE и позволяет легко работать с JSON.</h1>

Быстрый старт

Создайте простой сервер с помощью Duck:

```
import 'package:duck/duck.dart';

void main() async {
  final app = Duck();

  app.get('/test', (request) async {
    return {'status': 'ok'};
  });
  app.post('/test', (request) async => 'hello world');
  app.put('/test', (request) async => 'hello world');
  app.delete('/test', (request) async => 'hello world');

  // Пример XML-ответа
  app.get('/xml', (request) async => '<xml><message>hello world</message></xml>');

  await app.start(); // По умолчанию - http://localhost:1209/
}
```

Теперь сервер будет доступен по адресу http://localhost:1209/.
