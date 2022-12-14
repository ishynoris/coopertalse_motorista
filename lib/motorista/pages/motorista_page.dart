import 'package:coopertalse_motorista/motorista/motorista.dart';
import 'package:coopertalse_motorista/motorista/pages/components/form_motorista.dart';
import 'package:coopertalse_motorista/motorista/repo/shared_preferences_repo.dart';
import 'package:coopertalse_motorista/util/dispositivo.dart';
import 'package:flutter/material.dart';

class MotoristaPage extends StatefulWidget {

  const MotoristaPage({ super.key });

  @override
  State<StatefulWidget> createState() => _MotoristaState();
}

class _MotoristaState extends State<MotoristaPage> {

  late String _title;
  Motorista? _motorista;
  DispositivoInfo? _info;

  @override
  void initState() {
    super.initState();
    this._init();
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
            if (this._info != null) 
              Container(
                alignment: Alignment.bottomRight,
                padding: EdgeInsets.only(top: 3),
                child: Text(this._info!.getModelo),
              ),
            if (this._info != null) 
              Container(
                alignment: Alignment.bottomRight,
                padding: EdgeInsets.only(top: 3),
                child: Text(this._info!.getIdentificador),
              ),
          ],
        ),
      ),
    );
  }

  _init() {
    try {
      this._motorista = SharedPreferencesRepo.getMotorista.select();
      this._title = "Detalhes do motorista";
    } on FormatException {
      this._title = "Novo motorista";
    }
  }

  _initInfoDispositivo() async {
    DispositivoInfo? info = await Dispositivo.getInfo();
    setState(() {
      this._info = info;
      this._motorista = this._motorista!.copy(dispositivo: this._info);
      this._motorista!.atualizar();
    });
  }
}
