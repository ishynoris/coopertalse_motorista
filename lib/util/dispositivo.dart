import 'package:device_info_plus/device_info_plus.dart';

class Dispositivo {

  static DispositivoInfo? _info;

  static Future<DispositivoInfo?> getInfo() async {
    if (Dispositivo._info == null) {
      final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
      Dispositivo._info = _AndroidInfo(await deviceInfoPlugin.androidInfo);
    }
    return Dispositivo._info;
  }
}

abstract class DispositivoInfo {

  String get getModelo;

  String get getIdentificador;
}

class _AndroidInfo extends DispositivoInfo {

  AndroidDeviceInfo deviceInfo;

  _AndroidInfo(this.deviceInfo);

  @override
  String get getModelo {
    return "${this.deviceInfo.model} (${this.deviceInfo.manufacturer})";
  }
  
  @override
  String get getIdentificador {
    return this.deviceInfo.id;
  }
}
