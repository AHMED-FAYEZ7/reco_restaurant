import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:reco_restaurant/core/functions/app_snackbar.dart';
import 'package:reco_restaurant/core/helper/app_regex.dart';
import 'package:reco_restaurant/core/helper/spacing.dart';
import 'package:reco_restaurant/core/routing/routes.dart';
import 'package:reco_restaurant/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:reco_restaurant/features/auth/presentation/bloc/auth_event.dart';
import 'package:reco_restaurant/features/auth/presentation/bloc/auth_state.dart';
import 'auth_form_fields.dart';
import 'auth_submit_button.dart';

class AuthForm extends StatefulWidget {
  const AuthForm({super.key});

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      context.read<AuthBloc>().add(
        SignInEvent(
          _emailController.text.trim(),
          _passwordController.text.trim(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) async {
        if (state.error != null) {
          AppSnackBar.showError(
            context,
            AppRegex.cleanFirebaseError(state.error!),
          );
        } else if (state.user != null) {
          AppSnackBar.showSuccess(context, 'Logged in successfully! 🎉');
          context.pushReplacement(Routes.home);
        }
      },
      builder: (context, state) {
        return Column(
          children: [
            AuthFormFields(
              formKey: _formKey,
              emailController: _emailController,
              passwordController: _passwordController,
            ),
            verticalSpace(20),
            AuthSubmitButton(
              isLoading: state.isLoading,
              onPressed: () => _submit(),
            ),
            verticalSpace(20),
          ],
        );
      },
    );
  }
}
