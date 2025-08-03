import 'package:cart_app/core/router.dart';
import 'package:cart_app/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:cart_app/features/cart/data/datasources/cart_repository.dart';
import 'package:cart_app/features/products/domain/usecases/fetch_products.dart';
import 'package:cart_app/features/products/presentation/cubit/product_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/products/data/datasources/product_remote_datasource.dart';
import 'features/products/data/repositories/product_repository.dart';

void main() {
  final cartRepo = CartRepository();
  final remoteDataSource = ProductRemoteDataSource();
  final productRepository = ProductRepository(remoteDataSource);
  final fetchProducts = FetchProducts(productRepository);

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ProductCubit(fetchProducts)..fetchProducts()),
        BlocProvider(create: (_) => CartCubit(cartRepo)),
      ],
      child: const ShoppingCartApp(),
    ),
  );
}

class ShoppingCartApp extends StatelessWidget {
  const ShoppingCartApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData(primarySwatch: Colors.teal),
      debugShowCheckedModeBanner: false,
      routerConfig: AppRouter.router,
    );
  }
}
