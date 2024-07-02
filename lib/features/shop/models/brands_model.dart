import 'package:cloud_firestore/cloud_firestore.dart';

class CBrandModel {
  String id, brandName, brandImage;
  bool? isFeatured;
  int? pCount;

  CBrandModel({
    required this.id,
    required this.brandName,
    required this.brandImage,
    this.isFeatured,
    this.pCount,
  });

  /// -- empty helper function --
  static CBrandModel empty() {
    return CBrandModel(
      id: '',
      brandName: '',
      brandImage: '',
      pCount: 0,
      isFeatured: false,
    );
  }

  /// -- convert model to jSon format to store data in firestore --
  toJson() {
    return {
      'id': id,
      'brandName': brandName,
      'brandImage': brandImage,
      'productsCount': pCount,
      'isFeatured': isFeatured,
    };
  }

  /// -- map jSon document snapshot from Firebase to UserModel --
  factory CBrandModel.fromJson(Map<String, dynamic> document) {
    final data = document;
    if (data.isEmpty) {
      return CBrandModel.empty();
    } else {
      return CBrandModel(
        id: data['id'] ?? '',
        brandName: data['brandName'] ?? '',
        brandImage: data['brandImage'] ?? '',
        pCount: int.parse((data['productsCount'] ?? 0).toString()),
        isFeatured: data['isFeatured'] ?? false,
      );
    }
  }

  /// -- map jSon document snapshot from Firebase to CBrandModel --
  factory CBrandModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;

      // map JSON data object to CBrandModel
      return CBrandModel(
        id: document.id,
        brandName: data['brandName'] ?? '',
        brandImage: data['brandImage'] ?? '',
        pCount: int.parse((data['productsCount'] ?? 0).toString()),
        isFeatured: data['isFeatured'] ?? false,
      );
    } else {
      return CBrandModel.empty();
    }
  }
}
