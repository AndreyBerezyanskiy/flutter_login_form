import 'package:flutter/material.dart';
import 'package:login_form/greeting_screen.dart';
import 'package:login_form/login_screen.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() {
    return _AppState();
  }
}

class _AppState extends State<App> {
  var activeScreen = 'login-screen';

  void switchedScreen() {
    setState(() {
      activeScreen =
          activeScreen == 'login-screen' ? 'greeting-screen' : 'login-screen';
    });
  }

  @override
  Widget build(context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          child: const LoginScreen(),
        ),
      ),
    );
  }
}
