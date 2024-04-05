import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final Function()? onTap;

  const MyButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(37),
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xffb8d7e5), Color(0xffbae8d7)],
          ),
        ),
        width: 305,
        height: 58,
        child: const Center(
          child: Text(
            "Log in",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              height: 0.5,
              color: Color(0xff000000),
            ),
          ),
        ),
      ),
    );
  }
}
