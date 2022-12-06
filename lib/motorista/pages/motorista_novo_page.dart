import 'package:coopertalse_motorista/carro/carro.dart';
import 'package:coopertalse_motorista/motorista/motorista.dart';
import 'package:coopertalse_motorista/motorista/pages/components/form_motorista.dart';
import 'package:flutter/material.dart';

class MotoristaNovoPage extends StatelessWidget {

  const MotoristaNovoPage({ super.key });

  @override
  Widget build(BuildContext context) {
    
    Motorista? motorista = Motorista(nome: "Joaozinho", carro: Carro(20), id: 1);
    motorista = null;

    return Scaffold(
      appBar: AppBar(title: const Text("Novo Motorista")),
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
            FormMotorista(motorista:  motorista),
          ],
        ),
      ),
    );
  }
}
