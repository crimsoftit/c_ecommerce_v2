import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:duara_ecommerce/data/repositories/products/products_repo.dart';
import 'package:duara_ecommerce/features/shop/models/product_model.dart';
import 'package:duara_ecommerce/utils/popups/snackbars.dart';
import 'package:get/get.dart';

class CAllProductsController extends GetxController {
  static CAllProductsController get instance {
    return Get.find();
  }

  /// -- variables --
  final productsRepo = CProductsRepo.instance;
  final RxString selectedSortOption = 'sort by:'.obs;
  final RxList<CProductModel> products = <CProductModel>[].obs;

  Future<List<CProductModel>> fetchProductsByQuery(Query? query) async {
    try {
      if (query == null) return [];

      final products = await productsRepo.fetchProductsByQuery(query);

      return products;
    } catch (e) {
      CPopupSnackBar.errorSnackBar(
        title: 'Oh Snap!',
        message: e.toString(),
      );
      //throw 'an unknown error occurred! ${e.toString()}';
      return [];
    }
  }

  /// -- sort products --
  void sortProductsBy(String sortOption) {
    selectedSortOption.value = sortOption;

    switch (sortOption) {
      case 'sort by:':
        products.sort((a, b) => a.pName.compareTo(b.pName));
        break;
      case 'name':
        products.sort((a, b) => a.pName.compareTo(b.pName));
        break;
      case 'highest price':
        products.sort((a, b) => b.pPrice.compareTo(a.pPrice));
        break;
      case 'lowest price':
        products.sort((a, b) => a.pPrice.compareTo(b.pPrice));
        break;
      case 'newest':
        products.sort((a, b) => a.date!.compareTo(b.date!));
        break;
      case 'popularity':
        products.sort((a, b) => a.pName.compareTo(b.pName));
        break;
      case 'sale':
        products.sort(
          (a, b) {
            if (b.salePrice > 0) {
              return b.salePrice.compareTo(a.salePrice);
            } else if (a.salePrice > 0) {
              return -1;
            } else {
              return 1;
            }
          },
        );
        break;

      default:

        // default sorting: by product name
        products.sort((a, b) => a.pName.compareTo(b.pName));
    }
  }

  /// -- assign products to the 'products' list --
  void assignProducts(List<CProductModel> products) {
    this.products.assignAll(products);
    sortProductsBy('sort by:');
  }
}
