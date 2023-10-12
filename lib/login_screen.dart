import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:login_form/greeting_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'package:login_form/style_form_login.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() {
    return _LoginScreenState();
  }
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isObscuredText = true;

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void pageRoute(String token) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString('token', token);

    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const GreetingScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'assets/images/sign_in_icon.png',
                width: 50,
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Sign In To Continue',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              const SizedBox(
                height: 60,
              ),
              StyleFormLogin(
                TextFormField(
                  controller: _usernameController,
                  decoration: const InputDecoration(
                    hintText: 'Username',
                    border: InputBorder.none,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your username';
                    }
                    if (!RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(value)) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              StyleFormLogin(
                TextFormField(
                  controller: _passwordController,
                  obscureText: _isObscuredText,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _isObscuredText = !_isObscuredText;
                          });
                        },
                        icon: Icon(_isObscuredText
                            ? Icons.visibility
                            : Icons.visibility_off)),
                    hintText: 'Password',
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  minimumSize: const Size(300, 50),
                ),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Processing Data')),
                    );
                    String username = _usernameController.text;
                    String password = _passwordController.text;

                    Map<String, dynamic> credentials = {
                      'username': username,
                      'password': password,
                    };

                    final url = Uri.https(
                        'api.flutter.simple2b.net', '/api/auth/token');
                    final response = await http.post(
                      url,
                      headers: {
                        'Content-Type': 'application/json',
                        'Accept': 'application/json',
                      },
                      body: json.encode(credentials),
                    );

                    if (response.statusCode == 200) {
                      final body = jsonDecode(response.body);
                      pageRoute(body['access_token']);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Login Failed')),
                      );
                    }
                  }
                },
                child: const Text('Log In'),
              ),
              TextButton(
                onPressed: () {},
                child: const Text(
                  'Lost Password',
                  style: TextStyle(
                      color: Color.fromARGB(255, 15, 15, 15),
                      decoration: TextDecoration.underline),
                ),
              ),
              const SizedBox(
                height: 100,
              ),
              const SizedBox(
                width: 150,
                child: Divider(
                  color: Colors.black,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Don\'t have an account?'),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(
                          color: Color.fromARGB(255, 15, 15, 15),
                          decoration: TextDecoration.underline),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
