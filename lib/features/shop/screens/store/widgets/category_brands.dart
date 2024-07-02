import 'package:duara_ecommerce/common/widgets/brands/brands_showcase.dart';
import 'package:duara_ecommerce/common/widgets/shimmers/boxes_shimmer.dart';
import 'package:duara_ecommerce/common/widgets/shimmers/list_tile_shimmer.dart';
import 'package:duara_ecommerce/features/shop/controllers/brands_controller.dart';
import 'package:duara_ecommerce/features/shop/models/categories_model.dart';
import 'package:duara_ecommerce/utils/constants/sizes.dart';
import 'package:duara_ecommerce/utils/helpers/cloud_helper_functions.dart';
import 'package:flutter/material.dart';

class CCategoryBrands extends StatelessWidget {
  const CCategoryBrands({
    super.key,
    required this.category,
  });

  final CCategoriesModel category;

  @override
  Widget build(BuildContext context) {
    final brandsController = CBrandsController.instance;

    return FutureBuilder(
      future: brandsController.fetchCategorySpecificBrands(category.id),
      builder: (context, snapshot) {
        // handle loader, no record, or error msg
        const loader = Column(
          children: [
            CListTileShimmer(),
            SizedBox(
              height: CSizes.spaceBtnItems,
            ),
            CBoxesShimmer(),
          ],
        );

        final widget = CCloudHelperFunctions.checkMultipleRecordsState(
          snapshot: snapshot,
          loader: loader,
        );

        if (widget != null) return widget;

        // record found
        final brands = snapshot.data!;

        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: brands.length,
          itemBuilder: (_, index) {
            final brand = brands[index];

            return FutureBuilder(
              future: brandsController.fetchBrandSpecificProducts(
                brandId: brand.id,
                limit: 3,
              ),
              builder: (context, snapshot) {
                // handle loader, no record, or error msg

                final widget = CCloudHelperFunctions.checkMultipleRecordsState(
                  snapshot: snapshot,
                  loader: loader,
                );

                if (widget != null) return widget;

                // record found
                final brandProducts = snapshot.data!;

                return CBrandsShowcase(
                  brand: brand,
                  productImages: brandProducts.map((e) => e.thumbnail).toList(),
                );
              },
            );
          },
        );
      },
    );
  }
}
