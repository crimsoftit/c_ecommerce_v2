import 'package:duara_ecommerce/common/widgets/icons/circular_icon.dart';
import 'package:duara_ecommerce/features/shop/controllers/product/cart_controller.dart';
import 'package:duara_ecommerce/features/shop/models/product_model.dart';
import 'package:duara_ecommerce/utils/constants/colors.dart';
import 'package:duara_ecommerce/utils/constants/sizes.dart';
import 'package:duara_ecommerce/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class CAddToCartBottomNavBar extends StatelessWidget {
  const CAddToCartBottomNavBar({
    super.key,
    required this.product,
  });

  final CProductModel product;

  @override
  Widget build(BuildContext context) {
    final isDarkTheme = CHelperFunctions.isDarkMode(context);

    final cartController = CCartController.instance;

    cartController.updateCartItemCount(product);

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: CSizes.defaultSpace,
        vertical: CSizes.defaultSpace / 2,
      ),
      decoration: BoxDecoration(
        color: isDarkTheme ? CColors.rBrown.withOpacity(0.4) : CColors.light,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(CSizes.cardRadiusLg),
          topRight: Radius.circular(CSizes.cardRadiusLg),
        ),
      ),
      child: Obx(
        () {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CCircularIcon(
                    icon: Iconsax.minus,
                    bgColor: CColors.rBrown.withOpacity(0.5),
                    width: 40.0,
                    height: 40.0,
                    color: CColors.white,
                    onPressed: () => cartController.pQtyInCart.value < 1
                        ? null
                        : cartController.pQtyInCart.value -= 1,
                  ),
                  //const CFavoriteIcon(),
                  const SizedBox(
                    width: CSizes.spaceBtnItems,
                  ),
                  Text(
                    cartController.pQtyInCart.value.toString(),
                    style: Theme.of(context).textTheme.titleSmall!.apply(
                          fontSizeFactor: 0.85,
                        ),
                  ),
                  const SizedBox(
                    width: CSizes.spaceBtnItems,
                  ),

                  CCircularIcon(
                    bgColor: CColors.rBrown,
                    icon: Iconsax.add,
                    color: CColors.white,
                    width: 40.0,
                    height: 40.0,
                    onPressed: () {
                      cartController.pQtyInCart.value += 1;
                    },
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: cartController.pQtyInCart.value < 1
                    ? null
                    : () {
                        cartController.addToCart(product);
                      },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(
                    CSizes.md,
                  ),
                  backgroundColor: CColors.rBrown,
                  side: const BorderSide(
                    color: CColors.rBrown,
                  ),
                ),
                child: Text(
                  'add to cart'.toUpperCase(),
                  style: Theme.of(context).textTheme.labelMedium?.apply(
                        color: CColors.white,
                      ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
