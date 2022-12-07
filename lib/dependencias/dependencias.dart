import 'package:coopertalse_motorista/motorista/repo/shared_preferences_repo.dart';

class Dependencias {

  static init() async {
    await SharedPreferencesRepo.init();
  }
}