// ignore_for_file: deprecated_member_use, use_super_parameters

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:reco_restaurant/core/theming/assets.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'custom_tab_item.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final void Function(int) onTap;

  const CustomBottomNavBar({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const activeColor = Color(0xFFFF7A00);
    const inactiveColor = Color(0xFF484C52);

    final double activeIconSize = 45.r;
    final double iconSize = 28.r;
    final double textSize = 12.sp;
    final double barHeight = 55.w;

    return StyleProvider(
      style: _CustomStyle(
        activeIconSize: activeIconSize,
        iconSize: iconSize,
        textSize: textSize,
      ),
      child: ConvexAppBar(
        height: barHeight,
        style: TabStyle.react,
        backgroundColor: Colors.white,
        activeColor: activeColor,
        color: inactiveColor,
        elevation: 8,
        initialActiveIndex: currentIndex,
        onTap: onTap,
        items: [
          customTabItem(
            icon: Image.asset(
              Assets.homeIcon,
              width: iconSize,
              height: iconSize,
              color: currentIndex == 0 ? activeColor : inactiveColor,
            ),
            title: 'Home',
          ),
          customTabItem(
            icon: SvgPicture.asset(
              Assets.categoriesIcon,
              width: iconSize,
              height: iconSize,
              color: currentIndex == 1 ? activeColor : inactiveColor,
            ),
            title: 'Categories',
          ),
          customTabItem(
            icon: SvgPicture.asset(
              Assets.deliverIcon,
              width: iconSize,
              height: iconSize,
              color: currentIndex == 2 ? activeColor : inactiveColor,
            ),
            title: 'Deliver',
          ),
          customTabItem(
            icon: SvgPicture.asset(
              Assets.cartIcon,
              width: iconSize,
              height: iconSize,
              color: currentIndex == 3 ? activeColor : inactiveColor,
            ),
            title: 'Cart',
          ),
          customTabItem(
            icon: SvgPicture.asset(
              Assets.profileIcon,
              width: iconSize,
              height: iconSize,
              color: currentIndex == 4 ? activeColor : inactiveColor,
            ),
            title: 'Profile',
          ),
        ],
      ),
    );
  }
}

class _CustomStyle extends StyleHook {
  @override
  final double activeIconSize;
  @override
  final double iconSize;
  final double textSize;

  _CustomStyle({
    required this.activeIconSize,
    required this.iconSize,
    required this.textSize,
  });

  @override
  double get activeIconMargin => 0;

  double? get top => -20.h;

  @override
  TextStyle textStyle(Color color, String? fontFamily) {
    return TextStyle(
      fontSize: textSize,
      color: color,
      fontWeight: FontWeight.w600,
      fontFamily: fontFamily,
    );
  }
}
