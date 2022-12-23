import 'package:coopertalse_motorista/dispositivo/bloc/dispositivo_state.dart';

abstract class DispositivoEvent {
  final DispositivoState state;
  const DispositivoEvent(this.state);
}

class DispositivoFinishEvent extends DispositivoEvent {
  DispositivoFinishEvent(info) : super(DispositivoFinishState(info));
}

class DispositivoLoadingEvent extends DispositivoEvent {
  DispositivoLoadingEvent() : super(DispositivoLoadingState());
}
