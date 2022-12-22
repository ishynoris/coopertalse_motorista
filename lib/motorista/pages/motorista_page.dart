import 'package:coopertalse_motorista/motorista/api/motorista_api.dart';
import 'package:coopertalse_motorista/motorista/motorista.dart';
import 'package:coopertalse_motorista/motorista/pages/components/form_motorista.dart';
import 'package:coopertalse_motorista/util/dispositivo.dart';
import 'package:flutter/material.dart';

class MotoristaPage extends StatefulWidget {

  const MotoristaPage({ super.key });

  @override
  State<StatefulWidget> createState() => _MotoristaState();
}

class _MotoristaState extends State<MotoristaPage> {

  String _title = "Novo motorista";
  Motorista _motorista = Motorista.empty();
  DispositivoInfo _info = DispositivoInfo.empty();

  @override
  void initState() {
    super.initState();
    this._initMotorista();
    this._initInfoDispositivo();
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
                    "Insira as informações do carro",
                    style: TextStyle(fontSize: 18, color: Colors.black87),
                  ),
                ],
              ),
            ),
            FormMotorista(motorista:  _motorista),
            Container(
              alignment: Alignment.bottomRight,
              padding: EdgeInsets.only(top: 3),
              child: Text(this._info.getModelo),
            ),
            Container(
              alignment: Alignment.bottomRight,
              padding: EdgeInsets.only(top: 3),
              child: Text(this._info.getIdentificador),
            ),
          ],
        ),
      ),
    );
  }

  _initMotorista() async {
    final motorista = await MotoristaAPI.consultarPorPorHashDispositivo("DDDDDDDD");
    _atualzarEstado(motorista: motorista, title: "Detalhes do motorista");
  }

  _initInfoDispositivo() async {
    DispositivoInfo info = await Dispositivo.getInfo();
    Motorista motorista = this._motorista.copy(dispositivo: info);
    _atualzarEstado(info: info, motorista: motorista);
  }

  _atualzarEstado({
    Motorista? motorista,
    String? title,
    DispositivoInfo? info,
  }) {
    setState(() {
      this._motorista = motorista ?? this._motorista;
      this._title = title ?? this._title;
      this._info = info ?? this._info;
    });
  }
}
