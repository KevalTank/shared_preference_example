class ProductModel {
  const ProductModel({
    required this.id,
    required this.productName,
    required this.productDescription,
    required this.createdTime,
  });

  final String id;
  final String productName;
  final String productDescription;
  final DateTime createdTime;

  ProductModel copyWith({
    String? id,
    String? productName,
    String? productDescription,
    DateTime? createdTime,
  }) {
    return ProductModel(
      id: id ?? this.id,
      productName: productName ?? this.productName,
      productDescription: productDescription ?? this.productDescription,
      createdTime: createdTime ?? this.createdTime,
    );
  }

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      productName: json['productName'],
      productDescription: json['productDescription'],
      createdTime: DateTime.parse(json['created_time']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'productName': productName,
      'productDescription': productDescription,
      'created_time': createdTime.toIso8601String(),
    };
  }
}
