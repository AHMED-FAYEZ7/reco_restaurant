import 'package:equatable/equatable.dart';
import '../../../domain/entities/item_entity.dart';

class HomeState extends Equatable {
  final List<ItemEntity> items;
  final bool isLoading;
  final bool isRefreshing;
  final String? error;

  const HomeState({
    this.items = const [],
    this.isLoading = false,
    this.isRefreshing = false,
    this.error,
  });

  HomeState copyWith({
    List<ItemEntity>? items,
    bool? isLoading,
    bool? isRefreshing,
    String? error,
  }) {
    return HomeState(
      items: items ?? this.items,
      isLoading: isLoading ?? this.isLoading,
      isRefreshing: isRefreshing ?? this.isRefreshing,
      error: error,
    );
  }

  @override
  List<Object?> get props => [items, isLoading, isRefreshing, error];
}
