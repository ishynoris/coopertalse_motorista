class Carro {
  final int _numero;

  Carro(this._numero);

  int getNumero() {
    return _numero;
  }

  String getNumeroFormatado() {
    return '$_numero'.padLeft(3, "0");
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
