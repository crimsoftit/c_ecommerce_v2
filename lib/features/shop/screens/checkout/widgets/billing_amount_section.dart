import 'package:duara_ecommerce/common/widgets/text_widgets/p_price_txt.dart';
import 'package:duara_ecommerce/features/shop/controllers/product/cart_controller.dart';
import 'package:duara_ecommerce/utils/constants/sizes.dart';
import 'package:duara_ecommerce/utils/helpers/pricing_calculator.dart';
import 'package:flutter/material.dart';

class CBillingAmountSection extends StatelessWidget {
  const CBillingAmountSection({super.key});

  @override
  Widget build(BuildContext context) {
    final cartController = CCartController.instance;

    final subTotal = cartController.totalCartPrice.value;

    return Column(
      children: [
        // -- sub total
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'subtotal: ',
              style: Theme.of(context).textTheme.bodyMedium!.apply(
                    fontWeightDelta: 2,
                  ),
            ),
            CProductPriceText(
              price: '$subTotal',
              isLarge: true,
            ),
          ],
        ),
        const SizedBox(
          height: CSizes.spaceBtnItems / 2,
        ),

        // -- shipping fee
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'shipping fee: ',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            CProductPriceText(
              price: CPricingCalculator.calculateShippingCost(subTotal, 'us'),
              isLarge: false,
            ),
          ],
        ),

        const SizedBox(
          height: CSizes.spaceBtnItems / 2,
        ),

        // -- taxation fee
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'taxation fee: ',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            CProductPriceText(
              price: CPricingCalculator.calculateTax(subTotal, 'us'),
              isLarge: false,
            ),
          ],
        ),

        const SizedBox(
          height: CSizes.spaceBtnItems / 2,
        ),

        // -- order total
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'order total: ',
              style: Theme.of(context).textTheme.bodyMedium!.apply(
                    fontWeightDelta: 2,
                  ),
            ),
            CProductPriceText(
              price: CPricingCalculator.calculateTotalPrice(subTotal, 'us')
                  .toString(),
              isLarge: true,
            ),
          ],
        ),
      ],
    );
  }
}
