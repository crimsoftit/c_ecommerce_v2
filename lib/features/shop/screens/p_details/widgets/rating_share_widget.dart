import 'package:duara_ecommerce/utils/constants/colors.dart';
import 'package:duara_ecommerce/utils/constants/sizes.dart';
import 'package:duara_ecommerce/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class CProductRatingWidget extends StatelessWidget {
  const CProductRatingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkTheme = CHelperFunctions.isDarkMode(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // rating
        Row(
          children: [
            const Icon(
              Iconsax.star5,
              color: Colors.amber,
              size: 24,
            ),
            const SizedBox(
              width: CSizes.spaceBtnItems / 2,
            ),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                      text: '5.0',
                      style: Theme.of(context).textTheme.bodyLarge),
                  const TextSpan(
                    text: ' (1999)',
                  ),
                ],
              ),
            ),
          ],
        ),

        // share button
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.share,
            size: CSizes.iconMd,
            color: isDarkTheme ? CColors.white : CColors.rBrown,
          ),
        ),
      ],
    );
  }
}
