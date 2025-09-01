import 'dart:convert';
import 'package:http/http.dart' as http;
import 'product_model.dart';

class ProductRemoteDataSource {
  ProductRemoteDataSource({required this.client});

  final http.Client client;
  static const _base = 'https://fakestoreapi.com';

  List<Product>? _cachedProducts;

  Future<List<Product>> fetchProducts() async {
    if (_cachedProducts != null) {
      return _cachedProducts!;
    }
    final res = await client.get(Uri.parse('$_base/products'));
    if (res.statusCode != 200) throw Exception('Failed to load products');

    final List list = json.decode(res.body) as List;
    _cachedProducts = list.map((e) => Product.fromJson(e)).toList();
    return _cachedProducts!;
  }

  Future<Product> fetchProduct(int id) async {
    if (_cachedProducts != null) {
      try {
        return _cachedProducts!.firstWhere((p) => p.id == id);
      } catch (_) {
      }
    }

    final res = await client.get(Uri.parse('$_base/products/$id'));
    if (res.statusCode != 200) throw Exception('Failed to load product $id');

    final Map<String, dynamic> map = json.decode(res.body);
    return Product.fromJson(map);
  }
}
