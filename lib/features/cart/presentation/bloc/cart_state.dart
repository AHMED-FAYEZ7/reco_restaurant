import 'package:equatable/equatable.dart';
import 'package:reco_restaurant/features/cart/domain/entities/cart_entity.dart';

class CartState extends Equatable {
  final CartEntity userCart;
  final bool isLoading;
  final bool isOperationLoading;
  final bool successOperation;
  final String? error;

  const CartState({
    this.userCart = const CartEntity(
      userId: '',
      items: [],
      totalPrice: 0,
      totalItems: 0,
    ),
    this.isLoading = false,
    this.isOperationLoading = false,
    this.successOperation = false,
    this.error,
  });

  CartState copyWith({
    CartEntity? userCart,
    bool? isLoading,
    bool? isOperationLoading,
    bool? successOperation,
    String? error,
  }) {
    return CartState(
      userCart: userCart ?? this.userCart,
      isLoading: isLoading ?? this.isLoading,
      isOperationLoading: isOperationLoading ?? this.isOperationLoading,
      successOperation: successOperation ?? this.successOperation,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [
    userCart,
    isLoading,
    isOperationLoading,
    successOperation,
    error,
  ];
}
