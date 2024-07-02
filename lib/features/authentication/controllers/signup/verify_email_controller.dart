import 'dart:async';

import 'package:duara_ecommerce/common/widgets/success_screen/success_screen.dart';
import 'package:duara_ecommerce/data/repositories/auth/auth_repo.dart';
import 'package:duara_ecommerce/utils/constants/image_strings.dart';
import 'package:duara_ecommerce/utils/constants/text_strings.dart';
import 'package:duara_ecommerce/utils/popups/snackbars.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class CVerifyEmailController extends GetxController {
  static CVerifyEmailController get instance => Get.find();

  /* === send e-mail whenever verify email screen appears & set timer for auto redirect === */
  @override
  void onInit() {
    sendEmailVerification();
    setTimerForAutoRedirect();
    super.onInit();
  }

  // -- send email verification link --
  sendEmailVerification() async {
    try {
      await AuthRepo.instance.sendEmailVerification();
      CPopupSnackBar.successSnackBar(
        title: 'verification e-mail sent!',
        message:
            'please check your inbox or spam to verify your e-mail address',
      );
    } catch (e) {
      CPopupSnackBar.errorSnackBar(
        title: 'Oh Snap!',
        message: e.toString(),
      );
    }
  }

  // -- set timer to automatically redirect upon email verification --
  setTimerForAutoRedirect() {
    Timer.periodic(
      const Duration(seconds: 1),
      (timer) async {
        await FirebaseAuth.instance.currentUser?.reload();
        final user = FirebaseAuth.instance.currentUser;
        if (user?.emailVerified ?? false) {
          timer.cancel();
          Get.off(
            () => SuccessScreen(
                image: CImages.successfulRegAnimation,
                title: CTexts.accountCreatedTitle,
                subTitle: CTexts.accountCreatedSubTitle,
                onPressed: () {
                  AuthRepo.instance.screenRedirect();
                },
              )
            
          );
        }
      },
    );
  }

  // -- manually check if email was verified --
  checkEmailVerificationStatus() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null && currentUser.emailVerified) {
      Get.off(() {
        SuccessScreen(
          image: CImages.successfulRegAnimation,
          title: CTexts.accountCreatedTitle,
          subTitle: CTexts.accountCreatedSubTitle,
          onPressed: () {
            AuthRepo.instance.screenRedirect();
          },
        );
      });
    }
  }
}
