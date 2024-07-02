class CProductVariationsModel {
  final String id;
  String sku, pImage;
  String? pDescription;
  double pPrice, pSalePrice;
  int stockCount;
  Map<String, String> pAttributeValues;

  CProductVariationsModel({
    required this.id,
    this.sku = '',
    this.pImage = '',
    this.pDescription = '',
    this.pPrice = 0.0,
    this.pSalePrice = 0.0,
    this.stockCount = 0,
    required this.pAttributeValues,
  });

  /// -- create empty function for clean code --
  static CProductVariationsModel empty() {
    return CProductVariationsModel(
      id: '',
      pAttributeValues: {},
    );
  }

  /// -- convert to Json format --
  toJson() {
    return {
      'id': id,
      'productImage': pImage,
      'productDescription': pDescription,
      'productPrice': pPrice,
      'salePrice': pSalePrice,
      'SKU': sku,
      'stockCount': stockCount,
      'productAttributeValues': pAttributeValues,
    };
  }

  /// -- map json document snapshot from firebase to this model --
  factory CProductVariationsModel.fromJson(Map<String, dynamic> document) {
    final data = document;

    if (data.isEmpty) {
      return CProductVariationsModel.empty();
    } else {
      return CProductVariationsModel(
        id: data['id'] ?? '',
        pPrice: double.parse((data['productPrice'] ?? 0.0).toString()),
        sku: data['SKU'] ?? '',
        stockCount: data['stockCount'] ?? 0,
        pSalePrice: double.parse((data['salePrice'] ?? 0.0).toString()),
        pImage: data['productImage'] ?? '',
        pAttributeValues:
            Map<String, String>.from(data['productAttributeValues']),
      );
    }
  }
}
