import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reco_restaurant/core/di.dart';
import 'package:reco_restaurant/core/routing/app_router.dart';
import 'package:reco_restaurant/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:reco_restaurant/features/cart/presentation/bloc/cart_event.dart';
import 'package:reco_restaurant/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:reco_restaurant/features/auth/presentation/bloc/auth_event.dart';
import 'package:reco_restaurant/features/auth/presentation/bloc/auth_state.dart';
import 'package:reco_restaurant/features/home/presentation/bloc/home_bloc/home_bloc.dart';
import 'package:reco_restaurant/features/home/presentation/bloc/home_bloc/home_event.dart';

class RecoRestaurantApp extends StatelessWidget {
  const RecoRestaurantApp({super.key, required this.appRouter});

  final AppRouter appRouter;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<AuthBloc>()..add(AuthCheckCachedUser()),
        ),
        BlocProvider(create: (context) => sl<CartBloc>()),
        BlocProvider(create: (context) => sl<HomeBloc>()),
      ],
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state.user != null && !state.isLoading) {
            final userId = state.user!.uid;
            if (userId.isNotEmpty) {
              context.read<CartBloc>().add(GetCartItemsEvent(userId: userId));
              context.read<HomeBloc>().add(GetItemsEvent());
            }
          }
        },
        child: ScreenUtilInit(
          designSize: const Size(375, 812),
          minTextAdapt: true,
          splitScreenMode: true,
          child: AnnotatedRegion(
            value: const SystemUiOverlayStyle(
              statusBarBrightness: Brightness.light,
              statusBarColor: Colors.transparent,
            ),
            child: MaterialApp.router(
              title: 'Flutter Demo',
              theme: ThemeData(
                primaryColor: Color(0xFFFF7A00),
                colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFFFF7A00)),
                scaffoldBackgroundColor: Colors.white,
              ),
              debugShowCheckedModeBanner: false,
              routerConfig: appRouter.router,
            ),
          ),
        ),
      ),
    );
  }
}
