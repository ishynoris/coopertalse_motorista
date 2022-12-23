import 'package:coopertalse_motorista/dispositivo/bloc/dispositivo_bloc.dart';
import 'package:coopertalse_motorista/dispositivo/bloc/dispositivo_event.dart';
import 'package:coopertalse_motorista/dispositivo/bloc/dispositivo_state.dart';
import 'package:coopertalse_motorista/dispositivo/dispositivo.dart';
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
              child: _CircularProgressIndicator(size: 25, sizeLine: 2),
            );
          }

          final info = state.info ?? DispositivoInfo.empty;
          return Column(children: [
            Container(
              alignment: Alignment.bottomRight,
              padding: EdgeInsets.only(top: 3),
              child: Text("Modelo ${info.getModelo}"),
            ),
            Container(
              alignment: Alignment.bottomRight,
              padding: EdgeInsets.only(top: 3),
              child: Text("Dispositivo ${info.getIdentificador}"),
            ),
          ]);
        }
      ),
    );
  }
}

class _CircularProgressIndicator extends StatelessWidget {
  final double size;
  final double sizeLine;

  const _CircularProgressIndicator({
    required this.size,
    required this.sizeLine,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: this.size,
      width: this.size,
      child: CircularProgressIndicator(strokeWidth: this.sizeLine)
    );
  }
}
