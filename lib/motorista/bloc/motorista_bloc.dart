import 'dart:async';

import 'package:coopertalse_motorista/exceptions/coopertalse_exception.dart';
import 'package:coopertalse_motorista/motorista/api/motorista_api.dart';
import 'package:coopertalse_motorista/motorista/bloc/motorista_event.dart';
import 'package:coopertalse_motorista/motorista/bloc/motorista_state.dart';
import 'package:coopertalse_motorista/motorista/motorista.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MotoristaBloc extends Bloc<MotoristaEvent, MotoristaState> {

  final _api = MotoristaAPI();
  late StreamSubscription<MotoristaState> _streamMotorista;

  MotoristaBloc() : super(MotoristaInitialState()) {
    
    on<MotoristaEvent>(_handleEvent);
  }

  Future<void> _handleEvent(MotoristaEvent event, Emitter<MotoristaState> emitter) async {
    if (event is MotoristaChangedEvent) {
      final motorista = await this._api.atualizar(event.motorista);
      motorista.atualizar();
      return emitter(MotoristaSucessoState("Atualiza com sucesso", motorista));
    }

    if (event is MotoristaLoadingEvent) {
      try {
        Motorista motorista = await this._api.consultarPorPorHashDispositivo(event.hash);
        motorista = motorista.copy(dispositivo: event.info);
        motorista.atualizar();
        return emitter(MotoristaSucessoState("Suas informações foram recuperadas com sucesso", motorista));
      } catch(e) {
        final mensagem = e is CoopertalseException
          ? e.toString()
          : "Ocorreu um erro ao consultar os dados do motorista";
        return emitter(MotoristaErroState(mensagem));
      }
    }

    if (event is MotoristaErrorEvent) {
      return emitter(MotoristaErroState(event.mensagem));
    }

    if (event is MotoristaInitialEvent) {
      return emitter(MotoristaInitialState());
    }
  }

  @override
  Future<void> close() {
    this._streamMotorista.cancel();
    return super.close();
  }
}
