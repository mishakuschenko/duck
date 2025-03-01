import 'package:duck/duck.dart' as dk;

void main() async {
  final app = dk.Duck();

  app.get('/', (request) async {
    return {'status': 'ok'};
  });
  app.post('/', (request) async {
    return 'You sent: ${await dk.getBody(request)}\n';
  }); 

  // Пример XML-ответа
  app.get('/xml', (request) async => '<xml><message>hello world</message></xml>');

  await app.start(host: 'localhost', port: 1209);
}