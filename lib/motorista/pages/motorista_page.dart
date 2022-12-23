import 'package:coopertalse_motorista/dispositivo/bloc/dispositivo_bloc.dart';
import 'package:coopertalse_motorista/dispositivo/bloc/dispositivo_state.dart';
import 'package:coopertalse_motorista/dispositivo/pages/dispositivo_detalhes_page.dart';
import 'package:coopertalse_motorista/motorista/bloc/motorista_bloc.dart';
import 'package:coopertalse_motorista/motorista/bloc/motorista_event.dart';
import 'package:coopertalse_motorista/motorista/bloc/motorista_state.dart';
import 'package:coopertalse_motorista/motorista/pages/components/form_motorista.dart';
import 'package:coopertalse_motorista/util/popup_usuario.dart';
import 'package:coopertalse_motorista/util/widgets/circular_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MotoristaPage extends StatefulWidget {
  const MotoristaPage({ super.key });

  @override
  State<StatefulWidget> createState() => _MotoristaState();
}

class _MotoristaState extends State<MotoristaPage> {
  late String _title;
  late bool _inicado;
  final motoristaBloc = MotoristaBloc();
  
  _MotoristaState();

  @override
  void initState() {
    this._title = "Novo motorista";
    this._inicado = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text(this._title)),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 18, bottom: 5),
              child: _Subtitulo("Informações do motorista", carregando: !this._inicado),
            ),
            BlocProvider(
              create: (context) => motoristaBloc,
              child: BlocListener<MotoristaBloc, MotoristaState>(
                listener: _listenMotoristaEvent,
                child: FormMotorista(),
              ),
            ),
            BlocProvider(
              create: (context) => DispositivoBloc(),
              child: BlocListener<DispositivoBloc, DispositivoState>(
                listener: _listenDispostivoEvent,
                child: DispositivoDetalhePage(iniciado: this._inicado),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _listenMotoristaEvent(BuildContext context, MotoristaState state) {
    if (state is MotoristaSucessoState) {
      PopupUsuario(state.mensagem).showSnakbar(context);
      setState(() {
        this._title = "Detalhes do motorista";
        this._inicado = true;
      });
    }
  }

  _listenDispostivoEvent(BuildContext context, DispositivoState state) {
    final String hashDispositivo = state.info?.getIdentificador ?? "";
    motoristaBloc.add(MotoristaLoadingEvent(hash: hashDispositivo));
  }
}

class _Subtitulo extends StatelessWidget {
  
  final String texto;
  final bool carregando;
  const _Subtitulo(this.texto, { 
    this.carregando = true,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(this.texto),
        if (this.carregando) 
          CircularProgressCustom(
            size: 26, 
            sizeLine: 2, 
            color: Colors.black,
            margin: EdgeInsets.all(4),
          ),
      ],
    );
  }
}
