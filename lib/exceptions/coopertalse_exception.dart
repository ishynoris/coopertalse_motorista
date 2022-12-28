class CoopertalseException implements Exception {

  final String mensagem;
  CoopertalseException(this.mensagem);

  @override
  String toString() {
    return this.mensagem;
  }

  static retrows(Object e, { String padrao = "Erro inesperado"}) {
    throw CoopertalseException._is(e) ? e : CoopertalseException(padrao);
  } 

  static String message(Object e, { String padrao = "Erro inesperado"}) {
    return CoopertalseException._is(e) ? e.toString() : padrao;
  } 

  static bool _is(Object e) {
    return e is CoopertalseException;
  }
}
