import 'package:duara_ecommerce/common/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:duara_ecommerce/common/widgets/custom_shapes/containers/search_container.dart';
import 'package:duara_ecommerce/common/widgets/layouts/grid_layout.dart';
import 'package:duara_ecommerce/common/widgets/products/product_cards/p_card_vert.dart';
import 'package:duara_ecommerce/common/widgets/shimmers/vertical_product_shimmer.dart';
import 'package:duara_ecommerce/common/widgets/text_widgets/section_headings.dart';
import 'package:duara_ecommerce/features/personalization/screens/no_data/no_data.dart';
import 'package:duara_ecommerce/features/shop/controllers/product/products_controller.dart';
import 'package:duara_ecommerce/features/shop/screens/all_products/all_products.dart';
import 'package:duara_ecommerce/features/shop/screens/home/widgets/home_appbar.dart';
import 'package:duara_ecommerce/features/shop/screens/home/widgets/home_categories.dart';
import 'package:duara_ecommerce/features/shop/screens/home/widgets/promo_slider.dart';
import 'package:duara_ecommerce/utils/constants/colors.dart';
import 'package:duara_ecommerce/utils/constants/image_strings.dart';
import 'package:duara_ecommerce/utils/constants/sizes.dart';
import 'package:duara_ecommerce/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkTheme = CHelperFunctions.isDarkMode(context);

    final productsController = Get.put(CProductsController());

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            CPrimaryHeaderContainer(
              child: Column(
                children: [
                  // -- ## HOME PAGE APP BAR ## --
                  const CHomeAppBarWidget(),

                  const SizedBox(
                    height: CSizes.spaceBtnSections,
                  ),

                  // -- ## SEARCH BAR ## --
                  CSearchContainer(
                    text: 'search in store ...',
                    icon: Iconsax.search_favorite,
                    onTap: () {},
                  ),

                  const SizedBox(
                    height: CSizes.spaceBtnSections,
                  ),

                  // -- ## ALL ABOUT CATEGORIES ## --
                  const Padding(
                    padding: EdgeInsets.only(
                      left: CSizes.defaultSpace,
                    ),
                    child: Column(
                      children: [
                        // -- category heading --
                        CSectionHeading(
                          showActionBtn: false,
                          title: 'popular categories',
                          txtColor: CColors.white,
                          btnTitle: 'view all',
                          btnTxtColor: CColors.grey,
                          editFontSize: true,
                        ),
                        SizedBox(
                          height: CSizes.spaceBtnItems,
                        ),

                        // -- categories (ListView.builder) --
                        CHomeCategories(),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: CSizes.spaceBtnSections,
                  ),
                ],
              ),
            ),

            // -- ## BODY ## --
            Padding(
              padding: const EdgeInsets.all(CSizes.defaultSpace),
              child: Column(
                children: [
                  // -- promo slider --
                  const CPromoSlider(),

                  const SizedBox(
                    height: CSizes.spaceBtnSections,
                  ),

                  // -- popular products heading --
                  CSectionHeading(
                    showActionBtn: true,
                    title: 'popular products',
                    txtColor: isDarkTheme ? CColors.white : CColors.rBrown,
                    btnTitle: 'view all...',
                    btnTxtColor: CColors.darkerGrey,
                    onPressed: () {
                      Get.to(
                        () => CAllProducts(
                          title: 'popular products',
                          futureMethod:
                              productsController.fetchAllFeaturedProducts(),
                        ),
                      );
                    },
                    editFontSize: true,
                  ),
                  const SizedBox(
                    height: CSizes.spaceBtnItems,
                  ),

                  // -- popular products grid display --
                  Obx(
                    () {
                      if (productsController.isLoading.value) {
                        return const CVerticalProductShimmer(itemCount: 4);
                      } else {
                        if (productsController.featuredProducts.isEmpty) {
                          return const Center(
                            child: NoDataScreen(
                              lottieImage: CImages.noDataLottie,
                              txt: 'No data found!',
                            ),
                          );
                        } else {
                          return CGridLayout(
                            itemCount:
                                productsController.featuredProducts.length,
                            itemBuilder: (_, index) {
                              return CProductCardVertical(
                                product:
                                    productsController.featuredProducts[index],
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
          ],
        ),
      ),
    );
  }
}
