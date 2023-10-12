import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GreetingScreen extends StatefulWidget {
  const GreetingScreen({super.key});

  @override
  State<GreetingScreen> createState() => _GreetingScreenState();
}

class _GreetingScreenState extends State<GreetingScreen> {
  String token = '';

  @override
  void initState() {
    super.initState();
    getCredentials();
  }

  void getCredentials() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      token = pref.getString('token')!;
    });
  }

  @override
  Widget build(context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/images/sitting.png',
              width: 200,
            ),
            const SizedBox(
              height: 40,
            ),
            const Text(
              'Welcome!',
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
                decoration: TextDecoration.none,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Your token is: $token',
              style: const TextStyle(
                fontSize: 20,
                color: Colors.black,
                decoration: TextDecoration.none,
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
                SharedPreferences pref = await SharedPreferences.getInstance();
                await pref.remove('token');
                Navigator.pop(context);
              },
              child: const Text('Log Out'),
            ),
          ],
        ),
      ),
    );
  }
}
