import 'package:duara_ecommerce/features/shop/controllers/product/images_controller.dart';
import 'package:duara_ecommerce/features/shop/models/product_model.dart';
import 'package:duara_ecommerce/features/shop/models/product_variations_model.dart';
import 'package:get/get.dart';

class CVariationController extends GetxController {
  static CVariationController get instance => Get.find();

  /// -- variables --
  RxMap selectedAttributes = {}.obs;
  RxString variationStockStatus = ''.obs;
  Rx<CProductVariationsModel> selectedVariation =
      CProductVariationsModel.empty().obs;

  /// -- select product attribute & variation --
  void onAttributeSelected(
      CProductModel product, attributeName, attributeValue) {
    // upon attribute selection, first add it to the selectedAttributes map
    final selectedAttributes =
        Map<String, dynamic>.from(this.selectedAttributes);
    selectedAttributes[attributeName] = attributeValue;
    this.selectedAttributes[attributeName] = attributeValue;

    final selectedVariation = product.pVariations!.firstWhere(
      (variation) => _attributeValuesMatch(
        variation.pAttributeValues,
        selectedAttributes,
      ),
      orElse: () => CProductVariationsModel.empty(),
    );

    // display the selected variation image as the main image
    if (selectedVariation.pImage.isNotEmpty) {
      CImagesController.instance.selectedProductImg.value =
          selectedVariation.pImage;
    }

    // assign selected variation
    this.selectedVariation.value = selectedVariation;

    // update stock status for the selected product variation
    fetchPVariationStockStatus();
  }

  /// -- check product variation stock status --
  bool _attributeValuesMatch(Map<String, dynamic> variationAtrributes,
      Map<String, dynamic> selectedAttributes) {
    // if selectedAttributes.length = 3 yet current variation contains 2 variations return false
    if (variationAtrributes.length != selectedAttributes.length) return false;
    for (final key in variationAtrributes.keys) {
      if (variationAtrributes[key] != selectedAttributes[key]) return false;
    }

    return true;
  }

  /// -- check product variation stock status --
  Set<String?> getAttributesAvailabilityInVariation(
      List<CProductVariationsModel> variations, String attributeName) {
    // pass the variations to check available attributes whose products are in stock
    final availableVariationAttributeValues = variations
        .where((variation) {
          return variation.pAttributeValues[attributeName] != null &&
              variation.pAttributeValues[attributeName]!.isNotEmpty &&
              variation.stockCount > 0;
        })
        .map((variation) => variation.pAttributeValues[attributeName])
        .toSet();
    return availableVariationAttributeValues;
  }

  /// -- check product variation stock status --
  void fetchPVariationStockStatus() {
    variationStockStatus.value = selectedVariation.value.stockCount > 0
        ? 'in stock...'
        : 'out of stock...';
  }

  /// -- fetch product variation price --
  String fetchPVariationPrice() {
    return (selectedVariation.value.pSalePrice > 0
            ? selectedVariation.value.pSalePrice
            : selectedVariation.value.pPrice)
        .toString();
  }

  /// -- reset selected attributes when switching products --
  void resetSelectedAttributes() {
    selectedAttributes.clear();
    variationStockStatus.value = '';
    selectedVariation.value = CProductVariationsModel.empty();
  }
}
