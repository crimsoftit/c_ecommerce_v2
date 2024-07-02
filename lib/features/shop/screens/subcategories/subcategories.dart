import 'package:duara_ecommerce/common/widgets/appbar/appbar.dart';
import 'package:duara_ecommerce/common/widgets/img_widgets/c_rounded_img.dart';
import 'package:duara_ecommerce/common/widgets/products/product_cards/p_card_horizontal.dart';
import 'package:duara_ecommerce/common/widgets/shimmers/horizontal_products_shimmer.dart';
import 'package:duara_ecommerce/common/widgets/text_widgets/section_headings.dart';
import 'package:duara_ecommerce/features/shop/controllers/categories_controller.dart';
import 'package:duara_ecommerce/features/shop/models/categories_model.dart';
import 'package:duara_ecommerce/features/shop/screens/all_products/all_products.dart';
import 'package:duara_ecommerce/utils/constants/colors.dart';
import 'package:duara_ecommerce/utils/constants/image_strings.dart';
import 'package:duara_ecommerce/utils/constants/sizes.dart';
import 'package:duara_ecommerce/utils/helpers/cloud_helper_functions.dart';
import 'package:duara_ecommerce/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CSubCategoriesScreen extends StatelessWidget {
  const CSubCategoriesScreen({
    super.key,
    required this.category,
  });

  final CCategoriesModel category;

  @override
  Widget build(BuildContext context) {
    final isDarkTheme = CHelperFunctions.isDarkMode(context);

    final catsController = CCatsController.instance;

    return Scaffold(
      // -- appBar --
      appBar: CAppBar(
        showBackArrow: true,
        backIconColor: isDarkTheme ? CColors.white : CColors.rBrown,
        title: Text(
          category.cName,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),

      // -- body --
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(CSizes.defaultSpace),
          child: Column(
            children: [
              // banner
              const CRoundedImages(
                width: double.infinity,
                imgUrl: CImages.promoBanner5,
                applyImgRadius: true,
              ),
              const SizedBox(
                height: CSizes.spaceBtnSections,
              ),

              // sub-categories
              FutureBuilder(
                future: catsController.fetchSubCategories(category.id),
                builder: (context, snapshot) {
                  // handle loading, no record, and(or) data fetch error
                  const loader = CHorizontalProductShimmer();
                  final widget =
                      CCloudHelperFunctions.checkMultipleRecordsState(
                    snapshot: snapshot,
                    loader: loader,
                  );

                  if (widget != null) return widget;

                  // record found
                  final subCategories = snapshot.data!;

                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: subCategories.length,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (_, index) {
                      final subCategory = subCategories[index];

                      return FutureBuilder(
                          future: catsController.fetchProductsByCategory(
                            categoryId: subCategory.id,
                          ),
                          builder: (context, snapshot) {
                            // handle loading, no record, and(or) data fetch error
                            final widget =
                                CCloudHelperFunctions.checkMultipleRecordsState(
                              snapshot: snapshot,
                              loader: loader,
                            );

                            if (widget != null) return widget;

                            // record found
                            final products = snapshot.data!;

                            return Column(
                              children: [
                                // heading
                                CSectionHeading(
                                  showActionBtn: true,
                                  title: subCategory.cName,
                                  btnTitle: 'view all',
                                  editFontSize: false,
                                  onPressed: () {
                                    Get.to(
                                      () => CAllProducts(
                                        title: subCategory.cName,
                                        futureMethod: catsController
                                            .fetchProductsByCategory(
                                          categoryId: subCategory.id,
                                          limit: -1,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                const SizedBox(
                                  height: CSizes.spaceBtnItems / 2,
                                ),

                                SizedBox(
                                  height: 120.0,
                                  child: ListView.separated(
                                    itemCount: products.length,
                                    scrollDirection: Axis.horizontal,
                                    separatorBuilder: (context, index) {
                                      return const SizedBox(
                                        width: CSizes.spaceBtnItems,
                                      );
                                    },
                                    itemBuilder: (context, index) {
                                      return CProductCardHorizontal(
                                        product: products[index],
                                      );
                                    },
                                  ),
                                ),
                                const SizedBox(
                                  height: CSizes.spaceBtnSections,
                                ),
                              ],
                            );
                          });
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
