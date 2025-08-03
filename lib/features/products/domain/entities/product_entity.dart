class ProductEntity {
  final String id;
  final String title;
  final String thumbnail;
  final double price;

  ProductEntity({
    required this.id,
    required this.title,
    required this.thumbnail,
    required this.price,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ProductEntity && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
