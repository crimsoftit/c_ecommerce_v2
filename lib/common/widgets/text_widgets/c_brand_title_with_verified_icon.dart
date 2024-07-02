import 'package:duara_ecommerce/common/widgets/text_widgets/c_brand_title_txt.dart';
import 'package:duara_ecommerce/utils/constants/colors.dart';
import 'package:duara_ecommerce/utils/constants/enums.dart';
import 'package:duara_ecommerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class CBrandTitleWithVerifiedIcon extends StatelessWidget {
  const CBrandTitleWithVerifiedIcon({
    super.key,
    required this.title,
    this.maxLines = 1,
    this.txtColor,
    this.iconColor = CColors.rBrown,
    this.txtAlign = TextAlign.center,
    this.brandTxtSize = CTextSizes.small,
  });

  final String title;
  final int maxLines;
  final Color? txtColor, iconColor;
  final TextAlign? txtAlign;
  final CTextSizes brandTxtSize;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: CBrandTitleTxt(
            title: title,
            color: txtColor,
            maxLines: maxLines,
            txtAlign: txtAlign,
            brandTxtSizes: brandTxtSize,
          ),
        ),
        const SizedBox(
          width: CSizes.sm,
        ),
        Icon(
          Iconsax.verify5,
          color: iconColor,
          size: CSizes.iconXs,
        ),
      ],
    );
  }
}
