import 'package:duara_ecommerce/data/repositories/categories/cat_repo.dart';
import 'package:duara_ecommerce/data/repositories/products/products_repo.dart';
import 'package:duara_ecommerce/features/shop/models/categories_model.dart';
import 'package:duara_ecommerce/features/shop/models/product_model.dart';
import 'package:duara_ecommerce/utils/popups/snackbars.dart';
import 'package:get/get.dart';

class CCatsController extends GetxController {
  static CCatsController get instance => Get.find();

  final isLoading = false.obs;
  final _catsRepo = Get.put(CCategoriesRepo());
  RxList<CCategoriesModel> allCategories = <CCategoriesModel>[].obs;
  RxList<CCategoriesModel> featuredCategories = <CCategoriesModel>[].obs;

  @override
  void onInit() {
    fetchAllCategories();
    super.onInit();
  }

  // -- load categories data --
  Future<void> fetchAllCategories() async {
    try {
      // show loader while product categories are fetched
      isLoading.value = true;

      // fetch categories from data source (Firestore, API, etc.)
      final pCats = await _catsRepo.fetchAllCategories();

      // update list of categories
      allCategories.assignAll(pCats);

      // filter featured product categories
      featuredCategories.assignAll(allCategories
          .where((category) => category.isFeatured && category.parentId.isEmpty)
          .take(10)
          .toList());
    } catch (e) {
      isLoading.value = false;
      CPopupSnackBar.errorSnackBar(
        title: 'Oh Snap!',
        message: e.toString(),
      );
    } finally {
      // remove loader
      isLoading.value = false;
    }
  }

  // -- load selected categories data --
  Future<List<CCategoriesModel>> fetchSubCategories(String categoryId) async {
    try {
      final subCategories = await _catsRepo.fetchSubCategories(categoryId);
      return subCategories;
    } catch (e) {
      CPopupSnackBar.errorSnackBar(
        title: 'Oh Snap!',
        message: e.toString(),
      );
      return [];
    }
  }

  // -- get category or sub-category products --
  Future<List<CProductModel>> fetchProductsByCategory(
      {required String categoryId, int limit = 4}) async {
    try {
      // fetch a limit of 4 products associated with the category
      final cProducts = await CProductsRepo.instance.fetchProductsByCategory(
        categoryId: categoryId,
      );
      return cProducts;
    } catch (e) {
      CPopupSnackBar.errorSnackBar(
        title: 'Oh Snap!',
        message: e.toString(),
      );
      return [];
    }
  }
}
