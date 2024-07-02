import 'package:duara_ecommerce/utils/constants/image_strings.dart';
import 'package:duara_ecommerce/utils/constants/sizes.dart';
import 'package:duara_ecommerce/utils/constants/text_strings.dart';
import 'package:duara_ecommerce/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkTheme = CHelperFunctions.isDarkMode(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          //width: double.infinity,
          child: Image(
            height: 120.0,
            //image: AssetImage( isDark ? RImages.darkAppLogo_1 : RImages.lightAppLogo_1),
            image: AssetImage(
                isDarkTheme ? CImages.darkAppLogo : CImages.lightAppLogo),
          ),
        ),
        Text(
          CTexts.loginTitle,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(
          height: CSizes.sm,
        ),
        Text(
          CTexts.loginSubTitle,
          style: Theme.of(context).textTheme.labelSmall,
        ),
      ],
    );
  }
}
