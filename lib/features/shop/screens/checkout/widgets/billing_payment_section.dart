import 'package:duara_ecommerce/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:duara_ecommerce/common/widgets/text_widgets/section_headings.dart';
import 'package:duara_ecommerce/utils/constants/colors.dart';
import 'package:duara_ecommerce/utils/constants/image_strings.dart';
import 'package:duara_ecommerce/utils/constants/sizes.dart';
import 'package:duara_ecommerce/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class CBillingPaymentSection extends StatelessWidget {
  const CBillingPaymentSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkTheme = CHelperFunctions.isDarkMode(context);

    return Column(
      children: [
        CSectionHeading(
          showActionBtn: true,
          title: 'payment method',
          btnTitle: 'change',
          editFontSize: true,
          onPressed: () {},
        ),
        const SizedBox(
          height: CSizes.spaceBtnItems / 2,
        ),
        Row(
          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CRoundedContainer(
              width: 60.0,
              height: 35.0,
              bgColor: isDarkTheme ? CColors.light : CColors.white,
              padding: const EdgeInsets.all(CSizes.sm),
              child: const Image(
                image: AssetImage(CImages.paypal),
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(
              width: CSizes.spaceBtnItems / 2,
            ),
            Text(
              'paypal',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ],
    );
  }
}
