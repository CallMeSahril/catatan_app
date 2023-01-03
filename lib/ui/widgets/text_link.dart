import 'package:flutter/material.dart';

class TextLink extends StatelessWidget {
  const TextLink(
    this.text, {
    Key? key,
    this.onTap,
    this.align = TextAlign.center,
    this.fontSize = 12,
  }) : super(key: key);

  final String text;
  final VoidCallback? onTap;
  final TextAlign align;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        text,
        textAlign: align,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
