import '../../data/product_model.dart';

sealed class ProductDetailsState {}
class ProductDetailsLoading extends ProductDetailsState {}
class ProductDetailsSuccess extends ProductDetailsState {
  final Product product;
  ProductDetailsSuccess(this.product);
}
class ProductDetailsError extends ProductDetailsState {
  final String message;
  ProductDetailsError(this.message);
}
