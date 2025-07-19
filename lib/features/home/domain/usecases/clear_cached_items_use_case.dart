import 'package:reco_restaurant/features/home/domain/repositories/home_repository.dart';

class ClearCachedItemsUseCase {
  final HomeRepository repository;
  ClearCachedItemsUseCase(this.repository);

  Future<void> call() => repository.clearCachedItems();
}
