import 'package:banco_douro/ui/login_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const BancoDouroApp());
}

class BancoDouroApp extends StatelessWidget {
  const BancoDouroApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen()

    );
  }
  
}