import 'package:duara_ecommerce/utils/constants/colors.dart';
import 'package:duara_ecommerce/utils/constants/sizes.dart';
import 'package:duara_ecommerce/utils/device/device_utility.dart';
import 'package:duara_ecommerce/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class CSearchContainer extends StatelessWidget {
  const CSearchContainer({
    super.key,
    required this.text,
    this.icon,
    this.showBg = true,
    this.showBorder = true,
    this.onTap,
    this.padding = const EdgeInsets.symmetric(
      horizontal: CSizes.defaultSpace,
    ),
  });

  final String text;
  final IconData? icon;
  final VoidCallback? onTap;
  final bool showBg, showBorder;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final isDark = CHelperFunctions.isDarkMode(context);

    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: padding,
        child: Container(
          width: CDeviceUtils.getScreenWidth(context),
          padding: const EdgeInsets.all(CSizes.md),
          decoration: BoxDecoration(
            color: showBg
                ? isDark
                    ? CColors.dark
                    : CColors.light
                : Colors.transparent,
            borderRadius: BorderRadius.circular(CSizes.cardRadiusLg),
            border: showBorder
                ? Border.all(
                    color: CColors.grey,
                  )
                : null,
          ),
          child: Row(
            children: [
              Icon(
                icon,
                color: CColors.darkGrey,
              ),
              const SizedBox(
                width: CSizes.spaceBtnItems,
              ),
              Text(
                text,
                style: Theme.of(context).textTheme.bodySmall!.apply(
                      color: CColors.darkGrey,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
