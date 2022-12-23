import 'package:device_info_plus/device_info_plus.dart';

class Dispositivo {

  static late DispositivoInfo _info;

  static Future<DispositivoInfo> get info async {
    final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    final androidInfo = _AndroidInfo(await deviceInfoPlugin.androidInfo);
    Dispositivo._info = Dispositivo._info.copyFrom(
      modelo: androidInfo.modelo, 
      identificador: androidInfo.identificador,
    );
    return Dispositivo._info;
  }
}

class DispositivoInfo {

  String modelo;
  String identificador;

  DispositivoInfo(
    this.modelo,
    this.identificador
  );

  String get getModelo {
    return this.modelo;
  }

  String get getIdentificador {
    return this.identificador;
  }

  bool get isEmpty {
    return modelo.isEmpty || identificador.isEmpty;
  }

  static DispositivoInfo empty() {
    return DispositivoInfo("", "");
  }

  DispositivoInfo copyFrom({
    String? modelo,
    String? identificador,
  }) {
    return DispositivoInfo(
      modelo ?? this.modelo,
      identificador ?? this.identificador,
    );
  }
}

class _AndroidInfo extends DispositivoInfo {

  AndroidDeviceInfo deviceInfo;

  _AndroidInfo(this.deviceInfo) : super (_AndroidInfo._getModelo(deviceInfo), deviceInfo.id);

  static String _getModelo(AndroidDeviceInfo deviceInfo) {
    return "${deviceInfo.model} (${deviceInfo.manufacturer})";
  }
}
