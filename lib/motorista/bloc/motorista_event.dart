import 'package:coopertalse_motorista/dispositivo/dispositivo.dart';
import 'package:coopertalse_motorista/motorista/motorista.dart';

enum MotoristaEventStatus {
  initial, changed, loading, sucess, error
}

class MotoristaEvent {
  final MotoristaEventStatus status;
  final Motorista motorista;
  final String? dispositivo;
  final String? mensagem;

  const MotoristaEvent(this.status, this.motorista, { this.dispositivo, this.mensagem });

  bool get isInitial => this.status == MotoristaEventStatus.initial;
  bool get isChanged => this.status == MotoristaEventStatus.changed;
  bool get isLoading => this.status == MotoristaEventStatus.loading;
  bool get isSucess => this.status == MotoristaEventStatus.sucess;
  bool get isError => this.status == MotoristaEventStatus.error;
  String get getHash => this.dispositivo ?? "";
  String get getMensage => this.mensagem ?? "";

  static MotoristaEvent initial() 
    => MotoristaEvent(MotoristaEventStatus.initial, Motorista.empty );

  static MotoristaEvent changed(Motorista motorista) 
    => MotoristaEvent(MotoristaEventStatus.changed, motorista);

  static MotoristaEvent loading(String hash) 
    => MotoristaEvent(MotoristaEventStatus.loading, Motorista.empty, dispositivo: hash);

  static MotoristaEvent success(Motorista motorista) 
    => MotoristaEvent(MotoristaEventStatus.sucess, motorista);

  static MotoristaEvent error(String mensagem) 
    => MotoristaEvent(MotoristaEventStatus.error, Motorista.empty, mensagem: mensagem);
}
