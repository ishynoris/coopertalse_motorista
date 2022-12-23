import 'package:coopertalse_motorista/motorista/motorista.dart';

abstract class MotoristaEvent {
  const MotoristaEvent();
}

class MotoristaInitialEvent extends MotoristaEvent { 
  const MotoristaInitialEvent() : super();
}

class MotoristaChangedEvent extends MotoristaEvent {
  final Motorista motorista;
  const MotoristaChangedEvent({ required this.motorista }) : super();
}

class MotoristaLoadingEvent extends MotoristaEvent { 
  final String hash;
  const MotoristaLoadingEvent({ required this.hash }) : super();
}

class MotoristaSuccessEvent extends MotoristaEvent {
  final Motorista motorista;
  const MotoristaSuccessEvent({ required this.motorista }) : super();
}

class MotoristaErrorEvent extends MotoristaEvent { 
  final String mensagem;
  const MotoristaErrorEvent({ required this.mensagem }) : super();
}