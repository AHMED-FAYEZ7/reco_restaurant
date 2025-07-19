import 'package:reco_restaurant/features/cart/domain/repositories/cart_repository.dart';
import 'package:reco_restaurant/features/home/domain/entities/item_entity.dart';

class ClearItemFromCartUseCase {
  final CartRepository repository;

  ClearItemFromCartUseCase(this.repository);

  Future<void> call(ItemEntity item, String userId) async {
    return repository.clearItemFromCart(item, userId);
  }
}
