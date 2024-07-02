import 'package:duara_ecommerce/common/styles/shadows.dart';
import 'package:duara_ecommerce/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:duara_ecommerce/common/widgets/img_widgets/c_rounded_img.dart';
import 'package:duara_ecommerce/common/widgets/products/favorite_icon/favorite_icon.dart';
import 'package:duara_ecommerce/common/widgets/products/product_cards/add_2_cart_btn_widget.dart';
import 'package:duara_ecommerce/common/widgets/text_widgets/c_brand_title_with_verified_icon.dart';
import 'package:duara_ecommerce/common/widgets/text_widgets/p_price_txt.dart';
import 'package:duara_ecommerce/common/widgets/text_widgets/product_title_texts.dart';
import 'package:duara_ecommerce/features/shop/controllers/product/products_controller.dart';
import 'package:duara_ecommerce/features/shop/models/product_model.dart';
import 'package:duara_ecommerce/features/shop/screens/p_details/p_details.dart';
import 'package:duara_ecommerce/utils/constants/colors.dart';
import 'package:duara_ecommerce/utils/constants/enums.dart';
import 'package:duara_ecommerce/utils/constants/sizes.dart';
import 'package:duara_ecommerce/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CProductCardVertical extends StatelessWidget {
  const CProductCardVertical({
    super.key,
    required this.product,
  });

  final CProductModel product;

  @override
  Widget build(BuildContext context) {
    final isDark = CHelperFunctions.isDarkMode(context);

    final productController = CProductsController.instance;

    final discount = productController.calculateDiscountPercentage(
        product.pPrice, product.salePrice);

    return GestureDetector(
      onTap: () {
        Get.to(() => ProductDetailsScreen(product: product));
      },
      child: Container(
        width: 180,
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          boxShadow: [CShadowStyle.verticalProductShadow],
          borderRadius: BorderRadius.circular(CSizes.pImgRadius),
          color: isDark ? CColors.darkGrey : CColors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // -- thumbnail, wishlist button, and discount tag --
            Center(
              child: CRoundedContainer(
                height: 130,
                //width: 130,
                padding: const EdgeInsets.all(CSizes.sm),
                //bgColor: isDark ? CColors.dark : CColors.light,
                child: Stack(
                  children: [
                    // thumbnail image
                    CRoundedImages(
                      imgUrl: product.thumbnail,
                      applyImgRadius: true,
                      isNetworkImg: true,
                      width: 180,
                      padding: const EdgeInsets.all(2.0),
                      //height: 120,
                    ),

                    // sale tag
                    if (discount != null)
                      Positioned(
                        top: 12.0,
                        child: CRoundedContainer(
                          radius: CSizes.sm,
                          bgColor: CColors.secondary.withOpacity(0.8),
                          padding: const EdgeInsets.symmetric(
                            horizontal: CSizes.sm,
                            vertical: CSizes.xs,
                          ),
                          child: Text(
                            '$discount%',
                            style:
                                Theme.of(context).textTheme.labelSmall!.apply(
                                      color: CColors.black,
                                      //fontSizeFactor: 0.7,
                                    ),
                          ),
                        ),
                      ),

                    // favorite icon button
                    Positioned(
                      top: 0,
                      right: 0,
                      child: CFavoriteIcon(
                        productId: product.id,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: CSizes.spaceBtnItems / 4,
            ),

            // -- product details --
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: CSizes.sm,
              ),

              // sizedbox used to make column full-width
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CProductTitleText(
                      title: product.pName,
                      smallSize: false,
                      txtAlign: TextAlign.left,
                    ),
                    const SizedBox(
                      height: CSizes.spaceBtnItems / 4,
                    ),
                    CBrandTitleWithVerifiedIcon(
                      title: product.pBrand!.brandName,
                    ),
                  ],
                ),
              ),
            ),

            const Spacer(),

            // -- product price and add item to cart button --
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // price
                Flexible(
                  child: Column(
                    children: [
                      if (product.productType ==
                              CProductType.single.toString() &&
                          product.salePrice > 0)
                        Padding(
                          padding: const EdgeInsets.only(
                            left: CSizes.sm,
                          ),
                          child: Text(
                            product.pPrice.toString(),
                            style:
                                Theme.of(context).textTheme.labelMedium!.apply(
                                      decoration: TextDecoration.lineThrough,
                                    ),
                          ),
                        ),

                      // display sale price if discount exists
                      Padding(
                        padding: const EdgeInsets.only(
                          left: CSizes.sm,
                        ),
                        child: CProductPriceText(
                          price: productController.fetchProductPrice(product),
                        ),
                      ),
                    ],
                  ),
                ),

                // add item to cart button
                CProductCardAddToCartButton(
                  product: product,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
