import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object?> get props => [];
}

class GetItemsEvent extends HomeEvent {
  const GetItemsEvent();

  @override
  List<Object?> get props => [];
}

class RefreshItemsEvent extends HomeEvent {}

class ClearCachedItemsEvent extends HomeEvent {}
