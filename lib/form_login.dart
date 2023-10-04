import 'package:flutter/material.dart';
import 'package:login_form/style_form_login.dart';

class FormLogin extends StatefulWidget {
  const FormLogin({super.key});

  @override
  State<FormLogin> createState() {
    return _FormLoginState();
  }
}

class _FormLoginState extends State<FormLogin> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isObscuredText = true;
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
                  obscureText: _isObscuredText,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    if (value.length < 8) {
                      return 'Password must be at least 8 characters';
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
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Processing Data')),
                    );
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
