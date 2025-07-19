import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:reco_restaurant/core/cache_helper/shared_prefs_helper.dart';
import 'package:reco_restaurant/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:reco_restaurant/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:reco_restaurant/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:reco_restaurant/features/auth/domain/repositories/auth_repository.dart';
import 'package:reco_restaurant/features/auth/domain/usecases/cache_user_use_case.dart';
import 'package:reco_restaurant/features/auth/domain/usecases/clear_cashed_user_use_case.dart';
import 'package:reco_restaurant/features/auth/domain/usecases/get_cached_user_use_case.dart';
import 'package:reco_restaurant/features/auth/domain/usecases/sign_in_use_case.dart';
import 'package:reco_restaurant/features/auth/domain/usecases/sign_out_use_case.dart';
import 'package:reco_restaurant/features/auth/domain/usecases/sign_up_use_case.dart';
import 'package:reco_restaurant/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:reco_restaurant/features/cart/data/datasources/cart_remote_data_source.dart';
import 'package:reco_restaurant/features/cart/data/repositories/home_repository_impl.dart';
import 'package:reco_restaurant/features/cart/domain/repositories/cart_repository.dart';
import 'package:reco_restaurant/features/cart/domain/usecases/add_item_to_cart_use_case.dart';
import 'package:reco_restaurant/features/cart/domain/usecases/clear_item_from_cart.dart';
import 'package:reco_restaurant/features/cart/domain/usecases/get_cart_usecase.dart';
import 'package:reco_restaurant/features/cart/domain/usecases/remove_item_from_cart_use_case.dart';
import 'package:reco_restaurant/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:reco_restaurant/features/home/data/datasources/home_local_data_source.dart';
import 'package:reco_restaurant/features/home/data/datasources/home_remote_data_source.dart';
import 'package:reco_restaurant/features/home/data/repositories/home_repository_impl.dart';
import 'package:reco_restaurant/features/home/domain/repositories/home_repository.dart';
import 'package:reco_restaurant/features/home/domain/usecases/clear_cached_items_use_case.dart';
import 'package:reco_restaurant/features/home/domain/usecases/get_items_usecase.dart';
import 'package:reco_restaurant/features/home/presentation/bloc/home_bloc/home_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // shared_preferences
  final prefs = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => prefs);
  sl.registerLazySingleton(() => SharedPrefsHelper(sl()));
  // Firebase
  sl.registerLazySingleton(() => FirebaseAuth.instance);
  sl.registerLazySingleton(() => FirebaseFirestore.instance);

  // Features - Auth
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => FirebaseAuthRemoteDataSource(sl()),
  );
  sl.registerLazySingleton<AuthLocalDataSource>(
    () => HiveAuthLocalDataSource(),
  );

  // Repository
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(remote: sl(), local: sl()),
  );

  // Use Cases
  sl.registerLazySingleton(() => SignInUseCase(sl()));
  sl.registerLazySingleton(() => SignUpUseCase(sl()));
  sl.registerLazySingleton(() => SignOutUseCase(sl()));
  sl.registerLazySingleton(() => GetCachedUserUseCase(sl()));
  sl.registerLazySingleton(() => CacheUserUseCase(sl()));
  sl.registerLazySingleton(() => ClearCachedUserUseCase(sl()));

  // Bloc
  sl.registerFactory(
    () => AuthBloc(
      signUpUseCase: sl(),
      signInUseCase: sl(),
      signOutUseCase: sl(),
      getCachedUserUseCase: sl(),
      cacheUserUseCase: sl(),
      clearCachedUserUseCase: sl(),
    ),
  );

  // Features - home

  sl.registerLazySingleton<HomeRemoteDataSource>(
    () => FirebaseHomeRemoteDataSource(sl()),
  );

  sl.registerLazySingleton<HomeLocalDataSource>(
    () => HiveHomeLocalDataSourceImpl(),
  );

  sl.registerLazySingleton<HomeRepository>(
    () => HomeRepositoryImpl(remote: sl(), local: sl()),
  );

  sl.registerLazySingleton(() => GetItemsUseCase(sl()));
  sl.registerLazySingleton(() => ClearCachedItemsUseCase(sl()));

  sl.registerFactory(
    () => HomeBloc(getItemsUseCase: sl(), clearCachedItemsUseCase: sl()),
  );

  // Features - cart
  sl.registerLazySingleton<CartRemoteDataSource>(
    () => FirebaseCartRemoteDataSource(sl()),
  );

  sl.registerLazySingleton<CartRepository>(
    () => CartRepositoryImpl(remote: sl()),
  );

  sl.registerLazySingleton(() => AddItemToCartUseCase(sl()));
  sl.registerLazySingleton(() => RemoveItemFromCartUseCase(sl()));
  sl.registerLazySingleton(() => GetCartUseCase(sl()));
  sl.registerLazySingleton(() => ClearItemFromCartUseCase(sl()));

  sl.registerFactory(
    () => CartBloc(
      addToCartUseCase: sl(),
      removeFromCartUseCase: sl(),
      getCartUseCase: sl(),
      clearItemFromCartUseCase: sl(),
    ),
  );
}
