import 'dart:convert';
import 'package:http/http.dart' as http;
import 'product_model.dart';

class ProductRemoteDataSource {
  ProductRemoteDataSource({required this.client});

  final http.Client client;
  static const _base = 'https://fakestoreapi.com';

  Future<List<Product>> fetchProducts() async {
    final res = await client.get(Uri.parse('$_base/products'));
    if (res.statusCode != 200) throw Exception('Failed to load products');
    final List list = json.decode(res.body) as List;
    return list.map((e) => Product.fromJson(e)).toList();
  }

  Future<Product> fetchProduct(int id) async {
    final res = await client.get(Uri.parse('$_base/products/$id'));
    if (res.statusCode != 200) throw Exception('Failed to load product $id');
    final Map<String, dynamic> map = json.decode(res.body);
    return Product.fromJson(map);
  }
}
