import 'package:equatable/equatable.dart';
import 'package:reco_restaurant/features/home/domain/entities/item_entity.dart';

class CartEntity extends Equatable {
  final String userId;
  final List<ItemEntity> items;
  final double totalPrice;
  final double totalItems;

  const CartEntity({
    required this.userId,
    required this.items,
    required this.totalPrice,
    required this.totalItems,
  });

  factory CartEntity.empty() {
    return CartEntity(userId: '', items: [], totalPrice: 0.0, totalItems: 0);
  }

  @override
  List<Object?> get props => [userId, items, totalPrice, totalItems];
}
