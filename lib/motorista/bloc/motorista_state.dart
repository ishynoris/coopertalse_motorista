import 'package:coopertalse_motorista/carro/carro.dart';
import 'package:coopertalse_motorista/motorista/motorista.dart';

enum MotoristaStatus { initial, loading, update, error }

abstract class MotoristaState {

  final MotoristaStatus status;
  final Motorista motorista;
  MotoristaState({
    required this.status,
    required this.motorista,
  });
}

class MotoristaInitialState extends MotoristaState {
  MotoristaInitialState() : super(status: MotoristaStatus.initial, motorista: Motorista(nome: "nome", carro: Carro("345")));
}

class MotoristaLoadingState extends MotoristaState {
  MotoristaLoadingState(motorista) : super(status: MotoristaStatus.loading, motorista: motorista);
}

class MotoristaUpdateState extends MotoristaState {
  MotoristaUpdateState(motorista) : super(status: MotoristaStatus.update, motorista: motorista);
}

class MotoristaErroState extends MotoristaState {
  MotoristaErroState() : super(status: MotoristaStatus.error, motorista: Motorista.empty);
}
