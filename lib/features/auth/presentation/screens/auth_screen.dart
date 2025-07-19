import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reco_restaurant/core/helper/spacing.dart';
import 'package:reco_restaurant/core/theming/assets.dart';
import 'package:reco_restaurant/features/auth/presentation/widgets/auth_form.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            children: [
              verticalSpace(80),
              Image.asset(Assets.logo, scale: 1.3.h),
              verticalSpace(50),
              const AuthForm(),
            ],
          ),
        ),
      ),
    );
  }
}
