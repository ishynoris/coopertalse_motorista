import 'dart:async';

import 'package:geolocator/geolocator.dart';

class Localizacao {

  static Future<bool> requestGPS() async {
    LocationPermission permissao = await Geolocator.checkPermission();
    if (permissao == LocationPermission.deniedForever) {
      return false;
    }

    if (permissao == LocationPermission.denied) {
      permissao = await Geolocator.requestPermission();
      if (permissao == LocationPermission.denied) {
        return false;
      }
    }
    return true;
  }

  static processarAtualizacao(Function callback) async {
    late StreamSubscription<Position> stream;
    
    stream = Geolocator.getPositionStream(
      locationSettings: LocationSettings(distanceFilter: 10),
    ).listen((Position position) {
        callback(position);
    }, onError: (error) {
      stream.cancel();
    });
  }
}