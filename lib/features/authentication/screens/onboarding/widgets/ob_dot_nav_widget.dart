import 'package:duara_ecommerce/features/authentication/controllers/onboarding/ob_controller.dart';
import 'package:flutter/material.dart';
import 'package:duara_ecommerce/utils/constants/sizes.dart';
import 'package:duara_ecommerce/utils/constants/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:duara_ecommerce/utils/device/device_utility.dart';

class OnboardingDotNavWidget extends StatelessWidget {
  const OnboardingDotNavWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final obController = OnboardingController.instance;

    return Positioned(
      bottom: CDeviceUtils.getBottomNavigationBarHeight() + 25,
      left: CSizes.defaultSpace,
      child: SmoothPageIndicator(
        count: 3,
        controller: obController.pageController,
        onDotClicked: obController.dotNavigationClick,
        effect: const ExpandingDotsEffect(
          activeDotColor: CColors.rBrown,
          dotHeight: 6,
        ),
      ),
    );
  }
}
