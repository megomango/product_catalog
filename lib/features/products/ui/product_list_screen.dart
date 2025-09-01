import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:product_catalog/features/products/ui/product_card.dart';
import '../../../core/di/service_locator.dart';
import '../../../l10n/app_localizations.dart';
import '../data/product_repository.dart';
import '../logic/product_list_cubit/product_list_cubit.dart';
import '../logic/product_list_cubit/product_list_state.dart';

class ProductListScreen extends StatefulWidget {

  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  late final ProductListCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = ProductListCubit(sl<ProductRepository>())..load();
  }

  @override
  void dispose() {
    cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(  title: Text(AppLocalizations.of(context)!.products),
      ),
      body: Padding(
        padding: EdgeInsets.all(12.w),
        child: BlocBuilder<ProductListCubit, ProductListState>(
          bloc: cubit,
          builder: (context, state) {
            if (state is ProductListLoading) {
              return Center(child: Text(AppLocalizations.of(context)!.noData));
            }
            if (state is ProductListError) {
              return Center(child: Text(state.message));
            }
            final data = (state as ProductListSuccess).products;
            if (data.isEmpty) {
              return const Center(child: Text('No data'));
            }
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: ScreenUtil().screenWidth > 600 ? 4 : 2,
                mainAxisSpacing: 12.h,
                crossAxisSpacing: 12.w,
                childAspectRatio: 0.65,
              ),
              itemCount: data.length,
              itemBuilder: (context, index) => ProductCard(product: data[index]),
            );
          },
        ),
      ),
    );
  }
}
