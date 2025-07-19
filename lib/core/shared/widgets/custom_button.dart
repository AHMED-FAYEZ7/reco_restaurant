import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final double textFontSize;
  final FontWeight textWeight;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final double borderRadius;
  final bool isLoading;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.textFontSize = 18,
    this.textWeight = FontWeight.w500,
    this.backgroundColor = const Color(0xFFFF7A00),
    this.borderRadius = 10,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        minimumSize: Size(double.infinity, 50.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius.w),
        ),
      ),
      onPressed: onPressed,
      child: isLoading
          ? SpinKitFadingCircle(color: Colors.white, size: 28.w)
          : Text(
              text,
              style: TextStyle(
                fontSize: textFontSize.sp,
                fontWeight: textWeight,
                color: Colors.white,
              ),
            ),
    );
  }
}
