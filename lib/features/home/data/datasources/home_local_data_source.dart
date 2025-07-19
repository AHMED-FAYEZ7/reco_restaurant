import 'package:hive/hive.dart';
import 'package:reco_restaurant/features/home/data/models/item_model.dart';
import 'package:reco_restaurant/features/home/domain/entities/item_entity.dart';

abstract class HomeLocalDataSource {
  Future<void> cacheItems(List<ItemEntity> items);
  Future<List<ItemEntity>> getItems();
  Future<void> clearCachedItems();
}

class HiveHomeLocalDataSourceImpl implements HomeLocalDataSource {
  static const String itemsBoxName = 'itemsBox';
  static const String cartBoxName = 'cartBox';

  @override
  Future<void> cacheItems(List<ItemEntity> items) async {
    final box = await Hive.openBox<ItemModel>(itemsBoxName);
    await box.clear();
    await box.addAll(items.map((item) => ItemModel.fromEntity(item)));
  }

  @override
  Future<List<ItemEntity>> getItems() async {
    final box = await Hive.openBox<ItemModel>(itemsBoxName);
    return box.values.map((item) => item.toEntity()).toList();
  }

  @override
  Future<void> clearCachedItems() async {
    final box = await Hive.openBox<ItemModel>(itemsBoxName);
    await box.clear();
  }
}
