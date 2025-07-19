import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reco_restaurant/features/cart/domain/usecases/add_item_to_cart_use_case.dart';
import 'package:reco_restaurant/features/cart/domain/usecases/clear_item_from_cart.dart';
import 'package:reco_restaurant/features/cart/domain/usecases/get_cart_usecase.dart';
import 'package:reco_restaurant/features/cart/domain/usecases/remove_item_from_cart_use_case.dart';
import 'package:reco_restaurant/features/cart/presentation/bloc/cart_event.dart';
import 'package:reco_restaurant/features/cart/presentation/bloc/cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final AddItemToCartUseCase addToCartUseCase;
  final RemoveItemFromCartUseCase removeFromCartUseCase;
  final GetCartUseCase getCartUseCase;
  final ClearItemFromCartUseCase clearItemFromCartUseCase;

  CartBloc({
    required this.addToCartUseCase,
    required this.removeFromCartUseCase,
    required this.getCartUseCase,
    required this.clearItemFromCartUseCase,
  }) : super(CartState()) {
    on<AddToCartEvent>(_onAddToCart);
    on<RemoveFromCartEvent>(_onRemoveFromCart);
    on<GetCartItemsEvent>(_onGetCartItems);
    on<ClearItemFromCartEvent>(_onClearItemFromCart);
    on<ClearCartEvent>(_onClearCart);
  }

  Future<void> _onAddToCart(
    AddToCartEvent event,
    Emitter<CartState> emit,
  ) async {
    try {
      emit(state.copyWith(isOperationLoading: true));
      await addToCartUseCase.call(event.item, event.userId);
      add(GetCartItemsEvent(userId: event.userId));
      emit(state.copyWith(isOperationLoading: false, successOperation: true));
    } catch (e) {
      emit(state.copyWith(isOperationLoading: false, error: e.toString()));
    }
  }

  Future<void> _onRemoveFromCart(
    RemoveFromCartEvent event,
    Emitter<CartState> emit,
  ) async {
    try {
      emit(state.copyWith(isOperationLoading: true));
      await removeFromCartUseCase.call(event.item, event.userId);
      add(GetCartItemsEvent(userId: event.userId));
      emit(state.copyWith(isOperationLoading: false, successOperation: true));
    } catch (e) {
      emit(state.copyWith(isOperationLoading: false, error: e.toString()));
    }
  }

  Future<void> _onClearItemFromCart(
    ClearItemFromCartEvent event,
    Emitter<CartState> emit,
  ) async {
    try {
      emit(state.copyWith(isOperationLoading: true));
      await clearItemFromCartUseCase.call(event.item, event.userId);
      add(GetCartItemsEvent(userId: event.userId));
      emit(state.copyWith(isOperationLoading: false, successOperation: true));
    } catch (e) {
      emit(state.copyWith(isOperationLoading: false, error: e.toString()));
    }
  }

  Future<void> _onGetCartItems(
    GetCartItemsEvent event,
    Emitter<CartState> emit,
  ) async {
    try {
      emit(state.copyWith(isLoading: true));
      final cart = await getCartUseCase.call(event.userId);
      emit(state.copyWith(isLoading: false, userCart: cart));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  Future<void> _onClearCart(
    ClearCartEvent event,
    Emitter<CartState> emit,
  ) async {
    try {
      emit(state.copyWith(isOperationLoading: true));
      final currentItems = state.userCart.items;
      for (final item in currentItems) {
        await clearItemFromCartUseCase.call(item, event.userId);
      }
      add(GetCartItemsEvent(userId: event.userId));
      emit(state.copyWith(isOperationLoading: false, successOperation: true));
    } catch (e) {
      emit(state.copyWith(isOperationLoading: false, error: e.toString()));
    }
  }
}
