import 'package:coopertalse_motorista/motorista/motorista.dart';

abstract class MotoristaState {
  final Motorista motorista;
  MotoristaState({
    required this.motorista,
  });
}

class MotoristaInitialState extends MotoristaState {
  MotoristaInitialState() : super(motorista: Motorista.empty);
}

class MotoristaLoadingState extends MotoristaState {
  MotoristaLoadingState(motorista) : super(motorista: motorista);
}

class MotoristaUpdateState extends MotoristaState {
  MotoristaUpdateState(motorista) : super(motorista: motorista);
}

class MotoristaSucessoState extends MotoristaState {
  final String mensagem;
  MotoristaSucessoState(this.mensagem, motorista) : super(motorista: motorista);
}

class MotoristaErroState extends MotoristaState {
  final String mensagem;
  MotoristaErroState(this.mensagem) : super(motorista: Motorista.empty);
}
