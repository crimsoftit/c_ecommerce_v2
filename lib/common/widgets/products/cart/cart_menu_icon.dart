import 'package:duara_ecommerce/features/shop/controllers/product/cart_controller.dart';
import 'package:duara_ecommerce/features/shop/screens/cart/cart.dart';
import 'package:duara_ecommerce/utils/constants/colors.dart';
import 'package:duara_ecommerce/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class CCartCounterIcon extends StatelessWidget {
  const CCartCounterIcon({
    super.key,
    this.iconColor,
    this.counterBgColor,
    this.counterTxtColor,
  });

  final Color? iconColor, counterBgColor, counterTxtColor;

  @override
  Widget build(BuildContext context) {
    final cartController = Get.put(CCartController());
    final isDarkTheme = CHelperFunctions.isDarkMode(context);

    return Stack(
      children: [
        IconButton(
          onPressed: () => Get.to(() => const CCartScreen()),
          icon: Icon(
            Iconsax.shopping_bag,
            color: iconColor,
          ),
        ),
        Positioned(
          right: 0,
          top: 5,
          child: Container(
            width: 18,
            height: 18,
            decoration: BoxDecoration(
              color: counterBgColor ??
                  (isDarkTheme ? CColors.white : CColors.rBrown),
              borderRadius: BorderRadius.circular(100),
            ),
            child: Center(
              child: Obx(() {
                return Text(
                  cartController.noOfCartItems.value.toString(),
                  style: Theme.of(context).textTheme.labelSmall!.apply(
                        color: counterTxtColor ??
                            (isDarkTheme ? CColors.rBrown : CColors.white),
                        fontSizeFactor: 1.0,
                      ),
                );
              }),
            ),
          ),
        ),
      ],
    );
  }
}
