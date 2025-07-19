import 'package:reco_restaurant/features/cart/domain/entities/cart_entity.dart';
import 'package:reco_restaurant/features/cart/domain/repositories/cart_repository.dart';

class GetCartUseCase {
  final CartRepository repository;
  GetCartUseCase(this.repository);

  Future<CartEntity> call(String userId) => repository.getCart(userId);
}
