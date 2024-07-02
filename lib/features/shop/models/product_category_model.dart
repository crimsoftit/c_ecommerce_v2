import 'package:cloud_firestore/cloud_firestore.dart';

class CProductCategoryModel {
  final String productId, categoryId;

  CProductCategoryModel({
    required this.productId,
    required this.categoryId,
  });

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'categoryId': categoryId,
    };
  }

  factory CProductCategoryModel.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;

    return CProductCategoryModel(
      productId: data['productId'],
      categoryId: data['categoryId'],
    );
  }
}
