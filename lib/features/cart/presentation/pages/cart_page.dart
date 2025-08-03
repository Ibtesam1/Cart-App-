import 'package:cart_app/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:cart_app/features/cart/presentation/widget/cart_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (!didPop) {
          context.pop();
        }
      },
      child: Scaffold(
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
              forceMaterialTransparency: true,
              centerTitle: false,
              leadingWidth: 30,
              leading: IconButton(
                highlightColor: Colors.transparent,
                icon: const Icon(Icons.arrow_back_ios_outlined, color: Colors.black),
                onPressed: () {
                  context.pop();
                },
              ),
              title: const Text(
                'Shopping Cart',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        body: BlocBuilder<CartCubit, CartState>(
          builder: (context, state) {
            if (state.items.isEmpty) {
              return const Center(
                  child: Text(
                'Cart is empty',
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ));
            }
      
            final cartCubit = context.read<CartCubit>();
      
            return OrientationBuilder(builder: (context, orientation) {
              return SafeArea(
                bottom: Theme.of(context).platform == TargetPlatform.iOS
                    ? false
                    : true,
                child: Column(
                  children: [
                    Expanded(
                      child: orientation == Orientation.portrait
                          ? ListView(
                              children: state.items.entries.map((entry) {
                                final product = entry.key;
                                final qty = entry.value;
                                return CartItem(
                                    product: product,
                                    qty: qty,
                                    cartCubit: cartCubit);
                              }).toList(),
                            )
                          : GridView.count(
                              crossAxisCount: 2,
                              childAspectRatio: 10 / 7,
                              padding: const EdgeInsets.all(8),
                              children: state.items.entries.map((entry) {
                                final product = entry.key;
                                final qty = entry.value;
                                return CartItem(
                                  product: product,
                                  qty: qty,
                                  cartCubit: cartCubit,
                                  isGrid: true,
                                );
                              }).toList(),
                            ),
                    ),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border(
                          top: BorderSide(
                            color: Colors.grey.withOpacity(0.4),
                            width: 1,
                          ),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 12,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total:',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            '\$${state.totalPrice.toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              );
            });
          },
        ),
      ),
    );
  }
}
