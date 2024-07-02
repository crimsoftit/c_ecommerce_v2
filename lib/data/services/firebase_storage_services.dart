import 'dart:io';

import 'package:duara_ecommerce/utils/exceptions/firebase_auth_exceptions.dart';
import 'package:duara_ecommerce/utils/exceptions/platform_exceptions.dart';
import 'package:duara_ecommerce/utils/popups/snackbars.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class CFirebaseStorageServices extends GetxController {
  static CFirebaseStorageServices get instance => Get.find();

  final _firebaseStorage = FirebaseStorage.instance;

  /// -- upload local assets from IDE
  /// -- returns a Uint8List containing image data
  Future<Uint8List> getImageDataFromAssets(String path) async {
    try {
      final byteData = await rootBundle.load(path);
      final imgData = byteData.buffer.asUint8List(
        byteData.offsetInBytes,
        byteData.lengthInBytes,
      );
      return imgData;
    } catch (e) {
      // handle exceptions gracefully
      throw CPopupSnackBar.errorSnackBar(
        title: 'Oh Snap!',
        message: 'Error loading image data: $e',
      );
    }
  }

  /// -- upload image using ImageData on cloud firebase storage --
  /// -- returns the download url of the uploaded image --
  Future<String> uploadImageData(
      String path, Uint8List image, String pName) async {
    try {
      final ref = _firebaseStorage.ref(path).child(pName);
      await ref.putData(image);
      final imgUrl = await ref.getDownloadURL();
      return imgUrl;
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
      throw 'something went wrong! please try again.';
    }
  }

  /// -- upload image file on cloud firebase storage --
  /// -- returns the download url of the uploaded image --
  Future<String> uploadImgFile(String path, XFile img) async {
    try {
      final ref = _firebaseStorage.ref(path).child(img.name);
      await ref.putFile(File(img.path));
      final imgUrl = await ref.getDownloadURL();
      return imgUrl;
    } catch (e) {
      // handle exceptions gracefully
      if (e is FirebaseException) {
        throw 'firebase exception!: ${e.message}';
      } else if (e is SocketException) {
        throw 'network error!: ${e.message}';
      } else {
        throw 'something went wrong! please try again later.';
      }
    }
  }
}
