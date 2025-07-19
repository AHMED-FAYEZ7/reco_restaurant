// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:reco_restaurant/core/routing/routes.dart';
import 'package:reco_restaurant/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:reco_restaurant/features/auth/presentation/bloc/auth_event.dart';
import 'package:reco_restaurant/features/home/presentation/bloc/home_bloc/home_bloc.dart';
import 'package:reco_restaurant/features/home/presentation/bloc/home_bloc/home_event.dart';

class SignOutDialog extends StatelessWidget {
  const SignOutDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Sign Out'),
      content: const Text('Are you sure you want to sign out?'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () async {
            context.read<AuthBloc>().add(SignOutEvent());
            context.read<HomeBloc>().add(ClearCachedItemsEvent());
            context.pushReplacement(Routes.auth);
          },
          child: const Text('Sign Out'),
        ),
      ],
    );
  }
}
