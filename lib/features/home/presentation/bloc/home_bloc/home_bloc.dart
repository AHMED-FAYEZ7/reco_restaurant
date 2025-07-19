import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reco_restaurant/features/home/domain/usecases/clear_cached_items_use_case.dart';
import 'package:reco_restaurant/features/home/domain/usecases/get_items_usecase.dart';
import 'home_state.dart';
import 'home_event.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetItemsUseCase getItemsUseCase;
  final ClearCachedItemsUseCase clearCachedItemsUseCase;

  HomeBloc({
    required this.getItemsUseCase,
    required this.clearCachedItemsUseCase,
  }) : super(const HomeState()) {
    on<GetItemsEvent>(_onGetItems);
    on<RefreshItemsEvent>(_onRefreshItems);
    on<ClearCachedItemsEvent>(_onClearCachedItems);
  }

  Future<void> _onGetItems(GetItemsEvent event, Emitter<HomeState> emit) async {
    emit(state.copyWith(isLoading: true, isRefreshing: false, error: null));
    try {
      final items = await getItemsUseCase();
      emit(
        state.copyWith(
          items: items,
          isLoading: false,
          isRefreshing: false,
          error: null,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          isRefreshing: false,
          error: e.toString(),
        ),
      );
    }
  }

  Future<void> _onRefreshItems(
    RefreshItemsEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(isRefreshing: true, isLoading: false, error: null));
    try {
      final items = await getItemsUseCase();
      emit(
        state.copyWith(
          items: items,
          isRefreshing: false,
          isLoading: false,
          error: null,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          isRefreshing: false,
          isLoading: false,
          error: e.toString(),
        ),
      );
    }
  }

  Future<void> _onClearCachedItems(
    ClearCachedItemsEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, isRefreshing: false, error: null));
    try {
      await clearCachedItemsUseCase();
    } catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          isRefreshing: false,
          error: e.toString(),
        ),
      );
    }
  }
}
