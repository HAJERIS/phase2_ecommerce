import '../models/product_model.dart';

class CartItem {
  final Product product;
  int quantity;

  CartItem({required this.product, this.quantity = 1});
}

class CartService {
  final List<CartItem> _items = [];

  List<CartItem> get items => _items;

  void addToCart(Product product) {
    final existing = _items.firstWhere(
      (item) => item.product.id == product.id,
      orElse: () => CartItem(product: product, quantity: 0),
    );

    if (existing.quantity == 0) {
      _items.add(CartItem(product: product));
    } else {
      existing.quantity += 1;
    }
  }

  void removeFromCart(Product product) {
    _items.removeWhere((item) => item.product.id == product.id);
  }

  void updateQuantity(Product product, int quantity) {
    final item = _items.firstWhere((item) => item.product.id == product.id);
    item.quantity = quantity;
  }

  double get total =>
      _items.fold(0, (sum, item) => sum + (item.product.price * item.quantity));
}
