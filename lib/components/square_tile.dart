import 'package:flutter/material.dart';

class SquareTile extends StatelessWidget {
  final String imagePath;
  final Function()? onTap;
  const SquareTile({
    super.key, 
    required this.imagePath,
    required this.onTap,
    });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(
            color: const Color(0xffffffff),
          ),
          borderRadius: BorderRadius.circular(16),
          color: Colors.white,
        ),
        child: Image.asset(imagePath,
        height: 40,),
      ),
    );
  }
}