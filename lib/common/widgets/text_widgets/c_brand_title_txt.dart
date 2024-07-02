import 'package:duara_ecommerce/utils/constants/enums.dart';
import 'package:flutter/material.dart';

class CBrandTitleTxt extends StatelessWidget {
  const CBrandTitleTxt({
    super.key,
    this.color,
    required this.title,
    this.maxLines = 1,
    this.txtAlign = TextAlign.center,
    this.brandTxtSizes = CTextSizes.small,
  });

  final Color? color;
  final String title;
  final int maxLines;
  final TextAlign? txtAlign;
  final CTextSizes brandTxtSizes;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: txtAlign,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,

      // check which brand size is required and set as deemed fit
      style: brandTxtSizes == CTextSizes.small
          ? Theme.of(context).textTheme.labelSmall!.apply(color: color)
          : brandTxtSizes == CTextSizes.medium
              ? Theme.of(context).textTheme.labelMedium!.apply(color: color)
              : brandTxtSizes == CTextSizes.large
                  ? Theme.of(context).textTheme.labelLarge!.apply(color: color)
                  : Theme.of(context).textTheme.bodyMedium!.apply(color: color),
    );
  }
}
