import 'package:cached_network_image/cached_network_image.dart';
import 'package:duara_ecommerce/common/widgets/brands/c_brand_cards.dart';
import 'package:duara_ecommerce/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:duara_ecommerce/common/widgets/shimmers/shimmer_effect.dart';
import 'package:duara_ecommerce/features/shop/models/brands_model.dart';
import 'package:duara_ecommerce/features/shop/screens/brands/brand_products.dart';
import 'package:duara_ecommerce/utils/constants/colors.dart';
import 'package:duara_ecommerce/utils/constants/sizes.dart';
import 'package:duara_ecommerce/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CBrandsShowcase extends StatelessWidget {
  const CBrandsShowcase({
    super.key,
    required this.productImages,
    required this.brand,
  });

  final CBrandModel brand;

  final List<String> productImages;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(() => CBrandProducts(brand: brand));
      },
      child: CRoundedContainer(
        showBorder: true,
        borderColor: CColors.rBrown,
        bgColor: Colors.transparent,
        padding: const EdgeInsets.all(
          CSizes.md,
        ),
        margin: const EdgeInsets.only(
          bottom: CSizes.spaceBtnItems,
        ),
        child: Column(
          children: [
            // brand with products count
            CBrandCard(
              showBorder: false,
              brand: brand,
            ),
            const SizedBox(
              height: CSizes.spaceBtnItems,
            ),

            // brand top 3 product images
            Row(
              children: productImages
                  .map((pImg) => brandTopProductsImgWidget(pImg, context))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget brandTopProductsImgWidget(String img, context) {
    final isDarkTheme = CHelperFunctions.isDarkMode(context);
    return Expanded(
      child: CRoundedContainer(
        height: 100.0,
        bgColor: isDarkTheme ? CColors.darkerGrey : CColors.light,
        margin: const EdgeInsets.only(
          right: CSizes.sm,
        ),
        padding: const EdgeInsets.all(
          CSizes.md,
        ),
        child: CachedNetworkImage(
          fit: BoxFit.contain,
          imageUrl: img,
          progressIndicatorBuilder: (context, url, progress) =>
              const CShimmerEffect(
            width: 100.0,
            height: 100.0,
          ),
          errorWidget: (context, url, error) => const Icon(
            Icons.error,
          ),
        ),
      ),
    );
  }
}
