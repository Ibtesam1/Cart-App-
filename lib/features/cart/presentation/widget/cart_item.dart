import 'package:flutter/material.dart';
import 'package:cart_app/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:cart_app/features/products/domain/entities/product_entity.dart';

class CartItem extends StatelessWidget {
  final ProductEntity product;
  final int qty;
  final CartCubit cartCubit;
  final bool isGrid;

  const CartItem({
    required this.product,
    required this.qty,
    required this.cartCubit,
    this.isGrid = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            offset: const Offset(0, 3),
            blurRadius: 6,
          ),
        ],
      ),
      child: isGrid
          ? Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      product.thumbnail,
                      height: 100,
                      width: double.infinity,
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    product.title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                      overflow: TextOverflow.ellipsis
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Price: \$${product.price.toStringAsFixed(2)}',
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Qty: $qty',
                        style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.remove, color: Colors.red),
                            onPressed: () => cartCubit.removeFromCart(product),
                          ),
                          IconButton(
                            icon: const Icon(Icons.add, color: Colors.green),
                            onPressed: () => cartCubit.addToCart(product),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            )
          : ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  product.thumbnail,
                  width: 70,
                  fit: BoxFit.cover,
                ),
              ),
              title: Text(
                product.title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                    overflow: TextOverflow.ellipsis

                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 5),
                  Text(
                    'Price: \$${product.price.toStringAsFixed(2)}',
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Qty: $qty',
                    style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                  ),
                ],
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove, color: Colors.red),
                    onPressed: () => cartCubit.removeFromCart(product),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add, color: Colors.green),
                    onPressed: () => cartCubit.addToCart(product),
                  ),
                ],
              ),
            ),
    );
  }
}
