import 'dart:convert';

import 'package:coopertalse_motorista/api/request.dart';
import 'package:coopertalse_motorista/exceptions/coopertalse_exception.dart';
import 'package:coopertalse_motorista/motorista/motorista.dart';

class MotoristaAPI {

  static Future<Motorista> cadastrar(Motorista motorista) async {
    final json = await Request.post("/motorista/", motorista.toJson());
    if (json['sucesso']) {
      return Motorista.from(jsonDecode(json['resposta']));
    }
    throw CoopertalseException(json['mensagem']);
  }

  static Future<Motorista> atualizar(Motorista motorista) async {
    final json = await Request.post("/motorista/${motorista.getId}/", motorista.toJson());
    if (json['sucesso']) {
      return Motorista.from(jsonDecode(json['resposta']));
    }
    throw CoopertalseException(json['mensagem']);
  }

  static Future<Motorista> consultarPorPorHashDispositivo(String sHash) async {
    final mapJson = await Request.get("/dispositivo/$sHash/motorista");
    if (mapJson['sucesso']) {
      final json = mapJson['resposta'];
      return Motorista.from(jsonDecode(json));
    }
    throw CoopertalseException(mapJson['mensagem']);
  }
}