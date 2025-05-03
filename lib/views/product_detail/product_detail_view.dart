import 'package:ecommerce/app/app.locator.dart';
import 'package:ecommerce/services/cart_service.dart';
import 'package:flutter/material.dart';

import '../../models/product_model.dart';

class ProductDetailView extends StatelessWidget {
  final Product product;
  final CartService _cartService = locator<CartService>();

  ProductDetailView({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(product.title)),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Image.network(product.thumbnail, height: 300),
            const SizedBox(height: 16),
            Text(product.description, style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            Text(
              '\$${product.price.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            ElevatedButton.icon(
              icon: const Icon(Icons.add_shopping_cart),
              label: const Text('Add to Cart'),
              onPressed: () {
                _cartService.addToCart(product);
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(const SnackBar(content: Text('Added to cart!')));
              },
            ),
          ],
        ),
      ),
    );
  }
}
