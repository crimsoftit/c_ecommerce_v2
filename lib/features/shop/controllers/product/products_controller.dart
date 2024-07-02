import 'package:duara_ecommerce/data/repositories/products/products_repo.dart';
import 'package:duara_ecommerce/features/shop/models/product_model.dart';
import 'package:duara_ecommerce/utils/constants/enums.dart';
import 'package:duara_ecommerce/utils/popups/snackbars.dart';
import 'package:get/get.dart';

class CProductsController extends GetxController {
  static CProductsController get instance => Get.find();

  /// -- variables --
  final isLoading = false.obs;
  final productsRepo = Get.put(CProductsRepo());
  final RxList<CProductModel> featuredProducts = <CProductModel>[].obs;

  @override
  void onInit() {
    fetchFeaturedProducts();
    super.onInit();
  }

  /// -- fetch a limited no. of featured products --
  void fetchFeaturedProducts() async {
    try {
      // start loader while products are fetched
      isLoading.value = true;

      // fetch products
      final fetchedProducts = await productsRepo.fetchFeaturedProducts();

      // assign products
      featuredProducts.assignAll(fetchedProducts);
    } catch (e) {
      isLoading.value = false;
      CPopupSnackBar.errorSnackBar(
        title: 'Oh Snap!',
        message: e.toString(),
      );
    } finally {
      isLoading.value = false;
    }
  }

  /// -- fetch all of featured products --
  Future<List<CProductModel>> fetchAllFeaturedProducts() async {
    try {
      // fetch all featured products
      final fetchedProducts = await productsRepo.fetchAllFeaturedProducts();

      return fetchedProducts;
    } catch (e) {
      CPopupSnackBar.errorSnackBar(
        title: 'Oh Snap!',
        message: e.toString(),
      );
      return [];
    }
  }

  /// -- get the product price or price range for variations --
  String fetchProductPrice(CProductModel product) {
    double lowestPrice = double.infinity;
    double highestPrice = 0.0;

    // -- if no variations exist, return the sale price
    if (product.productType == CProductType.single.toString()) {
      return (product.salePrice > 0 ? product.salePrice : product.pPrice)
          .toString();
    } else {
      // -- calculate the lowest & highest prices among variations
      for (var variation in product.pVariations!) {
        // determine the price to consider (sale or regular price)
        double priceToConsider = variation.pSalePrice > 0.0
            ? variation.pSalePrice
            : variation.pPrice;

        // update lowest & highest prices
        if (priceToConsider < lowestPrice) {
          lowestPrice = priceToConsider;
        } else if (priceToConsider > highestPrice) {
          highestPrice = priceToConsider;
        }
      }

      // if lowestPrice = highestPrice, return a single price
      if (lowestPrice.isEqual(highestPrice)) {
        return highestPrice.toString();
      } else {
        // otherwise, return a price range
        return '$lowestPrice - Ksh.$highestPrice';
      }
    }
  }

  /// -- calculate discount percentage --
  String? calculateDiscountPercentage(double originalPrice, double? salePrice) {
    if (salePrice == null || salePrice <= 0.0) return null;

    if (originalPrice <= 0) return null;

    double percentage = ((originalPrice - salePrice) / originalPrice) * 100;

    return percentage.toStringAsFixed(0);
  }

  /// -- check product stock status --
  String checkProductStockStatus(int stockCount) {
    return stockCount > 0 ? 'in stock' : 'out of stock';
  }
}
