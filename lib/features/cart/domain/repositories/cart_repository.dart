import 'package:reco_restaurant/features/cart/domain/entities/cart_entity.dart';
import 'package:reco_restaurant/features/home/domain/entities/item_entity.dart';

abstract class CartRepository {
  Future<void> addItemToCart(ItemEntity item, String userId);
  Future<void> removeItemFromCart(ItemEntity item, String userId);
  Future<void> clearItemFromCart(ItemEntity item, String userId);
  Future<CartEntity> getCart(String userId);
}
