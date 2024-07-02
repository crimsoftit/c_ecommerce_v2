class CCartItemModel {
  String productId, pName, variationId;
  double pPrice;
  String? pImg, brandName;
  int quantity;
  Map<String, String>? selectedVariation;

  /// -- constructor --
  CCartItemModel({
    required this.productId,
    required this.quantity,
    this.variationId = '',
    this.pImg,
    this.pPrice = 0.0,
    this.pName = '',
    this.brandName,
    this.selectedVariation,
  });

  /// -- empty cart --
  static CCartItemModel empty() {
    return CCartItemModel(
      productId: '',
      quantity: 0,
    );
  }

  /// -- convert a CCartItem Object to a JSON Map --
  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'productName': pName,
      'productPrice': pPrice,
      'productImg': pImg,
      'quantity': quantity,
      'variationId': variationId,
      'brandName': brandName,
      'selectedVariation': selectedVariation,
    };
  }

  /// -- create a cart item from a JSON Map --
  factory CCartItemModel.fromJson(Map<String, dynamic> json) {
    return CCartItemModel(
      productId: json['productId'],
      pName: json['productName'],
      pPrice: json['productPrice'],
      pImg: json['productImg'],
      quantity: json['quantity'],
      variationId: json['variationId'],
      brandName: json['brandName'],
      selectedVariation: json['selectedVariation'] != null
          ? Map<String, String>.from(json['selectedVariation'])
          : null,
    );
  }
}
