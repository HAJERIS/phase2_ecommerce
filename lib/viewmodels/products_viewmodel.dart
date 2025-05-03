import 'package:stacked/stacked.dart';

import '../app/app.locator.dart';
import '../models/product_model.dart';
import '../services/product_service.dart';

class ProductsViewModel extends BaseViewModel {
  final ProductService _productService = locator<ProductService>();

  List<Product> products = [];
  List<Product> filteredProducts = [];
  List<Product> wishlist = [];
  String? errorMessage;
  bool isSearching = false;

  Future<void> loadProducts() async {
    setBusy(true);
    errorMessage = null;

    try {
      products = await _productService.fetchProducts();
      filteredProducts = [];
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      setBusy(false);
    }
  }

  void toggleWishlist(Product product) {
    product.isWishlisted = !product.isWishlisted;
    if (product.isWishlisted) {
      wishlist.add(product);
    } else {
      wishlist.removeWhere((p) => p.id == product.id);
    }
    notifyListeners();
  }

  void startSearch(String query) {
    isSearching = true;
    if (query.isEmpty) {
      filteredProducts = [];
    } else {
      filteredProducts =
          products
              .where(
                (p) =>
                    p.title.toLowerCase().contains(query.toLowerCase()) ||
                    p.description.toLowerCase().contains(query.toLowerCase()),
              )
              .toList();
    }
    notifyListeners();
  }

  void cancelSearch() {
    isSearching = false;
    filteredProducts = [];
    notifyListeners();
  }
}
