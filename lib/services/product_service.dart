import 'package:dio/dio.dart';

import '../models/product_model.dart';

class ProductService {
  final Dio _dio = Dio(BaseOptions(baseUrl: 'https://dummyjson.com'));

  Future<List<Product>> fetchProducts() async {
    try {
      final response = await _dio.get('/products');

      final List productsJson = response.data['products'];
      return productsJson.map((json) => Product.fromJson(json)).toList();
    } on DioException catch (e) {
      throw Exception('Failed to load products: ${e.message}');
    }
  }
}
