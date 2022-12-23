import 'package:coopertalse_motorista/dispositivo/bloc/dispositivo_event.dart';
import 'package:coopertalse_motorista/dispositivo/bloc/dispositivo_state.dart';
import 'package:coopertalse_motorista/dispositivo/dispositivo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DispositivoBloc extends Bloc<DispositivoEvent, DispositivoState> {
  DispositivoBloc() : super(DispositivoLoadingState()) {
    on<DispositivoEvent>(_handleEvent);
  }

  _handleEvent(DispositivoEvent event, Emitter<DispositivoState> emitter) {
    if (event is DispositivoFinishEvent) {
      return emitter(DispositivoFinishState(event.state.info));
    }

    if (event is DispositivoLoadingEvent) {
      return _carregarInformacaoDispostivo(emitter);
    }
  }

  _carregarInformacaoDispostivo(Emitter<DispositivoState> emitter) async {
    final info = await Dispositivo.info;
    this.add(DispositivoFinishEvent(info));
  }
}
