import 'package:reco_restaurant/features/cart/domain/repositories/cart_repository.dart';
import 'package:reco_restaurant/features/home/domain/entities/item_entity.dart';

class AddItemToCartUseCase {
  final CartRepository repository;
  AddItemToCartUseCase(this.repository);

  Future<void> call(ItemEntity item, String userId) =>
      repository.addItemToCart(item, userId);
}
