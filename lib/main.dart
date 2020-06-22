import 'package:flutter/material.dart';
import 'package:skive/page/home_client.dart'
    if (dart.library.js) 'package:skive/page/home_web.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'SKIVE',
    theme: ThemeData.dark(),
    home: HomePage(),
  ));
}
