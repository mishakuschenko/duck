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

  await app.start();
}