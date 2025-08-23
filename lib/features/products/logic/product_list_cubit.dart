import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/product_model.dart';
import '../data/product_repository.dart';

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

class ProductListCubit extends Cubit<ProductListState> {
  final ProductRepository repo;
  ProductListCubit(this.repo) : super(ProductListLoading());

  Future<void> load() async {
    emit(ProductListLoading());
    try {
      final data = await repo.getProducts();
      emit(ProductListSuccess(data));
    } catch (e) {
      emit(ProductListError(e.toString()));
    }
  }
}
