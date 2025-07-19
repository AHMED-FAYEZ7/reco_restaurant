import 'package:flutter/material.dart';
import 'package:reco_restaurant/features/profile/presentation/widgets/sign_out_dialog.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () async {
              // await importItemsToFirestore();
              showDialog(
                context: context,
                builder: (context) => const SignOutDialog(),
              );
            },
            icon: const Icon(Icons.exit_to_app_outlined),
          ),
        ],
      ),
      body: Center(child: Text('Profile is empty')),
    );
  }
}
