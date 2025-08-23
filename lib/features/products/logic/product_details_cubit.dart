import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/product_model.dart';
import '../data/product_repository.dart';

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

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  final ProductRepository repo;
  ProductDetailsCubit(this.repo) : super(ProductDetailsLoading());

  Future<void> load(int id) async {
    emit(ProductDetailsLoading());
    try {
      final data = await repo.getProduct(id);
      emit(ProductDetailsSuccess(data));
    } catch (e) {
      emit(ProductDetailsError(e.toString()));
    }
  }
}
