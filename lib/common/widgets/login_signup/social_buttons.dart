import 'package:duara_ecommerce/features/authentication/controllers/login/login_controller.dart';
import 'package:duara_ecommerce/utils/constants/colors.dart';
import 'package:duara_ecommerce/utils/constants/image_strings.dart';
import 'package:duara_ecommerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CSocialButtons extends StatelessWidget {
  const CSocialButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final loginController = Get.put(CLoginController());

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: CColors.grey,
            ),
            borderRadius: BorderRadius.circular(100),
          ),
          child: IconButton(
            onPressed: () async {
              loginController.googleSignIn();
            },
            icon: const Image(
              width: CSizes.iconMd,
              height: CSizes.iconMd,
              image: AssetImage(
                CImages.google,
              ),
            ),
          ),
        ),
        const SizedBox(
          width: CSizes.spaceBtnItems,
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: CColors.grey,
            ),
            borderRadius: BorderRadius.circular(100),
          ),
          child: IconButton(
            onPressed: () {},
            icon: const Image(
              width: CSizes.iconMd,
              height: CSizes.iconMd,
              image: AssetImage(
                CImages.fb,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
