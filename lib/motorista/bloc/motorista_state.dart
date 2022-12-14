import 'package:coopertalse_motorista/motorista/motorista.dart';

enum MotoristaStatus { initial, loading, update, sucess, error }

class MotoristaState {
  final Motorista motorista;
  final MotoristaStatus status;
  String? mensagem;
  MotoristaState(this.status, this.motorista, { this.mensagem});

  bool get isInitial => this.status == MotoristaStatus.initial;
  bool get isLoading => this.status == MotoristaStatus.loading;
  bool get isUpdate => this.status == MotoristaStatus.update;
  bool get isSucess => this.status == MotoristaStatus.sucess;
  bool get isError => this.status == MotoristaStatus.error;
  String get getMensagem => this.mensagem ?? "";

  static initial() 
    => MotoristaState(MotoristaStatus.initial, Motorista.empty);

  static sucess(String mensagem, Motorista motorista) 
    => MotoristaState(MotoristaStatus.sucess, motorista, mensagem: mensagem);

  static error(String mensagem) 
    => MotoristaState(MotoristaStatus.error, Motorista.empty, mensagem: mensagem);
}
