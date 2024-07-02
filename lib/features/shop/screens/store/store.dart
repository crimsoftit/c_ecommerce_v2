import 'package:duara_ecommerce/common/widgets/appbar/appbar.dart';
import 'package:duara_ecommerce/common/widgets/appbar/c_tabbar.dart';
import 'package:duara_ecommerce/common/widgets/custom_shapes/containers/search_container.dart';
import 'package:duara_ecommerce/common/widgets/layouts/grid_layout.dart';
import 'package:duara_ecommerce/common/widgets/brands/c_brand_cards.dart';
import 'package:duara_ecommerce/common/widgets/products/cart/cart_menu_icon.dart';
import 'package:duara_ecommerce/common/widgets/shimmers/brands_shimmer.dart';
import 'package:duara_ecommerce/common/widgets/text_widgets/section_headings.dart';
import 'package:duara_ecommerce/features/personalization/screens/no_data/no_data.dart';
import 'package:duara_ecommerce/features/shop/controllers/brands_controller.dart';
import 'package:duara_ecommerce/features/shop/controllers/categories_controller.dart';
import 'package:duara_ecommerce/features/shop/screens/brands/all_brands.dart';
import 'package:duara_ecommerce/features/shop/screens/brands/brand_products.dart';
import 'package:duara_ecommerce/features/shop/screens/store/widgets/categories_tab.dart';
import 'package:duara_ecommerce/utils/constants/colors.dart';
import 'package:duara_ecommerce/utils/constants/image_strings.dart';
import 'package:duara_ecommerce/utils/constants/sizes.dart';
import 'package:duara_ecommerce/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class CStoreScreen extends StatelessWidget {
  const CStoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkTheme = CHelperFunctions.isDarkMode(context);
    final categories = CCatsController.instance.featuredCategories;

    final brandsController = Get.put(CBrandsController());

    //Get.put(CProductsController());

    return DefaultTabController(
      length: categories.length,
      child: Scaffold(
        backgroundColor: isDarkTheme ? CColors.dark : CColors.white,
        appBar: CAppBar(
          showBackArrow: true,
          backIconColor: isDarkTheme ? CColors.white : CColors.rBrown,
          title: Text(
            'me store',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          actions: [
            CCartCounterIcon(
              iconColor: isDarkTheme ? CColors.white : CColors.rBrown,
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: NestedScrollView(
            headerSliverBuilder: (_, innerBoxIsScrollable) {
              return [
                SliverAppBar(
                  automaticallyImplyLeading: false,
                  pinned: true,
                  floating: true,
                  backgroundColor: isDarkTheme ? CColors.dark : CColors.white,
                  expandedHeight: 440,
                  flexibleSpace: Padding(
                    padding: const EdgeInsets.all(CSizes.defaultSpace / 2),
                    //padding: const EdgeInsets.all(4.0),
                    child: ListView(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        // -- search bar --
                        // const SizedBox(
                        //   height: CSizes.spaceBtnItems / 4,
                        // ),
                        CSearchContainer(
                          text: 'search store',
                          icon: Iconsax.search_favorite,
                          showBg: false,
                          padding: EdgeInsets.zero,
                          onTap: () {},
                        ),
                        const SizedBox(
                          height: CSizes.spaceBtnSections / 4,
                        ),

                        // -- featured brands --
                        CSectionHeading(
                          showActionBtn: true,
                          title: 'featured brands',
                          btnTitle: 'view all',
                          btnTxtColor: CColors.darkGrey,
                          onPressed: () {
                            Get.to(() => const CAllBrandsScreen());
                          },
                          editFontSize: true,
                          fSize: 13,
                        ),
                        const SizedBox(
                          height: CSizes.spaceBtnItems / 4,
                        ),

                        // -- brands grid layout display --
                        Obx(
                          () {
                            if (brandsController.isLoading.value) {
                              return const CbrandsShimmer(
                                itemCount: 4,
                              );
                            } else {
                              if (brandsController.featuredBrands.isEmpty) {
                                return const Center(
                                  child: NoDataScreen(
                                    lottieImage: CImages.noDataLottie,
                                    txt: 'No data found!',
                                  ),
                                );
                              } else {
                                return CGridLayout(
                                  itemCount:
                                      brandsController.featuredBrands.length,
                                  mainAxisExtent: 80,
                                  itemBuilder: (_, index) {
                                    final brand =
                                        brandsController.featuredBrands[index];
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

                        const SizedBox(
                          height: CSizes.spaceBtnItems / 4,
                        ),
                      ],
                    ),
                  ),

                  // tabbed menu
                  bottom: CTabBar(
                    tabs: categories
                        .map(
                          (category) => Tab(
                            child: Text(category.cName),
                          ),
                        )
                        .toList(),
                  ),
                ),
              ];
            },
            body: TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              children: categories
                  .map(
                    (pCategory) => CCategoriesTab(
                      category: pCategory,
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
      ),
    );
  }
}
