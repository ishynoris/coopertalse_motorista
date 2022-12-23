import 'dart:io';

class CoopertalseException implements Exception {

  final String mensagem;
  CoopertalseException(this.mensagem);

  @override
  String toString() {
    return this.mensagem;
  }
}