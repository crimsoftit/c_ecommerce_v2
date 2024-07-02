import 'package:duara_ecommerce/common/widgets/text_widgets/section_headings.dart';
import 'package:duara_ecommerce/features/shop/models/product_model.dart';
import 'package:duara_ecommerce/features/shop/screens/p_details/widgets/add_to_cart_bottom_nav.dart';
import 'package:duara_ecommerce/features/shop/screens/p_details/widgets/p_attributes.dart';
import 'package:duara_ecommerce/features/shop/screens/p_details/widgets/p_details_img_slider.dart';
import 'package:duara_ecommerce/features/shop/screens/p_details/widgets/p_metadata.dart';
import 'package:duara_ecommerce/features/shop/screens/p_details/widgets/rating_share_widget.dart';
import 'package:duara_ecommerce/features/shop/screens/p_reviews/p_reviews.dart';
import 'package:duara_ecommerce/utils/constants/colors.dart';
import 'package:duara_ecommerce/utils/constants/enums.dart';
import 'package:duara_ecommerce/utils/constants/sizes.dart';
import 'package:duara_ecommerce/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:readmore/readmore.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({
    super.key,
    required this.product,
  });

  final CProductModel product;

  @override
  Widget build(BuildContext context) {
    final isDarkTheme = CHelperFunctions.isDarkMode(context);

    return Scaffold(
      // -- bottom nav bar --
      bottomNavigationBar: CAddToCartBottomNavBar(
        product: product,
      ),

      // -- body --
      body: SingleChildScrollView(
        child: Column(
          children: [
            // -- product image slider with appBar --
            CProductImgSlider(
              product: product,
            ),

            // -- product details display --
            Padding(
              padding: const EdgeInsets.only(
                right: CSizes.defaultSpace,
                left: CSizes.defaultSpace,
                bottom: CSizes.defaultSpace,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // - rating & share button

                  const CProductRatingWidget(),

                  // - price, title, stock, and brand
                  CProductMetaData(
                    product: product,
                  ),

                  // - product attributes
                  if (product.productType == CProductType.variable.toString())
                    CProductAttributes(
                      product: product,
                    ),
                  if (product.productType == CProductType.variable.toString())
                    const SizedBox(
                      height: CSizes.spaceBtnSections / 3,
                    ),

                  // - checkout button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text(
                        'checkout'.toUpperCase(),
                        style: Theme.of(context).textTheme.labelMedium?.apply(
                              color: CColors.white,
                            ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: CSizes.spaceBtnSections,
                  ),

                  // - product description
                  const CSectionHeading(
                    showActionBtn: false,
                    title: 'description',
                    btnTitle: '',
                    editFontSize: false,
                  ),
                  const SizedBox(
                    height: CSizes.spaceBtnItems,
                  ),

                  ReadMoreText(
                    '${product.pDescription ?? ''} ',
                    trimLines: 2,
                    trimMode: TrimMode.Line,
                    trimCollapsedText: ' show more',
                    trimExpandedText: ' less',
                    moreStyle: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      fontStyle: FontStyle.italic,
                      color: isDarkTheme
                          ? CColors.rBrown
                          : CColors.rBrown.withOpacity(0.5),
                    ),
                    lessStyle: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      fontStyle: FontStyle.italic,
                      color: isDarkTheme
                          ? CColors.rBrown
                          : CColors.rBrown.withOpacity(0.4),
                    ),
                  ),

                  const Divider(),
                  const SizedBox(
                    height: CSizes.spaceBtnItems,
                  ),

                  // - reviews
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 10,
                        child: CSectionHeading(
                          showActionBtn: false,
                          title: 'reviews (1999)',
                          btnTitle: 'view all',
                          editFontSize: true,
                          onPressed: () {},
                        ),
                      ),
                      Expanded(
                        //flex: 10,
                        child: IconButton(
                          onPressed: () {
                            Get.to(const ProductReviewsScreen());
                          },
                          icon: Icon(
                            Iconsax.arrow_right_34,
                            size: 18.0,
                            color: isDarkTheme ? CColors.white : CColors.rBrown,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: CSizes.spaceBtnSections,
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
