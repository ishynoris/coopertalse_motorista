import 'package:coopertalse_motorista/dispositivo/bloc/dispositivo_bloc.dart';
import 'package:coopertalse_motorista/dispositivo/bloc/dispositivo_state.dart';
import 'package:coopertalse_motorista/dispositivo/pages/dispositivo_detalhes_page.dart';
import 'package:coopertalse_motorista/motorista/bloc/motorista_bloc.dart';
import 'package:coopertalse_motorista/motorista/bloc/motorista_event.dart';
import 'package:coopertalse_motorista/motorista/bloc/motorista_state.dart';
import 'package:coopertalse_motorista/motorista/pages/components/form_motorista.dart';
import 'package:coopertalse_motorista/util/popup_usuario.dart';
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Informações do motorista/carro",
                    style: TextStyle(fontSize: 18, color: Colors.black87),
                  ),
                ],
              ),
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
