import 'package:stacked/stacked.dart';

import '../app/app.locator.dart';
import '../models/product_model.dart';
import '../services/product_service.dart';

class ProductsViewModel extends BaseViewModel {
  final ProductService _productService = locator<ProductService>();

  List<Product> products = [];
  String? errorMessage;

  Future<void> loadProducts() async {
    setBusy(true);
    errorMessage = null;

    try {
      products = await _productService.fetchProducts();
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      setBusy(false);
    }
  }
}
