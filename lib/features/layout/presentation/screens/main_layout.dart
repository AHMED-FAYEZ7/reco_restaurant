import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:reco_restaurant/core/routing/routes.dart';
import 'package:reco_restaurant/features/layout/presentation/screens/widgets/custom_bottom_nav_bar.dart';

class MainLayout extends StatelessWidget {
  final Widget child;
  const MainLayout({super.key, required this.child});

  int _locationToTabIndex(String location) {
    final index = kMainTabs.indexWhere((path) => location.startsWith(path));
    return index < 0 ? 0 : index;
  }

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    final currentIndex = _locationToTabIndex(location);

    return Scaffold(
      body: child,
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: Colors.transparent)),
        ),
        child: CustomBottomNavBar(
          currentIndex: currentIndex,
          onTap: (index) {
            if (kMainTabs[index] != location) {
              context.go(kMainTabs[index]);
            }
          },
        ),
      ),
    );
  }
}
