import 'package:duara_ecommerce/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:duara_ecommerce/common/widgets/text_widgets/section_headings.dart';
import 'package:duara_ecommerce/features/shop/controllers/product/checkout_controller.dart';
import 'package:duara_ecommerce/utils/constants/colors.dart';
import 'package:duara_ecommerce/utils/constants/sizes.dart';
import 'package:duara_ecommerce/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CBillingPaymentSection extends StatelessWidget {
  const CBillingPaymentSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkTheme = CHelperFunctions.isDarkMode(context);

    final checkoutController = Get.put(CCheckoutController());

    return Column(
      children: [
        CSectionHeading(
          showActionBtn: true,
          title: 'payment method',
          btnTitle: 'change',
          editFontSize: true,
          onPressed: () {
            checkoutController.selectPaymentPlatform(context);
          },
        ),
        const SizedBox(
          height: CSizes.spaceBtnItems / 2,
        ),
        Obx(
          () {
            return Row(
              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CRoundedContainer(
                  width: 60.0,
                  height: 35.0,
                  bgColor: isDarkTheme ? CColors.light : CColors.white,
                  padding: const EdgeInsets.all(CSizes.sm),
                  child: Image(
                    image: AssetImage(checkoutController
                        .selectedPaymentPlatform.value.platformLogo),
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(
                  width: CSizes.spaceBtnItems / 2,
                ),
                Text(
                  checkoutController.selectedPaymentPlatform.value.platformName,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}
