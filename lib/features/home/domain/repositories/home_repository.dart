import 'package:reco_restaurant/features/home/domain/entities/item_entity.dart';

abstract class HomeRepository {
  Future<List<ItemEntity>> getItems();
  Future<void> clearCachedItems();
}
