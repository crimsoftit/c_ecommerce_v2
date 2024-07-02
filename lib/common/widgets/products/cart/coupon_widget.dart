import 'package:duara_ecommerce/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:duara_ecommerce/utils/constants/colors.dart';
import 'package:duara_ecommerce/utils/constants/sizes.dart';
import 'package:duara_ecommerce/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class CCouponCodeWidget extends StatelessWidget {
  const CCouponCodeWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkTheme = CHelperFunctions.isDarkMode(context);

    return CRoundedContainer(
      showBorder: true,
      bgColor: isDarkTheme ? CColors.rBrown.withOpacity(0.2) : CColors.white,
      padding: const EdgeInsets.only(
        top: CSizes.sm,
        bottom: CSizes.sm,
        right: CSizes.sm,
        left: CSizes.md,
      ),
      child: Row(
        children: [
          Flexible(
            child: TextFormField(
              decoration: const InputDecoration(
                hintText: 'have a promo code? enter here',
                //labelText: 'promo code',
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
              ),
            ),
          ),

          // -- apply coupon button
          SizedBox(
            width: 80.0,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                foregroundColor: isDarkTheme
                    ? CColors.white
                    : CColors.rBrown.withOpacity(0.5),
                backgroundColor: CColors.grey.withOpacity(0.8),
                side: BorderSide(
                  color: CColors.grey.withOpacity(0.1),
                ),
              ),
              child: Text(
                'apply'.toUpperCase(),
                style: Theme.of(context).textTheme.labelMedium?.apply(
                      color: CColors.white,
                    ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
