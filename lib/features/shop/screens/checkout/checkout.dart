import 'package:duara_ecommerce/common/widgets/appbar/appbar.dart';
import 'package:duara_ecommerce/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:duara_ecommerce/common/widgets/products/cart/coupon_widget.dart';
import 'package:duara_ecommerce/common/widgets/success_screen/success_screen.dart';
import 'package:duara_ecommerce/features/shop/screens/cart/widgets/all_cart_items.dart';
import 'package:duara_ecommerce/features/shop/screens/checkout/widgets/billing_address_section.dart';
import 'package:duara_ecommerce/features/shop/screens/checkout/widgets/billing_amount_section.dart';
import 'package:duara_ecommerce/features/shop/screens/checkout/widgets/billing_payment_section.dart';
import 'package:duara_ecommerce/nav_menu.dart';
import 'package:duara_ecommerce/utils/constants/colors.dart';
import 'package:duara_ecommerce/utils/constants/image_strings.dart';
import 'package:duara_ecommerce/utils/constants/sizes.dart';
import 'package:duara_ecommerce/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CCheckoutScreen extends StatelessWidget {
  const CCheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkTheme = CHelperFunctions.isDarkMode(context);

    return Scaffold(
      appBar: CAppBar(
        showBackArrow: true,
        backIconColor: isDarkTheme ? CColors.white : CColors.rBrown,
        title: Text(
          'order review',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(CSizes.defaultSpace),
          child: Column(
            children: [
              // -- all items in the cart
              const CCartItemsList(
                showAddRemoveButtons: false,
              ),
              const SizedBox(
                height: CSizes.spaceBtnSections,
              ),

              // -- coupon textfield
              const CCouponCodeWidget(),

              const SizedBox(
                height: CSizes.spaceBtnSections,
              ),

              // -- billing section
              CRoundedContainer(
                showBorder: true,
                padding: const EdgeInsets.all(CSizes.md),
                //bgColor: isDarkTheme ? CColors.rBrown : CColors.white,
                bgColor: isDarkTheme
                    ? CColors.rBrown
                    : CColors.rBrown.withOpacity(0.1),
                child: const Column(
                  children: [
                    // pricing
                    CBillingAmountSection(),
                    SizedBox(
                      height: CSizes.spaceBtnItems,
                    ),

                    // divider
                    Divider(),
                    SizedBox(
                      height: CSizes.spaceBtnItems,
                    ),

                    // payment methods
                    CBillingPaymentSection(),
                    SizedBox(
                      height: CSizes.spaceBtnItems,
                    ),

                    // address
                    CBillingAddressSection(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),

      // -- checkout button --
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(CSizes.defaultSpace),
        child: ElevatedButton(
          onPressed: () {
            Get.to(() => SuccessScreen(
                  image: CImages.successfulPaymentIcon,
                  title: 'checkout successful!',
                  subTitle: 'your item will be shipped soon!',
                  onPressed: () {
                    Get.offAll(() => const NavMenu());
                  },
                ));
          },
          child: Text(
            'checkout Ksh. 26,000'.toUpperCase(),
            style: Theme.of(context).textTheme.labelMedium?.apply(
                  color: CColors.white,
                ),
          ),
        ),
      ),
    );
  }
}
