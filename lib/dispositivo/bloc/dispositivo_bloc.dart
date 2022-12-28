import 'package:coopertalse_motorista/dispositivo/bloc/dispositivo_event.dart';
import 'package:coopertalse_motorista/dispositivo/bloc/dispositivo_state.dart';
import 'package:coopertalse_motorista/dispositivo/dispositivo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DispositivoBloc extends Bloc<DispositivoEvent, DispositivoState> {
  DispositivoBloc() : super(DispositivoState.loading()) {
    on<DispositivoEvent>(_handleEvent);
  }

  _handleEvent(DispositivoEvent event, Emitter<DispositivoState> emitter) {
    if (event.isFinish) {
      final info = event.state.info ?? DispositivoInfo.empty;
      return emitter(DispositivoState.finish(info));
    }

    if (event.isLoading) {
      return _carregarInformacaoDispostivo(emitter);
    }
  }

  _carregarInformacaoDispostivo(Emitter<DispositivoState> emitter) async {
    final info = await Dispositivo.info;
    this.add(DispositivoEvent.finish(DispositivoState.finish(info)));
  }
}
