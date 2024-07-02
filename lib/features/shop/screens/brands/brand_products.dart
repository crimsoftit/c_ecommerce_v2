import 'package:duara_ecommerce/common/widgets/appbar/appbar.dart';
import 'package:duara_ecommerce/common/widgets/brands/c_brand_cards.dart';
import 'package:duara_ecommerce/common/widgets/products/sortable_items/c_sortable_items.dart';
import 'package:duara_ecommerce/common/widgets/shimmers/vertical_product_shimmer.dart';
import 'package:duara_ecommerce/features/personalization/screens/data_error/data_error.dart';
import 'package:duara_ecommerce/features/shop/controllers/brands_controller.dart';
import 'package:duara_ecommerce/features/shop/models/brands_model.dart';
import 'package:duara_ecommerce/utils/constants/colors.dart';
import 'package:duara_ecommerce/utils/constants/image_strings.dart';
import 'package:duara_ecommerce/utils/constants/sizes.dart';
import 'package:duara_ecommerce/utils/helpers/cloud_helper_functions.dart';
import 'package:duara_ecommerce/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class CBrandProducts extends StatelessWidget {
  const CBrandProducts({
    super.key,
    required this.brand,
  });

  final CBrandModel brand;

  @override
  Widget build(BuildContext context) {
    final isDarkTheme = CHelperFunctions.isDarkMode(context);

    final bController = CBrandsController.instance;

    return Scaffold(
      // -- appBar --
      appBar: CAppBar(
        showBackArrow: true,
        backIconColor: isDarkTheme ? CColors.white : CColors.rBrown,
        title: Text(
          brand.brandName,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),

      // -- body --
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(CSizes.defaultSpace),
          child: Column(
            children: [
              // -- brand details
              CBrandCard(
                showBorder: true,
                brand: brand,
              ),
              const SizedBox(
                height: CSizes.spaceBtnSections,
              ),

              FutureBuilder(
                future: bController.fetchBrandSpecificProducts(
                    brandId: brand.id, limit: 3),
                builder: (context, snapshot) {
                  // handle loader, no db record, data error msg
                  const loader = CVerticalProductShimmer(itemCount: 4);

                  const errorWidget = Center(
                    child: DataErrorScreen(
                      lottieImage: CImages.errorDataLottie,
                      txt: 'something went wrong!',
                    ),
                  );

                  final helperWidget =
                      CCloudHelperFunctions.checkMultipleRecordsState(
                    snapshot: snapshot,
                    loader: loader,
                    error: errorWidget,
                  );

                  if (helperWidget != null) return helperWidget;

                  // db record found
                  final brandProducts = snapshot.data!;

                  return CSortableItems(
                    allProducts: brandProducts,
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
