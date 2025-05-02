import 'package:flutter/material.dart';

import '../../app/app.locator.dart';
import '../../services/cart_service.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    final cartService = locator<CartService>();
    final items = cartService.items;

    return Scaffold(
      appBar: AppBar(title: const Text('Cart')),
      body:
          items.isEmpty
              ? const Center(child: Text('Your cart is empty'))
              : ListView.builder(
                itemCount: items.length,
                itemBuilder: (_, i) {
                  final item = items[i];
                  return ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    title: Text(item.product.title),
                    subtitle: Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.remove),
                          onPressed:
                              item.quantity > 1
                                  ? () {
                                    cartService.updateQuantity(
                                      item.product,
                                      item.quantity - 1,
                                    );
                                    (context as Element).reassemble();
                                  }
                                  : null,
                        ),
                        Text(
                          '${item.quantity}',
                          style: const TextStyle(fontSize: 16),
                        ),
                        IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: () {
                            cartService.updateQuantity(
                              item.product,
                              item.quantity + 1,
                            );
                            (context as Element).reassemble();
                          },
                        ),
                      ],
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        cartService.removeFromCart(item.product);
                        (context as Element).reassemble();
                      },
                    ),
                  );
                },
              ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        child: Text(
          'Total: \$${cartService.total.toStringAsFixed(2)}',
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
