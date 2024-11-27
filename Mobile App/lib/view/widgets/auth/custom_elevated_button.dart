import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final String label;
  final Color backgroundColor;
  final BorderRadiusGeometry borderRadius;
  final Function() onPressed; // Use Function() instead of VoidCallback

  const CustomElevatedButton({
    super.key,
    required this.label,
    required this.backgroundColor,
    required this.borderRadius,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed, // Pass the function here
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: borderRadius,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 24,
        ),
      ),
    );
  }
}
