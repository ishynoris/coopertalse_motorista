// 

import 'package:coopertalse_motorista/carro/carro.dart';

class Motorista {

  int? id;
  final String nome;
  final Carro carro;

  Motorista({ 
    this.id = 1,
    required this.nome, 
    required this.carro,
  });

  String getNome() {
    return this.nome;
  }

  int getNumeroCarro() {
    return this.carro.getNumero();
  }

  bool isValido() {
    return this.id! > 0;
  }

  bool cadastrar() {
    return true;
  }

  Motorista copy({
    String? nome, 
    int? numero,
  }) {
    return Motorista(
      nome: nome ?? this.nome,
      carro: Carro(numero ?? this.carro.getNumero()),
    );
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