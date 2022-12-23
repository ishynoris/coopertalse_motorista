import 'package:coopertalse_motorista/motorista/bloc/motorista_state.dart';
import 'package:coopertalse_motorista/motorista/motorista.dart';

abstract class MotoristaEvent {
  final MotoristaStatus status;
  const MotoristaEvent(this.status);
}

class MotoristaInitialEvent extends MotoristaEvent { 
  const MotoristaInitialEvent() : super(MotoristaStatus.initial);
}

class MotoristaChangedEvent extends MotoristaEvent {
  final Motorista motorista;
  const MotoristaChangedEvent({ required this.motorista }) : super(MotoristaStatus.update);
}

class MotoristaLoadingEvent extends MotoristaEvent { 
  final String hash;
  const MotoristaLoadingEvent({ required this.hash }) : super(MotoristaStatus.loading);
}
