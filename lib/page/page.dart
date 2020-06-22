import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

const apiUrl = 'https://skive.skimproj.com/api/';
//const apiUrl = 'http://127.0.0.1:8080/';

String language = 'en';

Row appBarTitle(String text, State state) => Row(
      children: [
        Text(text),
        SizedBox(width: 20),
        DropdownButton(
          value: language,
          onChanged: (value) {
            state.setState(() => language = value);
          },
          items: [
            DropdownMenuItem(
              child: Text('en'),
              value: 'en',
            ),
            DropdownMenuItem(
              child: Text('简体中文'),
              value: 'zh-CN',
            )
          ],
        )
      ],
    );

const resultSuccess = 1;
const resultFailed = 2;
const resultError = 3;

Future<Map<String, dynamic>> getApi(
    String api, Map<String, dynamic> params) async {
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

Future<Map<String, dynamic>> postApi(
    String api, Map<String, dynamic> body) async {
  var response = await http.post(apiUrl + api,
      headers: {HttpHeaders.contentTypeHeader: 'application/json'},
      body: jsonEncode(body));
  return jsonDecode(response.body);
}
