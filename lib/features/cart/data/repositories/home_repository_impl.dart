// ignore_for_file: avoid_catches_without_on_clauses

import 'package:reco_restaurant/features/cart/data/datasources/cart_remote_data_source.dart';
import 'package:reco_restaurant/features/cart/domain/entities/cart_entity.dart';
import 'package:reco_restaurant/features/cart/domain/repositories/cart_repository.dart';
import 'package:reco_restaurant/features/home/data/models/item_model.dart';
import 'package:reco_restaurant/features/home/domain/entities/item_entity.dart';

class CartRepositoryImpl implements CartRepository {
  final CartRemoteDataSource remote;

  CartRepositoryImpl({required this.remote});

  @override
  Future<void> addItemToCart(ItemEntity item, String userId) async {
    await remote.addItemToCart(ItemModel.fromEntity(item), userId);
  }

  @override
  Future<void> removeItemFromCart(ItemEntity item, String userId) async {
    await remote.removeItemFromCart(ItemModel.fromEntity(item), userId);
  }

  @override
  Future<void> clearItemFromCart(ItemEntity item, String userId) async {
    await remote.clearItemFromCart(ItemModel.fromEntity(item), userId);
  }

  @override
  Future<CartEntity> getCart(String userId) async {
    final cart = await remote.getCart(userId);
    return cart.toEntity();
  }
}
