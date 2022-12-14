// 

import 'package:coopertalse_motorista/carro/carro.dart';
import 'package:coopertalse_motorista/motorista/repo/shared_preferences_repo.dart';
import 'package:coopertalse_motorista/util/dispositivo.dart';

class Motorista {

  int? id;
  final String nome;
  final Carro carro;
  String? pix;
  DispositivoInfo? dispositivo;

  Motorista({ 
    this.id = 1,
    required this.nome, 
    required this.carro,
    this.pix,
    this.dispositivo,
  });

  int? get getId {
    return this.id;
  }

  String get getNome {
    return this.nome;
  }

  String get getNumeroCarro {
    return this.carro.getNumero().toString();
  }

  String? get getNumeroPix {
    return this.pix;
  }

  bool isValido() {
    return this.id! > 0;
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
    int? numero,
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