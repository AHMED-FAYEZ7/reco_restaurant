import 'package:reco_restaurant/features/home/domain/entities/item_entity.dart';
import 'package:reco_restaurant/features/home/domain/repositories/home_repository.dart';

class GetItemsUseCase {
  final HomeRepository repository;
  GetItemsUseCase(this.repository);

  Future<List<ItemEntity>> call() => repository.getItems();
}
