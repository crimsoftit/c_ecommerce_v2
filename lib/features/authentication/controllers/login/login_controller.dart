import 'package:duara_ecommerce/data/repositories/auth/auth_repo.dart';
import 'package:duara_ecommerce/features/personalization/controllers/user_controller.dart';
import 'package:duara_ecommerce/utils/constants/image_strings.dart';
import 'package:duara_ecommerce/utils/helpers/network_manager.dart';
import 'package:duara_ecommerce/utils/popups/full_screen_loader.dart';
import 'package:duara_ecommerce/utils/popups/snackbars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CLoginController extends GetxController {
  /// -- variables --
  final rememberMe = false.obs;
  final hidePswdTxt = true.obs;
  final localStorage = GetStorage();
  final email = TextEditingController();
  final password = TextEditingController();

  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  final userController = Get.put(CUserController());

  @override
  void onInit() {
    super.onInit();
    String? rememberedEmail = localStorage.read('REMEMBER_ME_EMAIL');
    String? rememberedPasswd = localStorage.read('REMEMBER_ME_PASSWORD');
    if (rememberedEmail != null && rememberedPasswd != null) {
      email.text = localStorage.read('REMEMBER_ME_EMAIL');
      password.text = localStorage.read('REMEMBER_ME_PASSWORD');
    }
  }

  /// -- email & password signIn --
  Future<void> emailAndPasswdSignIn() async {
    try {
      // start the loader
      CFullScreenLoader.openLoadingDialog(
        'logging you in...',
        CImages.docerAnimation,
      );

      // check internet connectivity
      final isConnected = await CNetworkManager.instance.isConnected();
      if (!isConnected) {
        CFullScreenLoader.stopLoading();
        CPopupSnackBar.customToast(
          message: 'please check your internet connection',
        );
        return;
      }

      // form validation
      if (!loginFormKey.currentState!.validate()) {
        CFullScreenLoader.stopLoading();
        return;
      }

      // save data if rememberMe checkbox is checked
      if (rememberMe.value) {
        localStorage.write(
          'REMEMBER_ME_EMAIL',
          email.text.trim(),
        );
        localStorage.write(
          'REMEMBER_ME_PASSWORD',
          password.text.trim(),
        );
      }

      // sign in user using email & password authentication
      await AuthRepo.instance.logInWithEmailAndPassword(
        email.text.trim(),
        password.text.trim(),
      );

      // stop loader
      CFullScreenLoader.stopLoading();

      // redirect to relevant screen
      AuthRepo.instance.screenRedirect();
    } catch (e) {
      CFullScreenLoader.stopLoading();
      CPopupSnackBar.errorSnackBar(
        title: 'Oh Snap!',
        message: e.toString(),
      );
    }
  }

  /// -- Google signIn Authentication --
  Future<void> googleSignIn() async {
    try {
      // -- start the loader
      CFullScreenLoader.openLoadingDialog(
        'logging you in...',
        CImages.docerAnimation,
      );

      // -- check internet connectivity
      final isConnected = await CNetworkManager.instance.isConnected();
      if (!isConnected) {
        CFullScreenLoader.stopLoading();

        return;
      }

      // -- google authentication
      final userCredentials = await AuthRepo.instance.loginInWithGoogle();

      // -- save user details
      await userController.saveUserDetails(userCredentials);

      // -- remove the loader
      CFullScreenLoader.stopLoading();

      // -- redirect to the relevant screen
      AuthRepo.instance.screenRedirect();
    } on FirebaseAuthException catch (error) {
      if (kDebugMode) print(error.message);
      CPopupSnackBar.errorSnackBar(
        title: 'Oh Snap!',
        message: error.toString(),
      );
    } catch (e) {
      CPopupSnackBar.errorSnackBar(
        title: 'Oh Snap!',
        message: e.toString(),
      );
    }
  }
}
