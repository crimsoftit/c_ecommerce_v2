import 'dart:convert';

import 'package:duara_ecommerce/data/repositories/products/products_repo.dart';
import 'package:duara_ecommerce/features/shop/models/product_model.dart';
import 'package:duara_ecommerce/utils/local_storage/storage_utility.dart';
import 'package:duara_ecommerce/utils/popups/snackbars.dart';
import 'package:get/get.dart';

class CWishlistController extends GetxController {
  static CWishlistController get instance => Get.find();

  /// -- variables --
  final wishlist = <String, bool>{}.obs;

  @override
  void onInit() {
    super.onInit();
    initFavorites();
  }

  /// -- method to initialize favorite products by reading from local storage
  void initFavorites() {
    final jsonRead = CLocalStorage.instance().readData('wishlist');

    if (jsonRead != null) {
      final storedWishlist = jsonDecode(jsonRead) as Map<String, dynamic>;

      wishlist.assignAll(
          storedWishlist.map((key, value) => MapEntry(key, value as bool)));
    }
  }

  bool isInWishlist(String productId) {
    return wishlist[productId] ?? false;
  }

  void toggleWishlistEntry(String productId) {
    if (!wishlist.containsKey(productId)) {
      wishlist[productId] = true;
      saveWishlistToLocalStorage();
      CPopupSnackBar.customToast(
        message: 'product successfully added to wishlist',
      );
    } else {
      CLocalStorage.instance().removeData(productId);
      wishlist.remove(productId);
      saveWishlistToLocalStorage();
      wishlist.refresh();
      CPopupSnackBar.customToast(
        message: 'product successfully removed from wishlist',
      );
    }
  }

  void saveWishlistToLocalStorage() {
    final encodedWishlist = json.encode(wishlist);
    CLocalStorage.instance().writeData('wishlist', encodedWishlist);
  }

  Future<List<CProductModel>> fetchWishlistProducts() async {
    final wishlistItems =
        CProductsRepo.instance.fetchWishlistItems(wishlist.keys.toList());
    return wishlistItems;
  }
}
