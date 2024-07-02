import 'package:duara_ecommerce/features/shop/controllers/product/cart_controller.dart';
import 'package:duara_ecommerce/features/shop/models/product_model.dart';
import 'package:duara_ecommerce/features/shop/screens/p_details/p_details.dart';
import 'package:duara_ecommerce/utils/constants/colors.dart';
import 'package:duara_ecommerce/utils/constants/enums.dart';
import 'package:duara_ecommerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class CProductCardAddToCartButton extends StatelessWidget {
  const CProductCardAddToCartButton({
    super.key,
    required this.product,
  });

  final CProductModel product;

  @override
  Widget build(BuildContext context) {
    final cartController = CCartController.instance;

    return InkWell(
      onTap: () {
        // display product details if it has variations
        // otherwise, add the product to cart
        if (product.productType == CProductType.single.toString()) {
          final cartItem = cartController.convertProductToCartItem(product, 1);

          cartController.addSingleItemToCart(cartItem);
        } else {
          // final cartItem = cartController.convertProductToCartItem(product, 1);

          //cartController.convertProductToCartItem(product, 1);

          //cartController.addSingleItemToCart(cartItem);
          Get.to(() => ProductDetailsScreen(product: product));
        }
      },
      child: Obx(
        () {
          final pQtyInCart = cartController.getProductQtyInCart(product.id);

          return Container(
            // width: 30.0,
            // height: 30.0,
            decoration: BoxDecoration(
              color: pQtyInCart > 0 ? Colors.orange : CColors.rBrown,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(CSizes.cardRadiusMd),
                bottomRight: Radius.circular(CSizes.pImgRadius),
              ),
            ),
            child: SizedBox(
              width: CSizes.iconLg * 1.2,
              height: CSizes.iconLg * 1.2,
              child: Center(
                child: pQtyInCart > 0
                    ? Text(
                        pQtyInCart.toString(),
                        style: Theme.of(context).textTheme.bodyLarge!.apply(
                              color: CColors.white,
                            ),
                      )
                    : const Icon(
                        Iconsax.add,
                        color: CColors.white,
                      ),
              ),
            ),
          );
        },
      ),
    );
  }
}
