import 'package:flutter/material.dart';
import 'package:reco_restaurant/core/helper/app_regex.dart';
import 'package:reco_restaurant/core/helper/spacing.dart';
import 'package:reco_restaurant/features/auth/presentation/widgets/custom_text_filed.dart';

class AuthFormFields extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const AuthFormFields({
    super.key,
    required this.formKey,
    required this.emailController,
    required this.passwordController,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          CustomTextFormField(
            labelText: 'Email',
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            prefixIcon: const Icon(Icons.email_outlined),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email';
              } else if (!AppRegex.isEmailValid(value)) {
                return 'Please enter a valid email';
              }
              return null;
            },
          ),
          verticalSpace(20),
          CustomTextFormField(
            labelText: 'Password',
            controller: passwordController,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.done,
            prefixIcon: const Icon(Icons.lock_outline),
            obscureText: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter the password';
              } else if (!AppRegex.isPasswordValid(value)) {
                return 'Password must be at least 6 characters';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
}
