import 'package:flutter/material.dart';

class StyleFormLogin extends StatelessWidget {
  const StyleFormLogin(this.widget, {super.key});

  final Widget widget;

  @override
  Widget build(context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      width: 300,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: Colors.grey[200],
      ),
      child: widget,
    );
  }
}
