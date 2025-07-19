import 'package:reco_restaurant/features/auth/domain/entities/user_entity.dart';
import 'package:reco_restaurant/features/auth/domain/repositories/auth_repository.dart';

class CacheUserUseCase {
  final AuthRepository repository;

  CacheUserUseCase(this.repository);

  Future<void> call(UserEntity user) {
    return repository.cacheUser(user);
  }
}
