import 'package:duck/duck.dart';

void main() async {
  final app = Duck();

  // GET request
  app.get('/hello/:userName/', (req, res) {
    final userName = req.params['userName'];
    res.html(200, '<h1>Hello, $userName!</h1>');
  });

  // POST request
  app.post('/data', (req, res) async {
    final body = await req.body;
    res.json(200, {'received': body});
  });

  // PUT request with params
  app.put('/user/:id', (req, res) async {
    final id = req.params['id'];
    final body = await req.body;
    res.json(200, {'updated_user': id, 'data': body});
  });

  // DELETE request
  app.delete('/resource/:id', (req, res) {
    final id = req.params['id'];
    res.json(200, {'deleted': id});
  });

  await app.start(); // Default -> http://localhost:1209/
}