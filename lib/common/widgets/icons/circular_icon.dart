import 'package:duara_ecommerce/utils/constants/colors.dart';
import 'package:duara_ecommerce/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class CCircularIcon extends StatelessWidget {
  const CCircularIcon({
    super.key,
    this.width,
    this.height,
    this.size,
    required this.icon,
    this.color,
    this.bgColor,
    this.onPressed,
  });

  final double? width, height, size;
  final IconData icon;
  final Color? color, bgColor;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final isDark = CHelperFunctions.isDarkMode(context);

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.transparent,
        ),
        borderRadius: BorderRadius.circular(100),
        //color: Colors.transparent,
        color: bgColor != null
            ? bgColor!
            : isDark
                ? CColors.rBrown.withOpacity(0.6)
                : CColors.white.withOpacity(0.9),
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(
          icon,
          color: color,
          size: size,
        ),
      ),
    );
  }
}
