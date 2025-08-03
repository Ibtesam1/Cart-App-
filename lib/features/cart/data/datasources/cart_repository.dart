import 'dart:convert';
import 'package:cart_app/features/products/data/models/product_model.dart';
import 'package:cart_app/features/products/domain/entities/product_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartRepository {
  static const _cartKey = 'cart_items';

  Future<void> saveCart(Map<ProductEntity, int> cartItems) async {
    final prefs = await SharedPreferences.getInstance();
    final encodedCart = cartItems.map((product, quantity) {
      final model = ProductModel(
        id: product.id,
        title: product.title,
        thumbnail: product.thumbnail,
        price: product.price,
      );
      return MapEntry(product.id, {'product': model.toJson(), 'qty': quantity});
    });
    prefs.setString(_cartKey, jsonEncode(encodedCart));
  }

  Future<Map<ProductEntity, int>> loadCart() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_cartKey);
    if (jsonString == null) return {};
    final decoded = jsonDecode(jsonString) as Map<String, dynamic>;

    final result = <ProductEntity, int>{};
    for (var entry in decoded.entries) {
      final productJson = entry.value['product'];
      final qty = entry.value['qty'] as int;
      result[ProductModel.fromJson(productJson)] = qty;
    }
    return result;
  }

  Future<void> clearCart() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_cartKey);
  }
}
