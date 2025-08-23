import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/di/service_locator.dart';
import '../logic/product_details_cubit.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key, required this.productId});
  final int productId;

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  late final ProductDetailsCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = ProductDetailsCubit(sl())..load(widget.productId);
  }

  @override
  void dispose() {
    cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
        bloc: cubit,
        builder: (context, state) {
          if (state is ProductDetailsLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is ProductDetailsError) {
            return Center(child: Text(state.message));
          }
          final product = (state as ProductDetailsSuccess).product;
          return SingleChildScrollView(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AspectRatio(
                  aspectRatio: 1.2,
                  child: Image.network(product.image, fit: BoxFit.contain),
                ),
                SizedBox(height: 16.h),
                Text(product.title, style: Theme.of(context).textTheme.titleLarge),
                SizedBox(height: 8.h),
                Text('\$${product.price.toStringAsFixed(2)}', style: Theme.of(context).textTheme.titleMedium),
                SizedBox(height: 12.h),
                Text(product.description),
              ],
            ),
          );
        },
      ),
    );
  }
}
