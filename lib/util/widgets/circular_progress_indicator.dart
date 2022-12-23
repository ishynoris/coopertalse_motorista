import 'package:flutter/material.dart';

class CircularProgressCustom extends StatelessWidget {
  final double size;
  final double sizeLine;
  final Color? color;
  final EdgeInsetsGeometry? margin;

  const CircularProgressCustom({
    super.key, 
    required this.size,
    required this.sizeLine,
    this.color,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: this.size,
      width: this.size,
      child: Container (
        margin: this.margin,
        child: CircularProgressIndicator(strokeWidth: this.sizeLine, color: this.color)
      )
    );
  }
}