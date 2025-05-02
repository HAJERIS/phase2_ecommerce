import 'package:ecommerce/services/cart_service.dart';
import 'package:ecommerce/services/product_service.dart';
import 'package:stacked/stacked_annotations.dart';

import '../services/auth_service.dart';

@StackedApp(
  routes: [],
  dependencies: [
    LazySingleton(classType: AuthService),
    LazySingleton(classType: ProductService),
    LazySingleton(classType: CartService),
  ],
)
class App {}
