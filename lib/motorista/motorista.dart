// 

import 'package:coopertalse_motorista/carro/carro.dart';
import 'package:coopertalse_motorista/motorista/repo/shared_preferences_repo.dart';

class Motorista {

  int? id;
  final String nome;
  final Carro carro;
  String? pix;

  Motorista({ 
    this.id = 1,
    required this.nome, 
    required this.carro,
    this.pix,
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
  }) {
    return Motorista(
      nome: nome ?? this.nome,
      carro: Carro(numero ?? this.carro.getNumero()),
      pix: pix ?? this.pix,
    );
  }

  @override
  String toString() {
    return 'Motorista: {$getNome}, Carro: {$getNumeroCarro}, Pix: {$getNumeroPix}';
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