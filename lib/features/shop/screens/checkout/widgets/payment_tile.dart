import 'package:duara_ecommerce/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:duara_ecommerce/features/shop/controllers/product/checkout_controller.dart';
import 'package:duara_ecommerce/features/shop/models/payment_method_model.dart';
import 'package:duara_ecommerce/utils/constants/colors.dart';
import 'package:duara_ecommerce/utils/constants/sizes.dart';
import 'package:duara_ecommerce/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class CPaymentTile extends StatelessWidget {
  const CPaymentTile({
    super.key,
    required this.paymentPlatform,
  });

  final CPaymentMethodModel paymentPlatform;

  @override
  Widget build(BuildContext context) {
    final checkoutController = CCheckoutController.instance;

    final isDarkTheme = CHelperFunctions.isDarkMode(context);

    return ListTile(
      leading: CRoundedContainer(
        width: 60.0,
        height: 40.0,
        bgColor: isDarkTheme ? CColors.light : CColors.white,
        padding: const EdgeInsets.all(CSizes.sm),
        child: Image(
          image: AssetImage(paymentPlatform.platformLogo),
          fit: BoxFit.contain,
        ),
      ),
      title: Text(paymentPlatform.platformName),
      contentPadding: const EdgeInsets.all(0),
      trailing: const Icon(Iconsax.arrow_right_34),
      onTap: () {
        checkoutController.selectedPaymentPlatform.value = paymentPlatform;
        Get.back();
      },
    );
  }
}
