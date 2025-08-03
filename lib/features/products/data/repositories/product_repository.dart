import 'dart:convert';
import 'package:cart_app/features/products/data/models/product_model.dart';
import 'package:cart_app/features/products/domain/entities/product_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../datasources/product_remote_datasource.dart';

class ProductRepository {
  final ProductRemoteDataSource remoteDataSource;

  ProductRepository(this.remoteDataSource);

  Future<List<ProductEntity>> getProducts() async {
    final prefs = await SharedPreferences.getInstance();
    final cachedData = prefs.getString('products');

    if (cachedData != null) {
      final List<dynamic> jsonList = jsonDecode(cachedData);
      return jsonList.map((e) => ProductModel.fromJson(e)).toList();
    } else {
      final List<dynamic> productList = await remoteDataSource.fetchProductJson();
      prefs.setString('products', jsonEncode(productList));
      return productList.map((e) => ProductModel.fromJson(e)).toList();
    }
  }
}
