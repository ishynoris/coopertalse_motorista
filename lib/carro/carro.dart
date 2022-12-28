class Carro {
  int? id;
  final String _numero;

  Carro(this._numero);

  static Carro empty() {
    return Carro ("");
  }

  static Carro from (Map json) {
    Carro carro = Carro(json['cro_numero']);
    carro.id = json['cro_id'];
    return carro;
  }

  String getNumero() {
    return _numero;
  }

  String getNumeroFormatado() {
    return _numero.padLeft(3, "0");
  }
}

class CarroValidator {

  static String? validarNumero(String? value) {
    if (value == null || value.isEmpty) {
      return "Informe o número do carro";
    }

    if (int.tryParse(value) == null) {
      return "O número do carro é invaálido";
    }

    return null;
  }
}
