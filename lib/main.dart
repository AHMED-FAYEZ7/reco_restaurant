import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:reco_restaurant/core/bloc_observer.dart';
import 'package:reco_restaurant/core/di.dart';
import 'package:reco_restaurant/core/routing/app_router.dart';
import 'package:reco_restaurant/features/auth/data/models/user_mode.dart';
import 'package:reco_restaurant/features/home/data/models/item_model.dart';
import 'package:reco_restaurant/firebase_options.dart';
import 'package:reco_restaurant/reco_restaurant_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await ScreenUtil.ensureScreenSize();
  Bloc.observer = AppBlocObserver();
  await Hive.initFlutter();
  Hive.registerAdapter(UserModelAdapter());
  Hive.registerAdapter(ItemModelAdapter());

  runApp(RecoRestaurantApp(appRouter: AppRouter()));
}
