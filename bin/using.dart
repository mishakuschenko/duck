import 'dart:convert';

import 'package:duck/duck.dart';

void main() async {
  final app = Duck();

  app.get('/hello', (request) async {
    return 'hello world';
  });

  app.get('/json', (request) async {
    return {
      'status': 'ok',
      'code': 200,
      'info': {
        'isHappy': true,
        'balance': 123.23,
      },
    };
  });

  app.post('/echo', (request) async {
    final body = await utf8.decodeStream(request);
    return 'You sent: $body\n';
  });

  app.start();
}
