import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reco_restaurant/core/shared/widgets/custom_button.dart';

class AuthSubmitButton extends StatelessWidget {
  final bool isLoading;
  final VoidCallback onPressed;

  const AuthSubmitButton({
    super.key,
    required this.isLoading,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      text: 'Log in',
      textFontSize: 14.sp,
      textWeight: FontWeight.normal,
      isLoading: isLoading,
      onPressed: onPressed,
    );
  }
}
