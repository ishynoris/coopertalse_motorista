import 'dart:async';

import 'package:coopertalse_motorista/motorista/api/motorista_api.dart';
import 'package:coopertalse_motorista/motorista/bloc/motorista_event.dart';
import 'package:coopertalse_motorista/motorista/bloc/motorista_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MotoristaBloc extends Bloc<MotoristaEvent, MotoristaState> {

  final MotoristaAPI _api = MotoristaAPI();
  late StreamSubscription<MotoristaStatus> _streamMotorista;

  MotoristaBloc() : super(MotoristaInitialState()) {
    
    on<MotoristaEvent>(_onMotoristaChanged);

    this._streamMotorista = this._api.status.listen((status) => add(MotoristaInitialEvent()));
  }

  Future<void> _onMotoristaChanged(MotoristaEvent event, Emitter<MotoristaState> emitter) async {
    if (event is MotoristaChangedEvent) {
      final motorista = await this._api.atualizar(event.motorista);
      return emitter(MotoristaUpdateState(motorista));
    }

    if (event is MotoristaLoadingEvent) {
      final motorista = await this._api.consultarPorPorHashDispositivo(event.hash);
      return emitter(MotoristaLoadingState(motorista));
    }

    if (event.status == MotoristaStatus.initial) {
      return emitter(MotoristaInitialState());
    }

    if (event.status == MotoristaStatus.error) {
      return emitter(MotoristaErroState());
    }
  }

  @override
  Future<void> close() {
    this._streamMotorista.cancel();
    return super.close();
  }
}
