import 'package:ecommerce/views/cart/cart_view.dart';
import 'package:ecommerce/views/product_detail/product_detail_view.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../viewmodels/products_viewmodel.dart';

class ProductsView extends StatelessWidget {
  const ProductsView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProductsViewModel>.reactive(
      viewModelBuilder: () => ProductsViewModel()..loadProducts(),
      builder: (context, viewModel, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Products'),
            actions: [
              IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const CartView()),
                  );
                },
              ),
            ],
          ),
          body:
              viewModel.isBusy
                  ? const Center(child: CircularProgressIndicator())
                  : viewModel.errorMessage != null
                  ? Center(child: Text(viewModel.errorMessage!))
                  : ListView.builder(
                    itemCount: viewModel.products.length,
                    itemBuilder: (context, index) {
                      final product = viewModel.products[index];
                      return ListTile(
                        leading: Image.network(
                          product.thumbnail,
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                        title: Text(product.title),
                        subtitle: Text(product.description),
                        trailing: Text('\$${product.price.toStringAsFixed(2)}'),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (_) => ProductDetailView(product: product),
                            ),
                          );
                        },
                      );
                    },
                  ),
        );
      },
    );
  }
}
