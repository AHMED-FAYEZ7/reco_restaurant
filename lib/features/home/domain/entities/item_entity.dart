import 'package:equatable/equatable.dart';

class ItemEntity extends Equatable {
  final String id;
  final String name;
  final double price;
  final String image;
  final bool isInCart;
  final double quantityInCart;

  const ItemEntity({
    required this.id,
    required this.image,
    required this.name,
    required this.price,
    required this.isInCart,
    required this.quantityInCart,
  });

  // Factory method for creating a new item with default cart values
  factory ItemEntity.createNew({
    required String id,
    required String name,
    required double price,
    required String image,
  }) {
    return ItemEntity(
      id: id,
      name: name,
      price: price,
      image: image,
      isInCart: false,
      quantityInCart: 0,
    );
  }

  @override
  List<Object> get props => [id, image, name, price, isInCart, quantityInCart];
}
