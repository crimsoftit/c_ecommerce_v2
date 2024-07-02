import 'package:flutter/material.dart';

class CTabMenuHeadings extends StatelessWidget {
  const CTabMenuHeadings({
    super.key,
    required this.title,
    this.fontSize = 12,
  });

  final String title;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
