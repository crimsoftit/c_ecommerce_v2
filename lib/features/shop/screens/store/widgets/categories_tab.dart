import 'package:duara_ecommerce/common/widgets/layouts/grid_layout.dart';
import 'package:duara_ecommerce/common/widgets/products/product_cards/p_card_vert.dart';
import 'package:duara_ecommerce/common/widgets/shimmers/vertical_product_shimmer.dart';
import 'package:duara_ecommerce/common/widgets/text_widgets/section_headings.dart';
import 'package:duara_ecommerce/features/shop/controllers/categories_controller.dart';
import 'package:duara_ecommerce/features/shop/models/categories_model.dart';
import 'package:duara_ecommerce/features/shop/screens/all_products/all_products.dart';
import 'package:duara_ecommerce/features/shop/screens/store/widgets/category_brands.dart';
import 'package:duara_ecommerce/utils/constants/sizes.dart';
import 'package:duara_ecommerce/utils/helpers/cloud_helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class CCategoriesTab extends StatelessWidget {
  const CCategoriesTab({
    super.key,
    required this.category,
  });

  final CCategoriesModel category;

  @override
  Widget build(BuildContext context) {
    final catsController = CCatsController.instance;

    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        Padding(
          padding: const EdgeInsets.all(CSizes.defaultSpace),
          child: Column(
            children: [
              // -- brands --
              CCategoryBrands(category: category),
              const SizedBox(
                height: CSizes.spaceBtnItems,
              ),

              // -- products --
              FutureBuilder(
                  future: catsController.fetchProductsByCategory(
                      categoryId: category.id),
                  builder: (context, snapshot) {
                    // helper function: handle loader, no data, and errored data
                    final response =
                        CCloudHelperFunctions.checkMultipleRecordsState(
                      snapshot: snapshot,
                      loader: const CVerticalProductShimmer(itemCount: 8),
                    );

                    if (response != null) return response;

                    // record found!
                    final cProducts = snapshot.data!;

                    return Column(
                      children: [
                        CSectionHeading(
                          showActionBtn: true,
                          title: 'you might also like...',
                          btnTitle: 'view all',
                          editFontSize: false,
                          onPressed: () {
                            Get.to(
                              CAllProducts(
                                title: category.cName,
                                futureMethod:
                                    catsController.fetchProductsByCategory(
                                        categoryId: category.id, limit: -1),
                              ),
                            );
                          },
                        ),
                        const SizedBox(
                          height: CSizes.spaceBtnItems,
                        ),
                        CGridLayout(
                          itemCount: cProducts.length,
                          itemBuilder: (_, index) {
                            return CProductCardVertical(
                              product: cProducts[index],
                            );
                          },
                        ),
                      ],
                    );
                  }),
            ],
          ),
        ),
      ],
    );
  }
}
