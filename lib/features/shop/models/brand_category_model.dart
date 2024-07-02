import 'package:cloud_firestore/cloud_firestore.dart';

class CBrandCategoryModel {
  final String brandId, categoryId;

  CBrandCategoryModel({
    required this.brandId,
    required this.categoryId,
  });

  Map<String, dynamic> toJson() {
    return {
      'brandId': brandId,
      'categoryId': categoryId,
    };
  }

  factory CBrandCategoryModel.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return CBrandCategoryModel(
      brandId: data['brandId'] as String,
      categoryId: data['categoryId'] as String,
    );
  }
}
