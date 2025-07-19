import 'package:hive/hive.dart';
import 'package:reco_restaurant/core/constants/hive_type_ids.dart';
import 'package:reco_restaurant/features/home/domain/entities/item_entity.dart';

part 'item_model.g.dart';

@HiveType(typeId: HiveTypeId.item)
class ItemModel {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final double price;

  @HiveField(3)
  final String image;

  @HiveField(4)
  final bool isInCart;

  @HiveField(5)
  final double quantityInCart;

  const ItemModel({
    required this.id,
    required this.name,
    required this.price,
    required this.image,
    required this.isInCart,
    required this.quantityInCart,
  });

  factory ItemModel.createNew({
    required String id,
    required String name,
    required double price,
    required String image,
  }) {
    return ItemModel(
      id: id,
      name: name,
      price: price,
      image: image,
      isInCart: false,
      quantityInCart: 0,
    );
  }

  factory ItemModel.fromJson(Map<String, dynamic> json) {
    return ItemModel(
      id: json['id'],
      name: json['name'],
      price: (json['price'] as num).toDouble(),
      image: json['image'],
      isInCart: json['is_in_cart'] ?? false,
      quantityInCart: (json['quantity_in_cart'] as num?)?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'image': image,
      'is_in_cart': isInCart,
      'quantity_in_cart': quantityInCart,
    };
  }

  ItemEntity toEntity() => ItemEntity(
    id: id,
    name: name,
    price: price,
    image: image,
    isInCart: isInCart,
    quantityInCart: quantityInCart,
  );

  static ItemModel fromEntity(ItemEntity entity) => ItemModel(
    id: entity.id,
    name: entity.name,
    price: entity.price,
    image: entity.image,
    isInCart: entity.isInCart,
    quantityInCart: entity.quantityInCart,
  );
}
