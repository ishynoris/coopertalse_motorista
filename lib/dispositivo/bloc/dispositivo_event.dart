import 'package:coopertalse_motorista/dispositivo/bloc/dispositivo_state.dart';

enum DispositivoEventStatus { finish, loading }

class DispositivoEvent {

  final DispositivoState state;
  final DispositivoEventStatus status;
  const DispositivoEvent(this.status, this.state);

  bool get isLoading => this.status == DispositivoEventStatus.loading;
  bool get isFinish => this.status == DispositivoEventStatus.finish;

  static DispositivoEvent loading() 
    => DispositivoEvent(DispositivoEventStatus.loading, DispositivoState.loading());

  static DispositivoEvent finish(DispositivoState state) 
    => DispositivoEvent(DispositivoEventStatus.finish, state);
}
