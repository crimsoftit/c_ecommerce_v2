import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:duara_ecommerce/features/shop/models/banner_model.dart';
import 'package:duara_ecommerce/utils/exceptions/firebase_auth_exceptions.dart';
import 'package:duara_ecommerce/utils/exceptions/platform_exceptions.dart';
import 'package:duara_ecommerce/utils/popups/snackbars.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class BannersRepo extends GetxController {
  static BannersRepo get instance => Get.find();

  /// -- variables --
  final _db = FirebaseFirestore.instance;

  /// -- fetch all orders associated with the current user --
  Future<List<CBannerModel>> fetchBanners() async {
    try {
      final result = await _db
          .collection('banners')
          .where('isActive', isEqualTo: true)
          .get();
      return result.docs
          .map((docSnapshot) => CBannerModel.fromSnapshot(docSnapshot))
          .toList();
    } on FirebaseAuthException catch (e) {
      CPopupSnackBar.errorSnackBar(
        title: "firebaseAuth exception error",
        message: e.code.toString(),
      );
      throw CFirebaseAuthExceptions(e.code).message;
    } on FirebaseException catch (e) {
      throw CPopupSnackBar.errorSnackBar(
        title: "firebase exception error",
        message: e.code.toString(),
      );
    } on FormatException catch (e) {
      // CPopupLoader.errorSnackBar(
      //   title: "format exception error",
      //   message: e.message,
      // );
      throw CPopupSnackBar.errorSnackBar(
        title: "format exception error",
        message: e.message,
      );
    } on PlatformException catch (e) {
      CPopupSnackBar.errorSnackBar(
        title: "platform exception error",
        message: e.code.toString(),
      );
      throw CPlatformExceptions(e.code).message;
    } catch (e) {
      CPopupSnackBar.errorSnackBar(
          title: 'Oh Snap!',
          message: 'something went wrong while fetching banners!');
      throw 'an unknown error occurred: ${e.toString()}';
    }
  }

  /// -- upload banner images to the cloud firestore --
}
