import 'package:hive/hive.dart';
import 'package:reco_restaurant/features/auth/data/models/user_mode.dart';

abstract class AuthLocalDataSource {
  Future<void> cacheUser(UserModel user);
  Future<UserModel?> getCachedUser();
  Future<void> clearCachedUser();
}

class HiveAuthLocalDataSource implements AuthLocalDataSource {
  static const String boxName = 'authBox';
  static const String userKey = 'user';

  @override
  Future<void> cacheUser(UserModel user) async {
    final box = await Hive.openBox<UserModel>(boxName);
    await box.put(userKey, user);
  }

  @override
  Future<UserModel?> getCachedUser() async {
    final box = await Hive.openBox<UserModel>(boxName);
    return box.get(userKey);
  }

  @override
  Future<void> clearCachedUser() async {
    final box = await Hive.openBox<UserModel>(boxName);
    await box.clear();
  }
}
