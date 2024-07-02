import 'package:duara_ecommerce/common/widgets/text_widgets/p_price_txt.dart';
import 'package:duara_ecommerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class CBillingAmountSection extends StatelessWidget {
  const CBillingAmountSection({super.key});

  @override
  Widget build(BuildContext context) {
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
            const CProductPriceText(
              price: '25,000',
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
            const CProductPriceText(
              price: '600',
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
            const CProductPriceText(
              price: '400',
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
            const CProductPriceText(
              price: '26,000',
              isLarge: true,
            ),
          ],
        ),
      ],
    );
  }
}
