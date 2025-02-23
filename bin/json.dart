import 'dart:convert';

Future<String> jsonResponse(Map<dynamic, dynamic> response) async {
  return jsonEncode(response);
}
