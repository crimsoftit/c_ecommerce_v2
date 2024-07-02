import 'package:duara_ecommerce/common/widgets/appbar/appbar.dart';
import 'package:duara_ecommerce/common/widgets/brands/c_brand_cards.dart';
import 'package:duara_ecommerce/common/widgets/layouts/grid_layout.dart';
import 'package:duara_ecommerce/common/widgets/shimmers/brands_shimmer.dart';
import 'package:duara_ecommerce/common/widgets/text_widgets/section_headings.dart';
import 'package:duara_ecommerce/features/personalization/screens/no_data/no_data.dart';
import 'package:duara_ecommerce/features/shop/controllers/brands_controller.dart';
import 'package:duara_ecommerce/features/shop/screens/brands/brand_products.dart';
import 'package:duara_ecommerce/utils/constants/colors.dart';
import 'package:duara_ecommerce/utils/constants/image_strings.dart';
import 'package:duara_ecommerce/utils/constants/sizes.dart';
import 'package:duara_ecommerce/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CAllBrandsScreen extends StatelessWidget {
  const CAllBrandsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkTheme = CHelperFunctions.isDarkMode(context);

    final brandsController = CBrandsController.instance;

    return Scaffold(
      // -- appBar --
      appBar: CAppBar(
        showBackArrow: true,
        backIconColor: isDarkTheme ? CColors.white : CColors.rBrown,
        title: Text(
          'Brands',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),

      // -- body --
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(CSizes.defaultSpace),
          child: Column(
            children: [
              // -- heading --
              const CSectionHeading(
                showActionBtn: false,
                title: 'popular brands',
                btnTitle: '',
                editFontSize: false,
              ),

              const SizedBox(
                height: CSizes.spaceBtnItems,
              ),

              // -- brands grid layout display --

              Obx(
                () {
                  if (brandsController.isLoading.value) {
                    return const CbrandsShimmer(
                      itemCount: 4,
                    );
                  } else {
                    if (brandsController.allBrands.isEmpty) {
                      return const Center(
                        child: NoDataScreen(
                          lottieImage: CImages.noDataLottie,
                          txt: 'No data found!',
                        ),
                      );
                    } else {
                      return CGridLayout(
                        itemCount: brandsController.allBrands.length,
                        mainAxisExtent: 80,
                        itemBuilder: (_, index) {
                          final brand = brandsController.allBrands[index];
                          return CBrandCard(
                            showBorder: true,
                            onTap: () {
                              Get.to(() => CBrandProducts(
                                    brand: brand,
                                  ));
                            },
                            brand: brand,
                          );
                        },
                      );
                    }
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
