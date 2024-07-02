class CProductAttributeModel {
  String? aName;
  final List<String>? aValues;

  CProductAttributeModel({
    this.aName,
    this.aValues,
  });

  /// -- empty helper function --
  static CProductAttributeModel empty() {
    return CProductAttributeModel(
      aName: '',
      aValues: [],
    );
  }

  /// -- convert to Json format --
  toJson() {
    return {
      'attributeName': aName,
      'attributeValues': aValues,
    };
  }

  /// -- map jSon document snapshot from Firebase to UserModel --
  factory CProductAttributeModel.fromJson(Map<String, dynamic> document) {
    final data = document;

    if (data.isEmpty) {
      return CProductAttributeModel.empty();
    } else {
      return CProductAttributeModel(
        aName: data.containsKey('attributeName') ? data['attributeName'] : '',
        aValues: List<String>.from(data['attributeValues']),
      );
    }
  }
}
