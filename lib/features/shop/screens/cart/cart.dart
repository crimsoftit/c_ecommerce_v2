import 'package:duara_ecommerce/common/widgets/appbar/appbar.dart';
import 'package:duara_ecommerce/common/widgets/loaders/animation_loader.dart';
import 'package:duara_ecommerce/features/shop/controllers/product/cart_controller.dart';
import 'package:duara_ecommerce/features/shop/screens/cart/widgets/all_cart_items.dart';
import 'package:duara_ecommerce/features/shop/screens/checkout/checkout.dart';
import 'package:duara_ecommerce/nav_menu.dart';
import 'package:duara_ecommerce/utils/constants/colors.dart';
import 'package:duara_ecommerce/utils/constants/image_strings.dart';
import 'package:duara_ecommerce/utils/constants/sizes.dart';
import 'package:duara_ecommerce/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CCartScreen extends StatelessWidget {
  const CCartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkTheme = CHelperFunctions.isDarkMode(context);

    final cartController = CCartController.instance;

    return Scaffold(
      appBar: CAppBar(
        showBackArrow: true,
        backIconColor: isDarkTheme ? CColors.white : CColors.rBrown,
        title: Text(
          'me cart',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),

      // -- body --
      body: Obx(() {
        // data not found widget
        final emptyCartWidget = CAnimationLoaderWidget(
          text: 'whoops!! cart is empty.',
          animation: CImages.cartAnimation,
          showActionBtn: true,
          actionBtnText: 'let\'s fill it...',
          onActionBtnPressed: () {
            Get.off(() => const NavMenu());
          },
        );

        if (cartController.cartItems.isEmpty) {
          return emptyCartWidget;
        } else {
          return const SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(
                CSizes.defaultSpace,
              ),

              // -- list cart items
              child: CCartItemsList(),
            ),
          );
        }
      }),

      // -- checkout button
      bottomNavigationBar: cartController.cartItems.isEmpty
          ? const SizedBox()
          : Padding(
              padding: const EdgeInsets.all(CSizes.defaultSpace),
              child: ElevatedButton(
                onPressed: () {
                  Get.to(() => const CCheckoutScreen());
                },
                child: Obx(
                  () {
                    return Text(
                      'checkout Ksh. ${cartController.totalCartPrice.value}'
                          .toUpperCase(),
                      style: Theme.of(context).textTheme.labelMedium?.apply(
                            color: CColors.white,
                          ),
                    );
                  },
                ),
              ),
            ),
    );
  }
}
