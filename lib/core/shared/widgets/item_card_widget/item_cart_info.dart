import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reco_restaurant/core/functions/app_snackbar.dart';
import 'package:reco_restaurant/core/helper/app_regex.dart';
import 'package:reco_restaurant/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:reco_restaurant/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:reco_restaurant/features/cart/presentation/bloc/cart_event.dart';
import 'package:reco_restaurant/features/cart/presentation/bloc/cart_state.dart';
import 'package:reco_restaurant/features/home/domain/entities/item_entity.dart';

class ItemCartInfo extends StatelessWidget {
  final ItemEntity item;
  const ItemCartInfo({super.key, required this.item});

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
        if (state.userCart.items.any((element) => element.id == item.id)) {
          return SizedBox(
            height: 40.w,
            width: 120.w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  style: IconButton.styleFrom(
                    backgroundColor: const Color(0xFFFF7A00),
                  ),
                  onPressed: () {
                    context.read<CartBloc>().add(
                      RemoveFromCartEvent(
                        item: item,
                        userId: context.read<AuthBloc>().state.user!.uid,
                      ),
                    );
                  },
                  icon: Icon(Icons.remove, color: Colors.white, size: 20.w),
                ),
                SizedBox(
                  width: 20.w,
                  child: Text(
                    '${state.userCart.items.firstWhere((element) => element.id == item.id).quantityInCart.toInt()}',
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(fontSize: 14.sp),
                  ),
                ),
                IconButton(
                  style: IconButton.styleFrom(
                    backgroundColor: const Color(0xFFFF7A00),
                  ),
                  onPressed: () {
                    context.read<CartBloc>().add(
                      AddToCartEvent(
                        item: item,
                        userId: context.read<AuthBloc>().state.user!.uid,
                      ),
                    );
                  },
                  icon: Icon(Icons.add, color: Colors.white, size: 20.w),
                ),
              ],
            ),
          );
        } else {
          return SizedBox(
            height: 40.w,
            width: 120.w,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                backgroundColor: const Color(0xFFFF7A00),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),
              onPressed: () {
                context.read<CartBloc>().add(
                  AddToCartEvent(
                    item: item,
                    userId: context.read<AuthBloc>().state.user!.uid,
                  ),
                );
              },
              child: Text(
                'Add to Cart',
                style: TextStyle(color: Colors.white, fontSize: 14.sp),
              ),
            ),
          );
        }
      },
    );
  }
}
