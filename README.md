<h2>Duck</h2>
<h1>Simple dart web-framework for creating HTTP-servers</h1>

```dart
// Quick start:
import 'package:duck/duck.dart' as dk;

void main() async {
  // Class instance:
  final app = dk.Duck();

  // Get request:
  app.get('/', (request) async {
    return {
      'status': 'ok'
    }; // Map<> is automatically converted to json
  });

  // Post request:
  app.post('/', (request) async {
    return 'You sent: ${await dk.getBody(request)}\n'; 
  }); 

  await app.start(host: 'localhost', port: 1209); // Default - http://localhost:1209/
```