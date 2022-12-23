// 

import 'package:coopertalse_motorista/carro/carro.dart';
import 'package:coopertalse_motorista/motorista/repo/shared_preferences_repo.dart';
import 'package:coopertalse_motorista/dispositivo/dispositivo.dart';

class Motorista {

  int? id;
  final String nome;
  final Carro carro;
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
    final carro = Carro.from(json);
    return Motorista(nome: json['mta_nome'], carro: carro);
  }

  int get getId {
    return this.id ?? 0;
  }

  String get getNome {
    return this.nome;
  }

  String get getNumeroCarro {
    return this.carro.getNumero().toString();
  }

  String get getNumeroPix {
    return this.pix ?? "";
  }

  bool isValido() {
    return this.nome.isNotEmpty;
  }

  DispositivoInfo? get getDispositivo {
    return this.dispositivo;
  }

  bool cadastrar() {
    SharedPreferencesRepo.getMotorista.insert(this);
    return true;
  }

  bool atualizar() {
    SharedPreferencesRepo.getMotorista.update(this);
    return true;
  }

  Motorista copy({
    String? nome, 
    String? numero,
    String? pix,
    DispositivoInfo? dispositivo,
  }) {
    return Motorista(
      nome: nome ?? this.nome,
      carro: Carro(numero ?? this.carro.getNumero()),
      pix: pix ?? this.pix,
      dispositivo: dispositivo ?? this.dispositivo,
    );
  }

  @override
  String toString() {
    return 'Motorista: {$getNome}, Carro: {$getNumeroCarro}, Pix: {$getNumeroPix}';
  }

  Map toJson() {
    return {
      'mta_nome': this.getNome,
      'mta_device_hash': this.dispositivo?.getIdentificador,
      'cro_numero': this.getNumeroCarro,
      'chx_chave_pix': [ this.pix ],
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