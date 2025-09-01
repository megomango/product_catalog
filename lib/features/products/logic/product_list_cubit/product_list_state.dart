import '../../data/product_model.dart';

sealed class ProductListState {}
class ProductListLoading extends ProductListState {}
class ProductListSuccess extends ProductListState {
  final List<Product> products;
  ProductListSuccess(this.products);
}
class ProductListError extends ProductListState {
  final String message;
  ProductListError(this.message);
}
