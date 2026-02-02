import 'package:banco_douro/ui/home_screen.dart';
import 'package:banco_douro/ui/login_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const BancoDouroApp());
}

class BancoDouroApp extends StatelessWidget {
  const BancoDouroApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
      routes: {
        "login": (context) => LoginScreen(),
        "home": (context) => const HomeScreen(),
      },
      initialRoute: "login",
    );
  }
}
