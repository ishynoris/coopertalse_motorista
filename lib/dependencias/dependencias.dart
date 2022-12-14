import 'package:coopertalse_motorista/motorista/repo/shared_preferences_repo.dart';
import 'package:coopertalse_motorista/util/localizacao.dart';

class Dependencias {

  static init() async {
    await SharedPreferencesRepo.init();
    await Localizacao.requestGPS();
  }
}