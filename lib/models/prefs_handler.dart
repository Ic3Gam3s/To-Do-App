import 'package:shared_preferences/shared_preferences.dart';

class PrefsHander {
  // Obtain shared preferences.
  static late final SharedPreferences prefs;

  static void getShardPreferences() async{
    prefs = await SharedPreferences.getInstance();
  }
}
