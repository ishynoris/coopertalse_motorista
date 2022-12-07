import 'package:shared_preferences/shared_preferences.dart';

import '../dao/motorista_shared_prefs.dart';

class SharedPreferencesRepo {
  
  static late SharedPreferences _prefs;

  static MotoristaSharedPreferences get getMotorista {
    SharedPreferencesRepo._init();
    return MotoristaSharedPreferences(SharedPreferencesRepo._prefs);
  }

  static Future _init() async {
    // ignore: unnecessary_null_comparison
    if (SharedPreferencesRepo == null) {
      SharedPreferencesRepo._prefs = await SharedPreferences.getInstance();
    }
  }
}