import 'package:duara_ecommerce/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:duara_ecommerce/common/widgets/img_widgets/c_rounded_img.dart';
import 'package:duara_ecommerce/common/widgets/products/favorite_icon/favorite_icon.dart';
import 'package:duara_ecommerce/common/widgets/text_widgets/c_brand_title_with_verified_icon.dart';
import 'package:duara_ecommerce/common/widgets/text_widgets/p_price_txt.dart';
import 'package:duara_ecommerce/common/widgets/text_widgets/product_title_texts.dart';
import 'package:duara_ecommerce/features/shop/controllers/product/products_controller.dart';
import 'package:duara_ecommerce/features/shop/models/product_model.dart';
import 'package:duara_ecommerce/utils/constants/colors.dart';
import 'package:duara_ecommerce/utils/constants/enums.dart';
import 'package:duara_ecommerce/utils/constants/sizes.dart';
import 'package:duara_ecommerce/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class CProductCardHorizontal extends StatelessWidget {
  const CProductCardHorizontal({
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

    return Container(
      width: 310,
      padding: const EdgeInsets.all(1),
      decoration: BoxDecoration(
        //boxShadow: [CShadowStyle.verticalProductShadow],
        borderRadius: BorderRadius.circular(CSizes.pImgRadius),
        color: isDark ? CColors.darkGrey : CColors.rBrown.withOpacity(0.1),
      ),
      child: Row(
        children: [
          // -- thumbnail --
          CRoundedContainer(
            height: 120.0,
            padding: const EdgeInsets.all(CSizes.sm),
            bgColor: isDark ? CColors.dark : CColors.rBrown.withOpacity(0.1),
            child: Stack(
              children: [
                // -- thumbnail image
                SizedBox(
                  width: 120,
                  height: 120.0,
                  child: CRoundedImages(
                    imgUrl: product.thumbnail,
                    applyImgRadius: true,
                    isNetworkImg: true,
                  ),
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
                        style: Theme.of(context).textTheme.labelSmall!.apply(
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

          // -- product details --
          SizedBox(
            width: 172.0,
            child: Padding(
              padding: const EdgeInsets.only(
                top: CSizes.sm,
                left: CSizes.sm,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CProductTitleText(
                        title: product.pName,
                        smallSize: true,
                      ),
                      const SizedBox(
                        height: CSizes.spaceBtnItems / 2,
                      ),
                      CBrandTitleWithVerifiedIcon(
                        title: product.pBrand!.brandName,
                      ),
                    ],
                  ),
                  // const SizedBox(
                  //   height: CSizes.spaceBtnSections,
                  // ),
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
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelMedium!
                                      .apply(
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
                                price: productController
                                    .fetchProductPrice(product),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // add item to cart button
                      Container(
                        width: 30.0,
                        height: 30.0,
                        decoration: const BoxDecoration(
                          color: CColors.rBrown,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(
                              CSizes.cardRadiusMd,
                            ),
                            bottomRight: Radius.circular(
                              CSizes.pImgRadius,
                            ),
                          ),
                        ),
                        child: const SizedBox(
                          width: CSizes.iconLg * 1.2,
                          height: CSizes.iconLg * 1.2,
                          child: Center(
                            child: Icon(
                              Iconsax.add,
                              color: CColors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     // -- pricing
                  //     const Flexible(
                  //       child: CProductPriceText(
                  //         price: '26,000.00 - 30,000.00',
                  //       ),
                  //     ),

                  //     // -- add item to cart button
                  //     Container(
                  //       width: 30.0,
                  //       height: 30.0,
                  //       decoration: const BoxDecoration(
                  //         color: CColors.rBrown,
                  //         borderRadius: BorderRadius.only(
                  //           topLeft: Radius.circular(CSizes.cardRadiusMd),
                  //           bottomRight: Radius.circular(CSizes.pImgRadius),
                  //         ),
                  //       ),
                  //       child: const SizedBox(
                  //         width: CSizes.iconLg * 1.2,
                  //         height: CSizes.iconLg * 1.2,
                  //         child: Center(
                  //           child: Icon(
                  //             Iconsax.add,
                  //             color: CColors.white,
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
