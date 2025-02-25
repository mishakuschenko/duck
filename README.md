<h1><h1>В РАЗРАБОТКЕ</h1></h1>

<h1>Duck — это простой веб-фреймворк на языке Dart для создания HTTP-серверов. Он поддерживает методы GET, POST, PUT, DELETE и позволяет легко работать с JSON.</h1>

Быстрый старт

Создайте простой сервер с помощью Duck:

```
import 'dart:io';
import 'package:duck/duck.dart';

void main() async {
  final app = Duck('localhost', 8080);

  app.get('/', (request) async {
    return 'Hello, World!';
  });

  app.start(); // По умолчанию - http://localhost:8080/
}
```

Теперь сервер будет доступен по адресу http://localhost:8080/.

Способ работы с JSON:
```
app.get('/json', (request) async {
    return {
      'status': 'ok',
      'code': 200,
      'info': {
        'isHappy': true,
        'balance': 123.23,
      },
    };
  }); // Передавайте обычную карту, автоматическая декодировка в JSON
```  