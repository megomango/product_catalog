import 'product_model.dart';
import 'product_remote_data_source.dart';

class ProductRepository {
  ProductRepository({required this.remote});
  final ProductRemoteDataSource remote;

  Future<List<Product>> getProducts() => remote.fetchProducts();
  Future<Product> getProduct(int id) => remote.fetchProduct(id);
}
