import 'package:hive/hive.dart';
import 'package:reco_restaurant/core/constants/hive_type_ids.dart';
import 'package:reco_restaurant/features/cart/domain/entities/cart_entity.dart';
import 'package:reco_restaurant/features/home/data/models/item_model.dart';

part 'cart_mode.g.dart';

@HiveType(typeId: HiveTypeId.cart)
class CartModel {
  @HiveField(0)
  final String userId;

  @HiveField(1)
  final List<ItemModel> items;

  @HiveField(2)
  final double totalPrice;

  @HiveField(3)
  final double totalItems;

  const CartModel({
    required this.userId,
    required this.items,
    required this.totalPrice,
    required this.totalItems,
  });

  // Factory method for creating an empty cart
  factory CartModel.empty() {
    return CartModel(userId: '', items: [], totalPrice: 0.0, totalItems: 0);
  }

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      userId: json['user_id'],
      items: json['items'],
      totalPrice: (json['total_price'] as num).toDouble(),
      totalItems: (json['total_items'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'items': items,
      'total_price': totalPrice,
      'total_items': totalItems,
    };
  }

  CartEntity toEntity() => CartEntity(
    userId: userId,
    items: items.map((item) => item.toEntity()).toList(),
    totalPrice: totalPrice,
    totalItems: totalItems,
  );

  static CartModel fromEntity(CartEntity entity) => CartModel(
    userId: entity.userId,
    items: entity.items.map((item) => ItemModel.fromEntity(item)).toList(),
    totalPrice: entity.totalPrice,
    totalItems: entity.totalItems,
  );
}
