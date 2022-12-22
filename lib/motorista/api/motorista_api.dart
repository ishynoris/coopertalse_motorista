import 'dart:convert';

import 'package:coopertalse_motorista/api/request.dart';
import 'package:coopertalse_motorista/motorista/motorista.dart';

class MotoristaAPI {

  static Future<Map> salvar(Motorista motorista) async {
    return await Request.post("/motorista", motorista.toJson());
  }

  static Future<Motorista> consultarPorPorHashDispositivo(String sHash) async {
    final mapJson = await Request.get("/dispositivo/$sHash/motorista");
    if (mapJson['sucesso']) {
      final json = mapJson['resposta'];
      print(json);
      return Motorista.from(jsonDecode(json));
    }
    return Motorista.empty();
  }
}