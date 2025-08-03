import 'package:cart_app/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:cart_app/features/cart/presentation/pages/cart_page.dart';
import 'package:cart_app/features/products/presentation/cubit/product_cubit.dart';
import 'package:cart_app/features/products/presentation/pages/product_list_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => BlocProvider.value(
          value: BlocProvider.of<ProductCubit>(context),
          child: const ProductListPage(),
        ),
      ),
      GoRoute(
        path: '/cart',
        builder: (context, state) => BlocProvider.value(
          value: BlocProvider.of<CartCubit>(context),
          child: const CartPage(),
        ),
      ),
    ],
  );
}
