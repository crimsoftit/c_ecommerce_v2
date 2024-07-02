import 'package:duara_ecommerce/data/repositories/products/products_repo.dart';
import 'package:duara_ecommerce/features/shop/controllers/product/p_variation_controller.dart';
import 'package:duara_ecommerce/features/shop/models/cart_item_model.dart';
import 'package:duara_ecommerce/features/shop/models/product_model.dart';
import 'package:duara_ecommerce/utils/constants/enums.dart';
import 'package:duara_ecommerce/utils/local_storage/storage_utility.dart';
import 'package:duara_ecommerce/utils/popups/snackbars.dart';
import 'package:get/get.dart';

class CCartController extends GetxController {
  static CCartController get instance => Get.find();

  /// -- variables --
  RxInt noOfCartItems = 0.obs;
  RxDouble totalCartPrice = 0.0.obs;
  RxInt pQtyInCart = 0.obs;
  RxList<CCartItemModel> cartItems = <CCartItemModel>[].obs;

  final productsRepo = CProductsRepo.instance;

  final variationController = CVariationController.instance;

  CCartController() {
    fetchCartItems();
  }

  /// -- function to add items to cart
  void addToCart(CProductModel product) {
    // cart items qty check
    if (pQtyInCart.value < 1) {
      CPopupSnackBar.customToast(
        message: 'set qty..',
      );
      return;
    }

    // check if variation has been selected
    if (product.productType == CProductType.variable.toString() &&
        variationController.selectedVariation.value.id.isEmpty) {
      CPopupSnackBar.customToast(
        message: 'select variation...',
      );
      return;
    }

    // check product's stock status
    if (product.productType == CProductType.variable.toString()) {
      if (variationController.selectedVariation.value.stockCount < 1) {
        CPopupSnackBar.warningSnackBar(
          title: 'Oh Snap!',
          message: 'products with the selected variation are out of stock!',
        );
        return;
      }
    } else {
      if (product.stockCount < 1) {
        CPopupSnackBar.warningSnackBar(
          title: 'Oh Snap!',
          message: 'this product is out of stock!',
        );
        return;
      }
    }

    // convert ProductModel to a CartItemModel
    final selectedCartItem =
        convertProductToCartItem(product, pQtyInCart.value);

    // check if product is already added to cart
    int pIndex = cartItems.indexWhere((cartItem) =>
        cartItem.productId == selectedCartItem.productId &&
        cartItem.variationId == selectedCartItem.variationId);

    if (pIndex >= 0) {
      // product with selected qty already exists in the cart
      cartItems[pIndex].quantity = selectedCartItem.quantity;
    } else {
      cartItems.add(selectedCartItem);
    }

    // update the user's cart
    updateCart();
    CPopupSnackBar.customToast(message: 'product successfully added to cart!');
  }

  void addSingleItemToCart(CCartItemModel item) {
    int pIndex = cartItems.indexWhere((cartItem) =>
        cartItem.productId == item.productId &&
        cartItem.variationId == item.variationId);

    if (pIndex >= 0) {
      cartItems[pIndex].quantity += 1;

      // if (int.parse(stockCount.toString()) > cartItems[pIndex].quantity) {
      //   cartItems[pIndex].quantity += 1;
      // } else {
      //   CPopupSnackBar.warningSnackBar(
      //     title: 'Oh Noo! ${cartItems[pIndex].pName} is out of stock!',
      //     message: 'only $stockCount are available.',
      //   );
      //   return;
      // }
    } else {
      cartItems.add(item);
    }

    updateCart();
  }

  void removeSingleItemFromCart(CCartItemModel item) {
    int pIndex = cartItems.indexWhere((cartItem) =>
        cartItem.productId == item.productId &&
        cartItem.variationId == item.variationId);

    if (pIndex >= 0) {
      if (cartItems[pIndex].quantity > 1) {
        cartItems[pIndex].quantity -= 1;
      } else {
        // show dialog before completelyremoving
        cartItems[pIndex].quantity == 1
            ? removeFromCartDialog(pIndex)
            : cartItems.removeAt(pIndex);
      }

      updateCart();
    }
  }

  /// -- remove item from cart dialog box --
  void removeFromCartDialog(int index) {
    Get.defaultDialog(
      title: 'remove from cart?',
      middleText: 'are you sure you want to remove this product?',
      onConfirm: () {
        // remove item from cart
        cartItems.removeAt(index);
        updateCart();

        Get.back();
        CPopupSnackBar.customToast(
          // message:
          //     '${cartItems[index].pName} successfully removed from cart...',
          message: 'item successfully removed from cart...',
        );
      },
      onCancel: () {
        Get.back();
      },
    );
  }

  /// -- convert ProductModel to a CartItemModel --
  CCartItemModel convertProductToCartItem(CProductModel product, int qty) {
    if (product.productType == CProductType.single.toString()) {
      // reset variation for a single product type
      variationController.resetSelectedAttributes();
    }

    final variation = variationController.selectedVariation.value;

    final isVariable = variation.id.isNotEmpty;

    final productPrice = isVariable
        ? variation.pSalePrice > 0.0
            ? variation.pSalePrice
            : variation.pPrice
        : product.salePrice > 0.0
            ? product.salePrice
            : product.pPrice;

    return CCartItemModel(
      productId: product.id,
      pName: product.pName,
      pPrice: productPrice,
      quantity: qty,
      variationId: variation.id,
      pImg: isVariable ? variation.pImage : product.thumbnail,
      brandName: product.pBrand != null ? product.pBrand!.brandName : '',
      selectedVariation: isVariable ? variation.pAttributeValues : null,
    );
  }

  /// -- update details of items in the cart --
  void updateCart() {
    updateCartTotals();
    saveCartItems();
    cartItems.refresh();
  }

  /// -- update total price of cart items --
  void updateCartTotals() {
    double calculatedCartPrice = 0.0;
    int calculatedItemsQty = 0;

    for (var item in cartItems) {
      calculatedCartPrice += (item.pPrice) * item.quantity.toDouble();
      calculatedItemsQty += item.quantity;
    }

    totalCartPrice.value = calculatedCartPrice;
    noOfCartItems.value = calculatedItemsQty;
  }

  /// -- save cart details to user's local storage --
  void saveCartItems() {
    final cartItemsList = cartItems.map((item) => item.toJson()).toList();
    CLocalStorage.instance().writeData('cartItems', cartItemsList);
  }

  /// -- fetch items available in user's cart
  void fetchCartItems() {
    final cartItemsList =
        CLocalStorage.instance().readData<List<dynamic>>('cartItems');

    if (cartItemsList != null) {
      cartItems.assignAll(cartItemsList.map(
          (item) => CCartItemModel.fromJson(item as Map<String, dynamic>)));
      updateCartTotals();
    }
  }

  /// -- fetch total qty of products in the user's cart --
  int getProductQtyInCart(String productId) {
    final foundItem = cartItems
        .where((item) => item.productId == productId)
        .fold(0, (initialValue, element) => initialValue + element.quantity);
    return foundItem;
  }

  int getVariationQtyInCart(String productId, String variationId) {
    final foundItem = cartItems.firstWhere(
      (item) => item.productId == productId && item.variationId == variationId,
      orElse: () {
        return CCartItemModel.empty();
      },
    );

    return foundItem.quantity;
  }

  /// -- initialize/update already added items' count in the cart
  void updateCartItemCount(CProductModel product) {
    // if product has no variations calculate cart entries and display totals
    // else set default entries to 0 and display cart item details when variation is selected
    if (product.productType == CProductType.single.toString()) {
      pQtyInCart.value = getProductQtyInCart(product.id);
    } else {
      // get selected variation if any
      final pVariationId = variationController.selectedVariation.value.id;

      if (pVariationId.isNotEmpty) {
        pQtyInCart.value = getVariationQtyInCart(product.id, pVariationId);
      } else {
        pQtyInCart.value = 0;
      }
    }
  }

  /// -- clear cart --
  void clearCart() {
    pQtyInCart.value = 0;
    cartItems.clear();
    updateCart();
  }
}
