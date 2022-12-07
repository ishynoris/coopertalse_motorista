import 'package:coopertalse_motorista/motorista/motorista.dart';
import 'package:coopertalse_motorista/motorista/pages/components/form_motorista.dart';
import 'package:coopertalse_motorista/motorista/repo/shared_preferences_repo.dart';
import 'package:flutter/material.dart';

class MotoristaPage extends StatelessWidget {

  Motorista? _motorista;
  late String _title;

  MotoristaPage({ super.key });

  @override
  Widget build(BuildContext context) {
    
    this._init();

    return Scaffold(
      appBar: AppBar(title: Text(this._title)),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 10),
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
}
