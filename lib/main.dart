import 'package:flutter/material.dart';
import 'package:parcsmart_driver/login_provider/sign_up_page.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(primarySwatch: Colors.teal),
    home: const SignUpPage(),
  ));
}
