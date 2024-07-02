import 'package:cached_network_image/cached_network_image.dart';
import 'package:duara_ecommerce/features/shop/models/product_model.dart';
import 'package:duara_ecommerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CImagesController extends GetxController {
  static CImagesController get instance => Get.find();

  /// -- variables --
  RxString selectedProductImg = ''.obs;

  /// -- fetch all images from product & its variations --
  List<String> fetchAllProductImages(CProductModel product) {
    // use Set datatype to add unique images only
    Set<String> images = {};

    // load thumbnail image
    images.add(product.thumbnail);

    // assign thumbnail as selected image
    selectedProductImg.value = product.thumbnail;

    // fetch all images from CProductModel if not null
    if (product.pImages != null) {
      images.addAll(product.pImages!);
    }

    if (product.pVariations != null || product.pVariations!.isNotEmpty) {
      images.addAll(product.pVariations!.map((variation) => variation.pImage));
    }

    return images.toList();
  }

  /// -- show image popup --
  void showEnlargedImage(String image) {
    Get.to(
      fullscreenDialog: true,
      () => Dialog.fullscreen(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: CSizes.defaultSpace * 2,
                horizontal: CSizes.defaultSpace,
              ),
              child: CachedNetworkImage(
                imageUrl: image,
              ),
            ),
            const SizedBox(
              height: CSizes.spaceBtnSections,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                width: 150.0,
                child: OutlinedButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: const Text('close'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
