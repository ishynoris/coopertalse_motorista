import 'dart:convert';

import 'package:coopertalse_motorista/carro/carro.dart';
import 'package:coopertalse_motorista/exceptions/coopertalse_exception.dart';
import 'package:coopertalse_motorista/motorista/api/motorista_api.dart';
import 'package:coopertalse_motorista/motorista/repo/shared_preferences_repo.dart';
import 'package:coopertalse_motorista/dispositivo/dispositivo.dart';

class Motorista {

  int? id;
  String nome;
  Carro carro;
  String? pix;
  DispositivoInfo? dispositivo;

  Motorista({ 
    this.id,
    required this.nome, 
    required this.carro,
    this.pix,
    this.dispositivo,
  });

  static Motorista get empty {
    return  Motorista(nome: "", carro: Carro.empty());
  }

  static Motorista from(Map json) {
    Motorista motorista = Motorista(nome: json['mta_nome'], carro: Carro.from(json));
    motorista.id = json['mta_id'];
    motorista.pix = json['chx_chave_pix'];
    return motorista;
  }

  bool get hasId => this.id != null;
  int get getId => this.id ?? 0;
  String get getNome => this.nome;
  String get getNumeroCarro => this.carro.getNumero().toString();
  String get getNumeroPix => this.pix ?? "";
  bool get isValido => this.nome.isNotEmpty;
  DispositivoInfo? get getDispositivo => this.dispositivo;

  Future<bool> cadastrar() async {
    try {
      final motorista = await MotoristaAPI.cadastrar(this);
      this.id = motorista.id;
      this.nome = motorista.nome;
      this.carro = motorista.carro;
      this.dispositivo = motorista.dispositivo;
      this.pix = motorista.pix;
      SharedPreferencesRepo.getMotorista.insert(this);
    } catch (e) {
      CoopertalseException.retrows(e, padrao: "Não foi possível salvar suas informações.");
    }
    return true;
  }

  Future<bool> atualizar() async {
    try {
      final motorista = await MotoristaAPI.atualizar(this);
      this.id = motorista.id;
      this.nome = motorista.nome;
      this.carro = motorista.carro;
      this.dispositivo = motorista.dispositivo;
      this.pix = motorista.pix;
      SharedPreferencesRepo.getMotorista.insert(this);
    } catch (e) {
      CoopertalseException.retrows(e, padrao: "Não foi possível salvar suas informações.");
    }
    return true;
  }

  Motorista copy({
    int? int,
    String? nome, 
    String? numero,
    String? pix,
    DispositivoInfo? dispositivo,
  }) {
    return Motorista(
      id: id ?? this.id,
      nome: nome ?? this.nome,
      carro: Carro(numero ?? this.carro.getNumero()),
      pix: pix ?? this.pix,
      dispositivo: dispositivo ?? this.dispositivo,
    );
  }

  @override
  String toString() {
    return jsonEncode(toJson());
  }

  Map toJson() {
    // todo lista de pix
    return {
      'mta_id': this.getId.toString(),
      'mta_nome': this.getNome,
      'mta_device_hash': this.dispositivo?.getIdentificador ?? "",
      'cro_numero': this.getNumeroCarro,
      'chx_chave_pix[0]': this.pix,
    };
  }

  String hash() {
    if (this.dispositivo == null) {
      return "";
    }
    return "${this.getNumeroCarro}${this.dispositivo!.getIdentificador}";
  }
}

class MotoristaValidator {
  
  static String? validarNome(String? nome) {
    if (nome == null || nome.isEmpty) {
      return "Informe o nome do motorista";
    }

    return null;
  }
}