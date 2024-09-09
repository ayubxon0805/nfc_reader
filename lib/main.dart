// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:real_nfc_reader/home.dart';
import 'package:real_nfc_reader/passport_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NFC Reader',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}
