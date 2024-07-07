import 'package:duara_ecommerce/common/widgets/text_widgets/section_headings.dart';
import 'package:duara_ecommerce/features/shop/models/payment_method_model.dart';
import 'package:duara_ecommerce/features/shop/screens/checkout/widgets/payment_tile.dart';
import 'package:duara_ecommerce/utils/constants/image_strings.dart';
import 'package:duara_ecommerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CCheckoutController extends GetxController {
  static CCheckoutController get instance => Get.find();

  final Rx<CPaymentMethodModel> selectedPaymentPlatform =
      CPaymentMethodModel.empty().obs;

  @override
  void onInit() {
    selectedPaymentPlatform.value = CPaymentMethodModel(
      platformName: 'paypal',
      platformLogo: CImages.paypal,
    );

    super.onInit();
  }

  Future<dynamic> selectPaymentPlatform(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (_) {
        return SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(CSizes.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CSectionHeading(
                  showActionBtn: false,
                  title: 'select payment method',
                  btnTitle: '',
                  editFontSize: false,
                ),
                const SizedBox(
                  height: CSizes.spaceBtnSections,
                ),
                CPaymentTile(
                  paymentPlatform: CPaymentMethodModel(
                    platformName: 'paypal',
                    platformLogo: CImages.paypal,
                  ),
                ),
                const SizedBox(
                  height: CSizes.spaceBtnItems / 2,
                ),
                CPaymentTile(
                  paymentPlatform: CPaymentMethodModel(
                    platformName: 'google pay',
                    platformLogo: CImages.googlePay,
                  ),
                ),
                const SizedBox(
                  height: CSizes.spaceBtnSections,
                ),
                CPaymentTile(
                  paymentPlatform: CPaymentMethodModel(
                    platformName: 'apple pay',
                    platformLogo: CImages.applePay,
                  ),
                ),
                const SizedBox(
                  height: CSizes.spaceBtnItems / 2,
                ),
                CPaymentTile(
                  paymentPlatform: CPaymentMethodModel(
                    platformName: 'visa',
                    platformLogo: CImages.visa,
                  ),
                ),
                const SizedBox(
                  height: CSizes.spaceBtnItems / 2,
                ),
                CPaymentTile(
                  paymentPlatform: CPaymentMethodModel(
                    platformName: 'master card',
                    platformLogo: CImages.masterCard,
                  ),
                ),
                const SizedBox(
                  height: CSizes.spaceBtnSections,
                ),
                CPaymentTile(
                  paymentPlatform: CPaymentMethodModel(
                    platformName: 'Paytm',
                    platformLogo: CImages.paytm,
                  ),
                ),
                const SizedBox(
                  height: CSizes.spaceBtnItems / 2,
                ),
                CPaymentTile(
                  paymentPlatform: CPaymentMethodModel(
                    platformName: 'paystack',
                    platformLogo: CImages.paystack,
                  ),
                ),
                const SizedBox(
                  height: CSizes.spaceBtnItems / 2,
                ),
                CPaymentTile(
                  paymentPlatform: CPaymentMethodModel(
                    platformName: 'credit card',
                    platformLogo: CImages.creditCard,
                  ),
                ),
                const SizedBox(
                  height: CSizes.spaceBtnSections,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
