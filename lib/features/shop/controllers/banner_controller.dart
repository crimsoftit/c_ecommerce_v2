import 'package:duara_ecommerce/data/repositories/banners/banners_repo.dart';
import 'package:duara_ecommerce/features/shop/models/banner_model.dart';
import 'package:duara_ecommerce/utils/popups/snackbars.dart';
import 'package:get/get.dart';

class CBannerController extends GetxController {
  /// -- variables --
  final isLoading = false.obs;
  final carouselCurrentIndex = 0.obs;
  final RxList<CBannerModel> banners = <CBannerModel>[].obs;

  @override
  void onInit() {
    fetchAllBanners();
    super.onInit();
  }

  /// -- update page navigation dots --
  void updatePageIndicator(index) {
    carouselCurrentIndex.value = index;
  }

  /// -- fetch banners --
  Future<void> fetchAllBanners() async {
    try {
      // show loader while product categories are fetched
      isLoading.value = true;

      // fetch banners
      final bannerRepo = Get.put(BannersRepo());
      final allBanners = await bannerRepo.fetchBanners();

      // asign banners
      banners.assignAll(allBanners);
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
}
