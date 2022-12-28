import 'dart:async';

import 'package:coopertalse_motorista/exceptions/coopertalse_exception.dart';
import 'package:coopertalse_motorista/motorista/api/motorista_api.dart';
import 'package:coopertalse_motorista/motorista/bloc/motorista_event.dart';
import 'package:coopertalse_motorista/motorista/bloc/motorista_state.dart';
import 'package:coopertalse_motorista/motorista/motorista.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MotoristaBloc extends Bloc<MotoristaEvent, MotoristaState> {

  late StreamSubscription<MotoristaState> _streamMotorista;

  MotoristaBloc() : super(MotoristaState.initial()) {
    
    on<MotoristaEvent>(_handleEvent);
  }

  Future<void> _handleEvent(MotoristaEvent event, Emitter<MotoristaState> emitter) async {
    if (event.isChanged) {
      final motorista = event.motorista;
      await (motorista.hasId ? motorista.atualizar() : motorista.cadastrar());
      return emitter(MotoristaState.sucess("Atualizado com sucesso", motorista));
    }

    if (event.isLoading) {
      try {
        Motorista motorista = await MotoristaAPI.consultarPorPorHashDispositivo(event.getHash);
        return emitter(MotoristaState.sucess("Suas informações foram recuperadas com sucesso", motorista));
      } catch(e) {
        final mensagem = CoopertalseException.message(e, padrao: "Ocorreu um erro ao consultar os dados do motorista");
        return emitter(MotoristaState.error(mensagem));
      }
    }

    if (event.isError) {
      return emitter(MotoristaState.error(event.getMensage));
    }

    if (event.isInitial) {
      return emitter(MotoristaState.initial());
    }
  }

  @override
  Future<void> close() {
    this._streamMotorista.cancel();
    return super.close();
  }
}
