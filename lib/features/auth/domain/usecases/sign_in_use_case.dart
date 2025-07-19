import 'package:reco_restaurant/features/auth/domain/entities/user_entity.dart';
import 'package:reco_restaurant/features/auth/domain/repositories/auth_repository.dart';

class SignInUseCase {
  final AuthRepository repository;

  SignInUseCase(this.repository);

  Future<UserEntity?> call(String email, String password) {
    return repository.signIn(email, password);
  }
}
