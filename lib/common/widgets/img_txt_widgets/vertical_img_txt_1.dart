import 'package:duara_ecommerce/utils/constants/colors.dart';
import 'package:duara_ecommerce/utils/constants/sizes.dart';
import 'package:duara_ecommerce/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class CVerticalImgTxt1 extends StatelessWidget {
  const CVerticalImgTxt1({
    super.key,
    required this.img,
    required this.title,
    required this.txtColor,
    this.bgColor,
    this.isNetworkImage = true,
    this.onTap,
  });

  final String img, title;
  final Color txtColor;
  final Color? bgColor;
  final bool isNetworkImage;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final isDark = CHelperFunctions.isDarkMode(context);

    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(
          right: CSizes.spaceBtnItems,
        ),
        child: Column(
          children: [
            // -- circular icon --
            Container(
              width: 56.0,
              height: 56.0,
              padding: const EdgeInsets.all(CSizes.sm),
              decoration: BoxDecoration(
                color: bgColor ?? (isDark ? CColors.darkerGrey : CColors.white),
                borderRadius: BorderRadius.circular(100),
              ),
              child: Center(
                child: Image(
                  image: AssetImage(img),
                  fit: BoxFit.cover,
                  color: CColors.rBrown,
                ),
              ),
            ),

            const SizedBox(
              height: CSizes.spaceBtnItems / 2,
            ),

            // -- categories texts --
            SizedBox(
              width: 55,
              child: Text(
                title,
                style: Theme.of(context).textTheme.labelMedium!.apply(
                      color: txtColor,
                    ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
