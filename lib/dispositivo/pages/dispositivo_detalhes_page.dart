import 'package:coopertalse_motorista/dispositivo/bloc/dispositivo_bloc.dart';
import 'package:coopertalse_motorista/dispositivo/bloc/dispositivo_event.dart';
import 'package:coopertalse_motorista/dispositivo/bloc/dispositivo_state.dart';
import 'package:coopertalse_motorista/dispositivo/dispositivo.dart';
import 'package:coopertalse_motorista/util/widgets/circular_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DispositivoDetalhePage extends StatelessWidget {

  final bool iniciado;
  const DispositivoDetalhePage({required this.iniciado, super.key});

  @override
  Widget build(BuildContext context) {
    if (!this.iniciado) {
      context.read<DispositivoBloc>().add(DispositivoLoadingEvent());
    }

    return Padding(
      padding: EdgeInsets.all(5),
      child: BlocBuilder<DispositivoBloc, DispositivoState> (
        builder: (context, state) {
          if (state.status == DispositivoStatus.loading) {
            return Container(
              alignment: Alignment.centerRight,
              child: CircularProgressCustom(size: 25, sizeLine: 2),
            );
          }

          final info = state.info ?? DispositivoInfo.empty;
          return Column(children: [
            Container(
              alignment: Alignment.bottomRight,
              padding: EdgeInsets.only(top: 3),
              child: Text(info.getModelo, style: TextStyle(fontSize: 12)),
            ),
            Container(
              alignment: Alignment.bottomRight,
              padding: EdgeInsets.only(top: 3),
              child: Text(info.getIdentificador, style: TextStyle(fontSize: 12)),
            ),
          ]);
        }
      ),
    );
  }
}
