import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final controller;
  final String hintText;
  final bool obscureText;

  const MyTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
      decoration: InputDecoration(
        prefix: const SizedBox(width: 20),
        suffix: const SizedBox(width: 20),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xFFFFFFFF)),
          borderRadius: BorderRadius.circular(100),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xFFFFFFFF)),
          borderRadius: BorderRadius.circular(100),
        ),
        filled: true,
        fillColor: const Color(0xFFFFFFFF),
        hintText: hintText,
        hintStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Color.fromARGB(70, 71, 71, 71),
        ),
      ),
    );
  }
}
