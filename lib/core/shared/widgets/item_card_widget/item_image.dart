import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ItemImage extends StatelessWidget {
  final String imageUrl;
  const ItemImage({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(18.r),
        bottomLeft: Radius.circular(18.r),
      ),
      child: Image.network(
        imageUrl,
        width: 110.w,
        height: 110.w,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return SizedBox(
            width: 110.w,
            height: 110.w,
            child: Icon(Icons.image_outlined, size: 40.w),
          );
        },
      ),
    );
  }
}
