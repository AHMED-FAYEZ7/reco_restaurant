// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reco_restaurant/core/functions/app_snackbar.dart';
import 'package:reco_restaurant/core/helper/app_regex.dart';
import 'package:reco_restaurant/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:reco_restaurant/features/cart/presentation/bloc/cart_event.dart';
import 'package:reco_restaurant/features/cart/presentation/bloc/cart_state.dart';
import 'package:reco_restaurant/core/shared/widgets/item_card_widget/item_card.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartBloc, CartState>(
      listener: (context, state) {
        if (state.error != null) {
          AppSnackBar.showError(
            context,
            AppRegex.cleanFirebaseError(state.error!),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Price: ${state.userCart.totalPrice}\$     No.Items: ${state.userCart.totalItems.toInt()}',
            ),
            centerTitle: true,
            elevation: 0,
          ),
          body: BlocConsumer<CartBloc, CartState>(
            listener: (context, state) {
              if (state.error != null) {
                AppSnackBar.showError(
                  context,
                  AppRegex.cleanFirebaseError(state.error!),
                );
              }
            },
            builder: (context, state) {
              final cartItems = state.userCart.items;

              if (cartItems.isEmpty) {
                return const Center(
                  child: Text("No items found  Cart is empty 🛒"),
                );
              }
              return ListView.builder(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.all(16.w),
                itemCount: cartItems.length,
                itemBuilder: (context, index) {
                  final item = cartItems[index];
                  return ItemCard(
                    key: ValueKey(item.id),
                    item: item,
                    isSlidable: true,
                    onDelete: () {
                      context.read<CartBloc>().add(
                        ClearItemFromCartEvent(
                          item: item,
                          userId: state.userCart.userId,
                        ),
                      );
                    },
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}
