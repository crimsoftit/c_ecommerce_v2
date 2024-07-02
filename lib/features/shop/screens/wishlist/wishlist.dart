import 'package:duara_ecommerce/common/widgets/appbar/appbar.dart';
import 'package:duara_ecommerce/common/widgets/icons/circular_icon.dart';
import 'package:duara_ecommerce/common/widgets/layouts/grid_layout.dart';
import 'package:duara_ecommerce/common/widgets/loaders/animation_loader.dart';
import 'package:duara_ecommerce/common/widgets/products/product_cards/p_card_vert.dart';
import 'package:duara_ecommerce/common/widgets/shimmers/vertical_product_shimmer.dart';
import 'package:duara_ecommerce/features/shop/controllers/product/wishlist_controller.dart';
import 'package:duara_ecommerce/features/shop/screens/home/home.dart';
import 'package:duara_ecommerce/nav_menu.dart';
import 'package:duara_ecommerce/utils/constants/colors.dart';
import 'package:duara_ecommerce/utils/constants/image_strings.dart';
import 'package:duara_ecommerce/utils/constants/sizes.dart';
import 'package:duara_ecommerce/utils/helpers/cloud_helper_functions.dart';
import 'package:duara_ecommerce/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkTheme = CHelperFunctions.isDarkMode(context);

    final wishlistController = CWishlistController.instance;

    return Scaffold(
      appBar: CAppBar(
        showBackArrow: true,
        backIconColor: isDarkTheme ? CColors.white : CColors.rBrown,
        title: Text(
          'wishlist',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        actions: [
          CCircularIcon(
            icon: Iconsax.add,
            color: isDarkTheme ? CColors.white : CColors.rBrown,
            onPressed: () {
              Get.to(const HomeScreen());
            },
          ),
          //CFavoriteIcon(),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(CSizes.defaultSpace),

          // -- products grid
          child: Obx(() {
            return FutureBuilder(
              future: wishlistController.fetchWishlistProducts(),
              builder: (context, snapshot) {
                const loader = CVerticalProductShimmer(
                  itemCount: 6,
                );

                final noDataWidget = CAnimationLoaderWidget(
                  text: 'whoops! wishlist is empty...',
                  animation: CImages.pencilAnimation,
                  showActionBtn: true,
                  actionBtnText: "let's add some...",
                  onActionBtnPressed: () {
                    Get.off(() => const NavMenu());
                  },
                );

                final widget = CCloudHelperFunctions.checkMultipleRecordsState(
                  snapshot: snapshot,
                  loader: loader,
                  noData: noDataWidget,
                );

                if (widget != null) return widget;

                final wishlistProducts = snapshot.data!;

                return CGridLayout(
                  itemCount: wishlistProducts.length,
                  itemBuilder: (_, index) {
                    return CProductCardVertical(
                      product: wishlistProducts[index],
                    );
                  },
                );
              },
            );
          }),
        ),
      ),
    );
  }
}
