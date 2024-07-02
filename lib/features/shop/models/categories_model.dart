import 'package:cloud_firestore/cloud_firestore.dart';

class CCategoriesModel {
  CCategoriesModel({
    required this.id,
    required this.cName,
    required this.cImg,
    required this.isFeatured,
    this.parentId = '',
  });

  String id, cName, cImg, parentId;
  bool isFeatured;

  /// -- empty helper function --
  static CCategoriesModel empty() => CCategoriesModel(
        id: '',
        cName: '',
        cImg: '',
        isFeatured: false,
      );

  /// -- convert model to Json structure to store data --
  Map<String, dynamic> toJson() {
    return {
      'categoryName': cName,
      'Thumbnail': cImg,
      'isFeatured': isFeatured,
      'parentId': parentId,
    };
  }

  /// -- map Json oriented document snapshot from Firebase to UserModel --
  factory CCategoriesModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data();

      // -- map JSON record to the CCategories model --
      return CCategoriesModel(
        id: document.id,
        cName: data!['categoryName'] ?? '',
        cImg: data['Thumbnail'] ?? '',
        isFeatured: data['isFeatured'] ?? false,
        parentId: data['parentId'] ?? '',
      );
    } else {
      return CCategoriesModel.empty();
    }
  }
}
