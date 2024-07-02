import 'package:duara_ecommerce/common/widgets/img_widgets/c_circular_img.dart';
import 'package:duara_ecommerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class CVerticalImgTxt extends StatelessWidget {
  const CVerticalImgTxt({
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
    //final isDark = CHelperFunctions.isDarkMode(context);

    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(
          right: CSizes.spaceBtnItems,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // -- circular icon --
            CCircularImg(
              img: img,
              width: 74.0,
              height: 74.0,
              fit: BoxFit.fill,
              padding: CSizes.sm * 1.4,
              isNetworkImg: isNetworkImage,
              bgColor: bgColor,
            ),

            const SizedBox(
              height: CSizes.spaceBtnItems / 4,
            ),

            // -- categories texts --
            SizedBox(
              width: 60.0,
              child: Text(
                title,
                style: Theme.of(context).textTheme.labelMedium!.apply(
                      color: txtColor,
                    ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
