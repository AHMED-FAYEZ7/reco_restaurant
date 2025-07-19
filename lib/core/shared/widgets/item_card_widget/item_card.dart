import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:reco_restaurant/features/home/domain/entities/item_entity.dart';
import 'item_image.dart';
import 'item_info.dart';

class ItemCard extends StatelessWidget {
  final ItemEntity item;
  final VoidCallback? onDelete;
  final bool isSlidable;

  const ItemCard({
    super.key,
    required this.item,
    this.onDelete,
    this.isSlidable = false,
  });

  @override
  Widget build(BuildContext context) {
    final cardWidget = Card(
      margin: EdgeInsets.symmetric(vertical: 8.h),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.w)),
      clipBehavior: Clip.antiAlias,
      child: SizedBox(
        height: 110.w,
        child: Row(
          children: [
            ItemImage(imageUrl: item.image),
            ItemInfo(item: item),
          ],
        ),
      ),
    );

    if (!isSlidable || onDelete == null) {
      return cardWidget;
    }

    return Slidable(
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        extentRatio: 0.28,
        dragDismissible: true,
        closeThreshold: 0.5,
        children: [
          SlidableAction(
            onPressed: (context) => onDelete!(),
            autoClose: true,
            backgroundColor: Colors.red.shade400,
            foregroundColor: Colors.white,
            icon: Icons.delete_forever,
            label: 'Delete',
            borderRadius: BorderRadius.circular(18.w),
            flex: 1,
            spacing: 0,
            padding: EdgeInsets.symmetric(vertical: 8.h),
          ),
        ],
      ),
      child: cardWidget,
    );
  }
}
