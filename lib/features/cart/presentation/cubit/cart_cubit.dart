import 'package:cart_app/features/cart/data/datasources/cart_repository.dart';
import 'package:cart_app/features/products/domain/entities/product_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartState {
  final Map<ProductEntity, int> items;
  CartState({required this.items});

  double get totalPrice => items.entries
      .fold(0, (sum, entry) => sum + entry.key.price * entry.value);
}

class CartCubit extends Cubit<CartState> {
  final CartRepository _repository;

  CartCubit(this._repository) : super(CartState(items: {})) {
    _loadCart();
  }

  void _loadCart() async {
    final savedItems = await _repository.loadCart();
    emit(CartState(items: savedItems));
  }

  void addToCart(ProductEntity product) {
    final current = Map<ProductEntity, int>.from(state.items);
    current.update(product, (value) => value + 1, ifAbsent: () => 1);
    _saveAndEmit(current);
  }

  void removeFromCart(ProductEntity product) {
    final current = Map<ProductEntity, int>.from(state.items);
    if (current.containsKey(product)) {
      current[product] = current[product]! - 1;
      if (current[product]! <= 0) {
        current.remove(product);
      }
      _saveAndEmit(current);
    }
  }

  void clearCart() {
    _repository.clearCart();
    emit(CartState(items: {}));
  }

  void _saveAndEmit(Map<ProductEntity, int> updated) {
    _repository.saveCart(updated);
    emit(CartState(items: updated));
  }
}
