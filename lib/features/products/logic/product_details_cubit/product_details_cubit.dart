import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_catalog/features/products/logic/product_details_cubit/product_details_state.dart';
import '../../data/product_repository.dart';

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
