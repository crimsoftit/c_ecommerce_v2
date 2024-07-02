import 'package:flutter/material.dart';

class CProductTitleText extends StatelessWidget {
  const CProductTitleText({
    super.key,
    required this.title,
    this.smallSize = false,
    this.maxLines = 1,
    this.txtAlign = TextAlign.left,
    this.overflow = TextOverflow.ellipsis,
  });

  final String title;
  final bool smallSize;
  final int maxLines;
  final TextAlign? txtAlign;
  final TextOverflow? overflow;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: smallSize
          ? Theme.of(context).textTheme.labelSmall
          : Theme.of(context).textTheme.labelMedium,
      overflow: overflow,
      maxLines: maxLines,
      textAlign: txtAlign,
    );
  }
}
