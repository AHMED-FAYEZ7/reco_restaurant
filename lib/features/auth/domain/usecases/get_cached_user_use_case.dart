import 'package:reco_restaurant/features/auth/domain/entities/user_entity.dart';
import 'package:reco_restaurant/features/auth/domain/repositories/auth_repository.dart';

class GetCachedUserUseCase {
  final AuthRepository repository;

  GetCachedUserUseCase(this.repository);

  Future<UserEntity?> call() {
    return repository.getCachedUser();
  }
}
