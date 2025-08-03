import '../../domain/entities/product_entity.dart';

class ProductModel extends ProductEntity {
  ProductModel({
    required String id,
    required String title,
    required String thumbnail,
    required double price,
  }) : super(
    id: id,
    title: title,
    thumbnail: thumbnail,
    price: price,
  );

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'].toString(),
      title: json['title'] as String,
      thumbnail: json['thumbnail'] as String,
      price: (json['price'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'thumbnail': thumbnail,
      'price': price,
    };
  }

  ProductEntity toEntity() => ProductEntity(
    id: id,
    title: title,
    thumbnail: thumbnail,
    price: price,
  );

}
