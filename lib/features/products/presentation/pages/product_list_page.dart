import 'package:cart_app/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:cart_app/features/products/presentation/cubit/product_cubit.dart';
import 'package:cart_app/features/products/presentation/widget/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ProductListPage extends StatelessWidget {
  const ProductListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              bottom: BorderSide(
                color: Colors.grey.withOpacity(0.3),
                width: 1,
              ),
            ),
          ),
          child: AppBar(
            backgroundColor: Colors.white,
            centerTitle: false,
            title: const Text(
              'Products',
              style: const TextStyle(
                fontSize: 20,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            forceMaterialTransparency: true,
            actions: [
              BlocBuilder<CartCubit, CartState>(
                builder: (context, cartState) {
                  int itemCount = cartState.items.values
                      .fold(0, (sum, count) => sum + count);
                  return GestureDetector(
                    onTap: () =>
                        context.push('/cart'),
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 25.0),
                          child: const Icon(
                            Icons.shopping_cart,
                            color: Colors.black,
                            size: 25.0,
                          ),
                        ),
                        if (itemCount > 0)
                          Positioned(
                            right: 13,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 1, horizontal: 6),
                              decoration: BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.circle,
                              ),
                              child: Text(
                                '$itemCount',
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      body: BlocBuilder<ProductCubit, ProductState>(
        builder: (context, state) {
          if (state is ProductLoading)
            return const Center(
                child: CircularProgressIndicator(
              color: Colors.teal,
            ));
          if (state is ProductError)
            return Center(
                child: Text(
              'Error: ${state.message}',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w400),
            ));
          final products = (state as ProductLoaded).products;

          return OrientationBuilder(
            builder: (context, orientation) {
              return orientation == Orientation.portrait
                  ? ListView(
                      children: products
                          .map((product) => Builder(
                                builder: (context) => ProductCard(product),
                              ))
                          .toList(),
                    )
                  : GridView.count(
                      crossAxisCount: 2,
                      childAspectRatio: 40 / 35,
                      children: products
                          .map((product) => Builder(
                                builder: (context) => ProductCard(
                                  product,
                                  isGrid: true,
                                ),
                              ))
                          .toList(),
                    );
            },
          );
        },
      ),
    );
  }
}
