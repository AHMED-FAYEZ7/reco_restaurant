import 'package:equatable/equatable.dart';
import 'package:reco_restaurant/features/home/domain/entities/item_entity.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object?> get props => [];
}

class AddToCartEvent extends CartEvent {
  final ItemEntity item;
  final String userId;
  const AddToCartEvent({required this.item, required this.userId});

  @override
  List<Object?> get props => [item, userId];
}

class RemoveFromCartEvent extends CartEvent {
  final ItemEntity item;
  final String userId;
  const RemoveFromCartEvent({required this.item, required this.userId});

  @override
  List<Object?> get props => [item, userId];
}

class ClearItemFromCartEvent extends CartEvent {
  final ItemEntity item;
  final String userId;
  const ClearItemFromCartEvent({required this.item, required this.userId});

  @override
  List<Object?> get props => [item, userId];
}

class GetCartItemsEvent extends CartEvent {
  final String userId;
  const GetCartItemsEvent({required this.userId});

  @override
  List<Object?> get props => [userId];
}

class ClearCartEvent extends CartEvent {
  final String userId;
  const ClearCartEvent({required this.userId});

  @override
  List<Object?> get props => [userId];
}
