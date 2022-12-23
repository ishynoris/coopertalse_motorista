
import 'package:coopertalse_motorista/dispositivo/dispositivo.dart';

enum  DispositivoStatus { 
  loading, 
  finish,
} 

abstract class DispositivoState {  
  final DispositivoStatus status;
  final DispositivoInfo? info;
  DispositivoState({
    required this.status,
    this.info,
  });
}

class DispositivoLoadingState extends DispositivoState {
  DispositivoLoadingState() : super(status: DispositivoStatus.loading);
}

class DispositivoFinishState extends DispositivoState {
  DispositivoFinishState(info) : super(status: DispositivoStatus.finish, info: info);
}
