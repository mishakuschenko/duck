import 'dart:convert';

Future<String> jsonResponse(Map<String, dynamic> response) async {
  return jsonEncode(response);
}
