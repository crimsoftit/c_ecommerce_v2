import 'package:duara_ecommerce/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:duara_ecommerce/common/widgets/img_widgets/c_circular_img.dart';
import 'package:duara_ecommerce/common/widgets/text_widgets/c_brand_title_with_verified_icon.dart';
import 'package:duara_ecommerce/features/shop/models/brands_model.dart';
import 'package:duara_ecommerce/utils/constants/colors.dart';
import 'package:duara_ecommerce/utils/constants/enums.dart';
import 'package:duara_ecommerce/utils/constants/sizes.dart';
import 'package:duara_ecommerce/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class CBrandCard extends StatelessWidget {
  const CBrandCard({
    super.key,
    required this.showBorder,
    this.onTap,
    required this.brand,
  });

  /// -- variables --
  final CBrandModel brand;

  final bool showBorder;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final isDarkTheme = CHelperFunctions.isDarkMode(context);
    return GestureDetector(
      onTap: onTap,
      child: CRoundedContainer(
        padding: const EdgeInsets.all(CSizes.sm),
        showBorder: showBorder,
        bgColor: Colors.transparent,
        child: Row(
          children: [
            // icon
            Flexible(
              child: CCircularImg(
                isNetworkImg: true,
                img: brand.brandImage,
                bgColor: Colors.transparent,
                overlayColor: isDarkTheme ? CColors.white : CColors.rBrown,
              ),
            ),

            const SizedBox(
              width: CSizes.spaceBtnItems / 8,
            ),

            // text for popular brands
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CBrandTitleWithVerifiedIcon(
                    title: brand.brandName,
                    brandTxtSize: CTextSizes.small,
                  ),
                  Text(
                    '${brand.pCount ?? 0} products',
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
