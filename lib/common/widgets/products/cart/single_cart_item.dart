import 'package:duara_ecommerce/common/widgets/img_widgets/c_rounded_img.dart';
import 'package:duara_ecommerce/common/widgets/text_widgets/c_brand_title_with_verified_icon.dart';
import 'package:duara_ecommerce/common/widgets/text_widgets/product_title_texts.dart';
import 'package:duara_ecommerce/features/shop/models/cart_item_model.dart';
import 'package:duara_ecommerce/utils/constants/colors.dart';
import 'package:duara_ecommerce/utils/constants/sizes.dart';
import 'package:duara_ecommerce/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class CSingleCartItem extends StatelessWidget {
  const CSingleCartItem({
    super.key,
    required this.cartItem,
  });

  final CCartItemModel cartItem;

  @override
  Widget build(BuildContext context) {
    final isDarkTheme = CHelperFunctions.isDarkMode(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // -- product image
        CRoundedImages(
          imgUrl: cartItem.pImg ?? '',
          width: 60.0,
          height: 60.0,
          isNetworkImg: true,
          padding: const EdgeInsets.all(CSizes.sm),
          bgColor:
              isDarkTheme ? CColors.rBrown.withOpacity(0.3) : CColors.light,
        ),
        const SizedBox(
          width: CSizes.spaceBtnItems,
        ),

        // -- product name/title, price, and size
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CBrandTitleWithVerifiedIcon(
                title: cartItem.brandName ?? '',
              ),
              Flexible(
                child: CProductTitleText(
                  title: cartItem.pName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),

              // product attributes
              Text.rich(
                TextSpan(
                  children: (cartItem.selectedVariation ?? {})
                      .entries
                      .map(
                        (e) => TextSpan(
                          children: [
                            TextSpan(
                              text: ' ${e.key} ',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            TextSpan(
                              text: ' ${e.value} ',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ],
                        ),
                      )
                      .toList(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
