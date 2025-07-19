import 'package:reco_restaurant/core/cache_helper/shared_prefs_kays.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsHelper {
  final SharedPreferences prefs;

  SharedPrefsHelper(this.prefs);

  bool isUserLogged() {
    return prefs.getBool(SharedPrefsKeys.isUserLogged) ?? false;
  }

  Future<void> setUserLoggedIn() async {
    await prefs.setBool(SharedPrefsKeys.isUserLogged, true);
  }

  Future<void> setUserLoggedOut() async {
    await prefs.setBool(SharedPrefsKeys.isUserLogged, false);
  }
}
