import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

//const apiUrl = 'https://skive.skimproj.com/api/';
//const apiUrl = 'http://127.0.0.1:8080/';
const apiUrl = 'https://backend.skimproj.com/';

String language = 'en';

const resultSuccess = 1;
const resultFailed = 2;
const resultError = 3;

Future<Map<String, dynamic>> getApi(String api,
    Map<String, dynamic> params) async {
  var paramsCombine = '';
  params.forEach((key, value) {
    paramsCombine += '&$key=$value';
  });
  if (paramsCombine.isNotEmpty) {
    paramsCombine = '?' + paramsCombine.substring(1);
  }
  var response = await http.get(apiUrl + api + paramsCombine);
  return jsonDecode(response.body);
}

Future<Map<String, dynamic>> postApi(String api,
    Map<String, dynamic> body) async {
  var response = await http.post(apiUrl + api,
      headers: {HttpHeaders.contentTypeHeader: 'application/json'},
      body: jsonEncode(body));
  return jsonDecode(response.body);
}