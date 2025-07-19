import 'package:reco_restaurant/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:reco_restaurant/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:reco_restaurant/features/auth/data/models/user_mode.dart';
import 'package:reco_restaurant/features/auth/domain/entities/user_entity.dart';
import 'package:reco_restaurant/features/auth/domain/repositories/auth_repository.dart';
import 'package:reco_restaurant/core/cache_helper/shared_prefs_helper.dart';
import 'package:reco_restaurant/core/di.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remote;
  final AuthLocalDataSource local;

  AuthRepositoryImpl({required this.remote, required this.local});

  @override
  Future<UserEntity?> signIn(String email, String password) async {
    final user = await remote.signIn(email, password);
    if (user != null) {
      final userModel = UserModel(uid: user.uid, email: user.email!);
      await local.cacheUser(userModel);
      await sl<SharedPrefsHelper>().setUserLoggedIn();
      return userModel.toEntity();
    }
    return null;
  }

  @override
  Future<UserEntity?> signUp(String email, String password) async {
    final user = await remote.signUp(email, password);
    if (user != null) {
      final userModel = UserModel(uid: user.uid, email: user.email!);
      await local.cacheUser(userModel);
      await sl<SharedPrefsHelper>().setUserLoggedIn();
      return userModel.toEntity();
    }
    return null;
  }

  @override
  Future<void> signOut() async {
    await remote.signOut();
    await local.clearCachedUser();
    // مسح الـ userId من الـ SharedPreferences
    await sl<SharedPrefsHelper>().setUserLoggedOut();
  }

  @override
  Future<UserEntity?> getCachedUser() async {
    final map = await local.getCachedUser();
    if (map != null) return map.toEntity();
    return null;
  }

  @override
  Future<void> cacheUser(UserEntity user) async {
    final userModel = UserModel.fromEntity(user);
    await local.cacheUser(userModel);
    await sl<SharedPrefsHelper>().setUserLoggedIn();
  }

  @override
  Future<void> clearCachedUser() async {
    await local.clearCachedUser();
    await sl<SharedPrefsHelper>().setUserLoggedOut();
  }
}
