
// ignore_for_file: prefer_const_constructors

import 'package:coopertalse_motorista/carro/carro.dart';
import 'package:coopertalse_motorista/motorista/motorista.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class FormMotorista extends StatefulWidget {

  final Motorista? _motorista;

  const  FormMotorista(this._motorista, { super.key });
  
  @override
  State<StatefulWidget> createState() => _FormMotoristaState();
}

class _FormMotoristaState extends State<FormMotorista> {

  bool _numeroCarroDisabled = false;
  bool _nomeMotoristaDisabled = false;
  bool _numeroPixDisabled = false;

  bool get _hasCadastro {
    var motorista = widget._motorista;
    return motorista != null && motorista.isValido();
  }

  @override
  void initState() {
    super.initState();
    bool disabled = _hasCadastro;
    _numeroCarroDisabled = disabled;
    _nomeMotoristaDisabled = disabled;
    _numeroPixDisabled = disabled;
  }

  @override
  FormBuilder build(BuildContext context) {

    final formMotoristaNovo = GlobalKey<FormBuilderState>();
    final nomeMotorista = widget._motorista?.getNome();
    final numeroCarro = widget._motorista?.getNumeroCarro().toString();

    return FormBuilder(
      child: Padding(
        padding: EdgeInsets.only(top: 18),
        child: Column(
          children: [
            FormBuilderTextField(
              name: "nome_motorista",
              enabled: _nomeMotoristaDisabled,
              initialValue: nomeMotorista,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: MotoristaValidator.validarNome,
              decoration: InputDecoration(
                labelText: "Nome do motorista",
                prefixIcon: Icon(Icons.person),
                suffixIcon: _getIconEdit(() => _atualizaEstado(nomeMotoristaDisabled: false)),
              ),
            ),
            FormBuilderTextField(
              name: "numero_carro",
              enabled: _numeroCarroDisabled,
              initialValue: numeroCarro,
              keyboardType: TextInputType.number,
              inputFormatters: [ FilteringTextInputFormatter.digitsOnly ],
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: CarroValidator.validarNumero,
              decoration: InputDecoration(
                labelText: "Número do carro",
                prefixIcon: Icon(Icons.directions_bus_filled),
                suffixIcon: _getIconEdit(() => _atualizaEstado(numeroCarroDisabled: false)),
              ),
            ),
            FormBuilderTextField(
              name: "numero_pix",
              enabled: _numeroCarroDisabled,
              decoration: InputDecoration(
                labelText: "Chave PIX",
                prefixIcon: Icon(Icons.pix),
                suffixIcon: _getIconEdit(() => _atualizaEstado(numeroCarroDisabled: false)),
              ),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              margin: EdgeInsets.only(top: 20),
              child: ElevatedButton(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.check),
                    SizedBox(height: 5),
                    Text("Salvar")
                  ],
                ),
                onPressed: () {
                  final fields = formMotoristaNovo.currentState?.fields ?? <String, FormBuilderFieldState>{};
                  final nomeMotorista = fields['nome_motorista']?.value ?? "";
                  final numeroCarro = int.tryParse(fields['numero_carro']?.value ?? "") ?? 0;

                  Motorista? motorista = widget._motorista;
                  motorista = motorista == null 
                          ? Motorista(nome: nomeMotorista, carro: Carro(numeroCarro))
                          : motorista.copy(nome: nomeMotorista, numero: numeroCarro);
                  if (motorista.cadastrar()) {
                    _atualizaEstado(nomeMotoristaDisabled: true, numeroCarroDisabled: true);
                  }
                },
              ),
            )
          ],
        )
      ),
    );
  }

  IconButton? _getIconEdit(Function()? onClicked) {
    if (!_hasCadastro) {
      return null;
    }

    return IconButton(
      icon: Icon(Icons.edit),
      onPressed: onClicked,
    );
  }

  _atualizaEstado({
    bool? nomeMotoristaDisabled,
    bool? numeroCarroDisabled,
  }) {
    setState(() {
      _nomeMotoristaDisabled = nomeMotoristaDisabled ?? _nomeMotoristaDisabled;
      _numeroCarroDisabled = numeroCarroDisabled ?? _numeroCarroDisabled;
    });
  }
}