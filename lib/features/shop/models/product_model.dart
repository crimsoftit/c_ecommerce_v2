import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:duara_ecommerce/features/shop/models/brands_model.dart';
import 'package:duara_ecommerce/features/shop/models/product_attribute_model.dart';
import 'package:duara_ecommerce/features/shop/models/product_variations_model.dart';

class CProductModel {
  String id;
  int stockCount;
  String sku, pName, thumbnail, productType;
  double pPrice, salePrice;
  DateTime? date;
  bool? isFeatured;
  CBrandModel? pBrand;
  String? pDescription;
  String? categoryId;
  List<String>? pImages;
  List<CProductAttributeModel>? pAttributes;
  List<CProductVariationsModel>? pVariations;

  CProductModel({
    required this.id,
    required this.pName,
    required this.stockCount,
    required this.pPrice,
    required this.thumbnail,
    required this.productType,
    required this.sku,
    this.date,
    this.pImages,
    this.salePrice = 0.0,
    this.isFeatured,
    this.categoryId,
    this.pDescription,
    this.pBrand,
    this.pAttributes,
    this.pVariations,
  });

  /// -- create empty function for clean code --
  static CProductModel empty() {
    return CProductModel(
      id: '',
      pName: '',
      stockCount: 0,
      pPrice: 0.0,
      thumbnail: '',
      productType: '',
      sku: '',
      salePrice: 0.0,
      categoryId: '',
    );
  }

  /// -- convert to Json format --
  toJson() {
    return {
      'SKU': sku,
      'productName': pName,
      'stockCount': stockCount,
      'productPrice': pPrice,
      'productImages': pImages,
      'Thumbnail': thumbnail,
      'salePrice': salePrice,
      'isFeatured': isFeatured,
      'categoryId': categoryId,
      'productBrand': pBrand!.toJson(),
      'productDescription': pDescription,
      'productType': productType,
      'productAttributes': pAttributes != null
          ? pAttributes!.map((e) => e.toJson()).toList()
          : [],
      'productVariations': pVariations != null
          ? pVariations!.map((e) => e.toJson()).toList()
          : [],
    };
  }

  /// -- map json document snapshot from firebase to this model --
  factory CProductModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() == null) return CProductModel.empty();

    final data = document.data()!;
    return CProductModel(
      id: document.id,
      sku: data['SKU'],
      pName: data['productName'],
      stockCount: data['stockCount'] ?? 0,
      isFeatured: data['isFeatured'] ?? false,
      pPrice: double.parse((data['productPrice'] ?? 0.0).toString()),
      salePrice: double.parse((data['salePrice'] ?? 0.0).toString()),
      thumbnail: data['Thumbnail'] ?? '',
      categoryId: data['categoryId'] ?? '',
      pDescription: data['productDescription'] ?? '',
      productType: data['productType'] ?? '',
      pBrand: CBrandModel.fromJson(data['productBrand']),
      pImages: data['productImages'] != null
          ? List<String>.from(data['productImages'])
          : [],
      pAttributes: (data['productAttributes'] as List<dynamic>)
          .map((e) => CProductAttributeModel.fromJson(e))
          .toList(),
      pVariations: (data['productVariations'] as List<dynamic>)
          .map((e) => CProductVariationsModel.fromJson(e))
          .toList(),
    );
  }

  /// -- map json document snapshot from firebase to this model --
  factory CProductModel.fromQuerySnapshot(
      QueryDocumentSnapshot<Object?> document) {
    final data = document.data() as Map<String, dynamic>;

    return CProductModel(
      id: document.id,
      sku: data['SKU'] ?? '',
      pName: data['productName'] ?? '',
      stockCount: data['stockCount'] ?? 0,
      isFeatured: data['isFeatured'] ?? false,
      pPrice: double.parse((data['productPrice'] ?? 0.0).toString()),
      salePrice: double.parse((data['salePrice'] ?? 0.0).toString()),
      thumbnail: data['Thumbnail'] ?? '',
      categoryId: data['categoryId'] ?? '',
      pDescription: data['productDescription'] ?? '',
      productType: data['productType'] ?? '',
      pBrand: CBrandModel.fromJson(data['productBrand']),
      pImages: data['productImages'] != null
          ? List<String>.from(data['productImages'])
          : [],
      pAttributes: (data['productAttributes'] as List<dynamic>)
          .map((e) => CProductAttributeModel.fromJson(e))
          .toList(),
      pVariations: (data['productVariations'] as List<dynamic>)
          .map((e) => CProductVariationsModel.fromJson(e))
          .toList(),
    );
  }
}
