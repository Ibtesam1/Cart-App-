import 'package:cart_app/features/products/data/repositories/product_repository.dart';
import 'package:cart_app/features/products/domain/entities/product_entity.dart';

class FetchProducts {
  final ProductRepository repository;

  FetchProducts(this.repository);

  Future<List<ProductEntity>> call() async {
    return await repository.getProducts();
  }
}
