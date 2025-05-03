import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../viewmodels/products_viewmodel.dart';
import '../cart/cart_view.dart';
import '../product_detail/product_detail_view.dart';

class ProductsView extends StatelessWidget {
  const ProductsView({super.key});

  @override
  Widget build(BuildContext context) {
    final searchController = TextEditingController();

    return ViewModelBuilder<ProductsViewModel>.reactive(
      viewModelBuilder: () => ProductsViewModel()..loadProducts(),
      builder: (context, viewModel, _) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: const Text('Products'),
            backgroundColor: Colors.white,
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
                  : Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: searchController,
                                decoration: InputDecoration(
                                  hintText: 'Search products...',
                                  prefixIcon: const Icon(Icons.search),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            IconButton(
                              icon: const Icon(Icons.send),
                              onPressed: () {
                                viewModel.startSearch(searchController.text);
                              },
                            ),
                            if (viewModel.isSearching)
                              IconButton(
                                icon: const Icon(Icons.close),
                                onPressed: () {
                                  searchController.clear();
                                  viewModel.cancelSearch();
                                },
                              ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Expanded(
                          child: ListView.builder(
                            itemCount:
                                viewModel.isSearching
                                    ? viewModel.filteredProducts.length
                                    : viewModel.products.length,
                            itemBuilder: (context, index) {
                              final product =
                                  viewModel.isSearching
                                      ? viewModel.filteredProducts[index]
                                      : viewModel.products[index];

                              return Card(
                                elevation: 0,
                                margin: const EdgeInsets.symmetric(
                                  vertical: 10,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: ListTile(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder:
                                            (_) => ProductDetailView(
                                              product: product,
                                            ),
                                      ),
                                    );
                                  },
                                  contentPadding: const EdgeInsets.all(12),
                                  leading: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                      product.thumbnail,
                                      width: 60,
                                      height: 60,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  title: Text(
                                    product.title,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  subtitle: Text(
                                    product.description,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  trailing: IconButton(
                                    icon: Icon(
                                      product.isWishlisted
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                      color: Colors.red,
                                    ),
                                    onPressed: () {
                                      viewModel.toggleWishlist(product);
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            product.isWishlisted
                                                ? 'Added to wishlist!'
                                                : 'Removed from wishlist!',
                                          ),
                                          duration: const Duration(seconds: 1),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
        );
      },
    );
  }
}
