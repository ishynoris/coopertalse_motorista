import 'package:shared_preferences/shared_preferences.dart';

import '../dao/motorista_shared_prefs.dart';

class SharedPreferencesRepo {

  static late SharedPreferences prefs;

  static MotoristaSharedPreferences get getMotorista {
    return MotoristaSharedPreferences(SharedPreferencesRepo.prefs);
  }

  static init() async => SharedPreferencesRepo.prefs = await SharedPreferences.getInstance();
}