import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:duara_ecommerce/common/widgets/appbar/appbar.dart';
import 'package:duara_ecommerce/common/widgets/products/sortable_items/c_sortable_items.dart';
import 'package:duara_ecommerce/common/widgets/shimmers/vertical_product_shimmer.dart';
import 'package:duara_ecommerce/features/personalization/screens/no_data/no_data.dart';
import 'package:duara_ecommerce/features/shop/controllers/product/all_products_controller.dart';
import 'package:duara_ecommerce/features/shop/models/product_model.dart';
import 'package:duara_ecommerce/utils/constants/colors.dart';
import 'package:duara_ecommerce/utils/constants/image_strings.dart';
import 'package:duara_ecommerce/utils/constants/sizes.dart';
import 'package:duara_ecommerce/utils/helpers/cloud_helper_functions.dart';
import 'package:duara_ecommerce/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CAllProducts extends StatelessWidget {
  const CAllProducts({
    super.key,
    required this.title,
    this.query,
    this.futureMethod,
  });

  final String title;
  final Query? query;
  final Future<List<CProductModel>>? futureMethod;

  @override
  Widget build(BuildContext context) {
    final isDarkTheme = CHelperFunctions.isDarkMode(context);

    final allProductsController = Get.put(CAllProductsController());

    return Scaffold(
      // -- appBar --
      appBar: CAppBar(
        showBackArrow: true,
        backIconColor: isDarkTheme ? CColors.white : CColors.rBrown,
        title: Text(
          title,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),

      // -- body --
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(CSizes.defaultSpace),
          child: FutureBuilder(
              future: futureMethod ??
                  allProductsController.fetchProductsByQuery(query),
              builder: (context, snapshot) {
                // check the state of the FutureBuilder snapshot
                const loader = CVerticalProductShimmer(itemCount: 4);

                const noData = Center(
                  child: NoDataScreen(
                    lottieImage: CImages.noDataLottie,
                    txt: 'No data found!',
                  ),
                );

                final widget = CCloudHelperFunctions.checkMultipleRecordsState(
                  snapshot: snapshot,
                  loader: loader,
                  noData: noData,
                );

                if (widget != null) return widget;

                // products found!
                final products = snapshot.data!;

                return CSortableItems(
                  allProducts: products,
                );
              }),
        ),
      ),
    );
  }
}
