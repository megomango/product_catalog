import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import '../../features/products/data/product_remote_data_source.dart';
import '../../features/products/data/product_repository.dart';
import '../../features/products/logic/product_list_cubit/product_list_cubit.dart';

final sl = GetIt.instance;

Future<void> initServiceLocator() async {
  sl.registerFactory<http.Client>(() => http.Client());

  sl.registerLazySingleton<ProductRemoteDataSource>(
        () => ProductRemoteDataSource(client: sl()),
  );

  sl.registerLazySingleton<ProductRepository>(
        () => ProductRepository(remote: sl()),
  );

  sl.registerFactory<ProductListCubit>(
        () => ProductListCubit(sl<ProductRepository>()),
  );
}
