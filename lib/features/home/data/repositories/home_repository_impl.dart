// ignore_for_file: avoid_catches_without_on_clauses

import 'package:reco_restaurant/features/home/data/datasources/home_local_data_source.dart';
import 'package:reco_restaurant/features/home/data/datasources/home_remote_data_source.dart';

import 'package:reco_restaurant/features/home/domain/entities/item_entity.dart';
import 'package:reco_restaurant/features/home/domain/repositories/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource remote;
  final HomeLocalDataSource local;

  HomeRepositoryImpl({required this.remote, required this.local});

  @override
  Future<List<ItemEntity>> getItems() async {
    try {
      final remoteItems = await remote.getItems();
      await local.cacheItems(
        remoteItems.map((item) => item.toEntity()).toList(),
      );

      return remoteItems.map((item) => item.toEntity()).toList();
    } catch (e) {
      final localItems = await local.getItems();
      return localItems;
    }
  }

  @override
  Future<void> clearCachedItems() async {
    await local.clearCachedItems();
  }
}
