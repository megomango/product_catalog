import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_catalog/features/products/logic/product_list_cubit/product_list_state.dart';
import '../../data/product_repository.dart';

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
