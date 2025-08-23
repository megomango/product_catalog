import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import '../../features/products/data/product_remote_data_source.dart';
import '../../features/products/data/product_repository.dart';

final sl = GetIt.instance;

Future<void> initServiceLocator() async {
  // External
  sl.registerLazySingleton<http.Client>(() => http.Client());

  // Data sources
  sl.registerLazySingleton<ProductRemoteDataSource>(
        () => ProductRemoteDataSource(client: sl()),
  );

  // Repositories
  sl.registerLazySingleton<ProductRepository>(
        () => ProductRepository(remote: sl()),
  );
}
