import 'package:flutter/material.dart';
import 'package:skive/page/home.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'SKIVE',
    theme: ThemeData.dark(),
    home: HomePage(),
  ));
}
