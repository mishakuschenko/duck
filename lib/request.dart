import 'dart:async';
import 'dart:io';
import 'dart:convert';

Future<String> getBody(HttpRequest request) async {
  return await utf8.decoder.bind(request).join(); 
}