import 'package:duara_ecommerce/common/widgets/products/cart/c_adjust_cart_qty_btn.dart';
import 'package:duara_ecommerce/common/widgets/products/cart/single_cart_item.dart';
import 'package:duara_ecommerce/common/widgets/text_widgets/p_price_txt.dart';
import 'package:duara_ecommerce/features/shop/controllers/product/cart_controller.dart';
import 'package:duara_ecommerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CCartItemsList extends StatelessWidget {
  const CCartItemsList({
    super.key,
    this.showAddRemoveButtons = true,
  });

  final bool showAddRemoveButtons;

  @override
  Widget build(BuildContext context) {
    final cartController = CCartController.instance;

    return Obx(
      () {
        return ListView.separated(
          shrinkWrap: true,
          itemCount: cartController.cartItems.length,
          separatorBuilder: (_, __) => const SizedBox(
            height: CSizes.spaceBtnSections,
          ),
          itemBuilder: (_, index) => Obx(
            () {
              final cartItem = cartController.cartItems[index];

              return Column(
                children: [
                  // single cart item widget
                  CSingleCartItem(
                    cartItem: cartItem,
                  ),

                  if (showAddRemoveButtons)
                    const SizedBox(
                      height: CSizes.spaceBtnItems,
                    ),

                  // add & remove cart items btn with total cart price
                  if (showAddRemoveButtons)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            // some extra space
                            const SizedBox(
                              width: 75.0,
                            ),

                            // add & remove items from cart button
                            CAdjustCartQtyButtons(
                              qty: cartItem.quantity,
                              addItemBtn: () {
                                cartController.addSingleItemToCart(cartItem);
                              },
                              removeItemBtn: () {
                                cartController
                                    .removeSingleItemFromCart(cartItem);
                              },
                            ),
                          ],
                        ),
                        CProductPriceText(
                          price: (cartItem.pPrice * cartItem.quantity)
                              .toStringAsFixed(1),
                        ),
                      ],
                    ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}
