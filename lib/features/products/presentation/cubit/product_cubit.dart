import 'package:cart_app/features/products/domain/usecases/fetch_products.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/product_entity.dart';
part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  final FetchProducts fetchProductsUseCase;

  ProductCubit(this.fetchProductsUseCase) : super(ProductLoading());

  Future<void> fetchProducts() async {
    emit(ProductLoading());
    try {
      final products = await fetchProductsUseCase();
      emit(ProductLoaded(products));
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }
}
