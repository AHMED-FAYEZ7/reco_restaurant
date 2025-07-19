import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reco_restaurant/core/helper/spacing.dart';
import 'package:reco_restaurant/core/shared/widgets/item_card_widget/item_cart_info.dart';
import 'package:reco_restaurant/features/home/domain/entities/item_entity.dart';

class ItemInfo extends StatelessWidget {
  final ItemEntity item;
  const ItemInfo({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 180.w,
            child: Text(
              item.name,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          verticalSpace(15),
          Row(
            children: [
              SizedBox(
                width: 55.w,
                child: Text(
                  '${item.price.toString()} \$',
                  style: TextStyle(fontSize: 14.sp, color: Colors.grey[700]),
                ),
              ),
              horizontalSpace(20),
              ItemCartInfo(item: item),
            ],
          ),
        ],
      ),
    );
  }
}
