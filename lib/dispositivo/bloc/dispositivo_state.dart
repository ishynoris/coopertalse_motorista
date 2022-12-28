
import 'package:coopertalse_motorista/dispositivo/dispositivo.dart';

enum  DispositivoStatus { 
  loading, 
  finish,
} 

class DispositivoState {
  final DispositivoStatus status;
  final DispositivoInfo? info;
  DispositivoState(this.status, { this.info });

  bool get isLoading => this.status == DispositivoStatus.loading;
  bool get isFinish => this.status == DispositivoStatus.finish;

  static DispositivoState loading() 
    => DispositivoState(DispositivoStatus.loading);

  static DispositivoState finish(DispositivoInfo info) 
    => DispositivoState(DispositivoStatus.finish, info: info);
}
