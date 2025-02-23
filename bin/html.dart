import 'dart:async';
import 'dart:io';

class HTMLResponse {
  final String name;

  HTMLResponse(this.name);

  Future<List<int>> get() async {
    final file = File(name);
    return await file.readAsBytes();
  }
}
