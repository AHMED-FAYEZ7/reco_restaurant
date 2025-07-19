import 'package:reco_restaurant/features/auth/domain/entities/user_entity.dart';

abstract class AuthRepository {
  Future<UserEntity?> signUp(String email, String password);
  Future<UserEntity?> signIn(String email, String password);
  Future<void> signOut();
  Future<UserEntity?> getCachedUser();
  Future<void> cacheUser(UserEntity user);
  Future<void> clearCachedUser();
}
