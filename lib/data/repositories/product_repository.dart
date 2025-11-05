import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product.dart';

class ProductRepository {
  static const _baseUrl = 'https://fakestoreapi.com';

  final http.Client httpClient;

  ProductRepository({http.Client? httpClient})
      : httpClient = httpClient ?? http.Client();

  Future<List<Product>> fetchProducts() async {
    final uri = Uri.parse('$_baseUrl/products');
    final resp = await httpClient.get(uri);

    if (resp.statusCode != 200) {
      throw Exception('Failed to load products: ${resp.statusCode}');
    }

    final List<dynamic> decoded = json.decode(resp.body) as List<dynamic>;
    return decoded.map((e) => Product.fromMap(e as Map<String, dynamic>)).toList();
  }

  Future<Product> fetchProductById(int id) async {
    final uri = Uri.parse('$_baseUrl/products/$id');
    final resp = await httpClient.get(uri);

    if (resp.statusCode != 200) {
      throw Exception('Failed to load product: ${resp.statusCode}');
    }

    final Map<String, dynamic> decoded = json.decode(resp.body) as Map<String, dynamic>;
    return Product.fromMap(decoded);
  }
}
