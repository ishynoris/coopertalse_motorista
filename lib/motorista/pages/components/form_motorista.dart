
// ignore_for_file: prefer_const_constructors

import 'package:coopertalse_motorista/carro/carro.dart';
import 'package:coopertalse_motorista/motorista/motorista.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class FormMotorista extends StatefulWidget {

  late Motorista? motorista;

  FormMotorista({ this.motorista, super.key });
  
  @override
  State<StatefulWidget> createState() => _FormMotoristaState();
}

class _FormMotoristaState extends State<FormMotorista> {

  bool _hasCadastro = false;
  bool _numeroCarroEnabled = false;
  bool _nomeMotoristaEnabled = false;
  bool _numeroPixEnabled = false;
  Motorista? _motorista;

  @override
  void initState() {
    super.initState();
    this._motorista = widget.motorista;
    this._hasCadastro = _motorista != null && _motorista!.isValido();

    bool enabled = !this._hasCadastro;
    this._numeroCarroEnabled = enabled;
    this._nomeMotoristaEnabled = enabled;
    this._numeroPixEnabled = enabled;
  }

  @override
  FormBuilder build(BuildContext context) {

    final formMotoristaNovo = GlobalKey<FormBuilderState>();

    return FormBuilder(
      key: formMotoristaNovo,
      child: Padding(
        padding: EdgeInsets.only(top: 18),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(child: FormBuilderTextField(
                  name: "nome_motorista",
                  enabled: _nomeMotoristaEnabled,
                  initialValue: this._motorista?.getNome,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: MotoristaValidator.validarNome,
                  decoration: InputDecoration(
                    labelText: "Nome do motorista",
                    prefixIcon: Icon(Icons.person),
                  ),
                )),
                if (_hasCadastro) _getIconEdit(() => _atualizaEstado(nomeMotoristaEnabled: true)),
              ],
            ),
            Row(
              children: [
                Expanded(child: FormBuilderTextField(
                  name: "numero_carro",
                  enabled: _numeroCarroEnabled,
                  initialValue: this._motorista?.getNumeroCarro,
                  keyboardType: TextInputType.number,
                  inputFormatters: [ FilteringTextInputFormatter.digitsOnly ],
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: CarroValidator.validarNumero,
                  decoration: InputDecoration(
                    labelText: "Número do carro",
                    prefixIcon: Icon(Icons.directions_bus_filled),
                  ),
                )),
                if (_hasCadastro) _getIconEdit(() => _atualizaEstado(numeroCarroEnabled: true)),
              ],
            ),
            Row(
              children: [
                Expanded(child:  FormBuilderTextField(
                  name: "numero_pix",
                  initialValue: this._motorista?.getNumeroPix,
                  enabled: _numeroPixEnabled,
                  decoration: InputDecoration(
                    labelText: "Chave PIX",
                    prefixIcon: Icon(Icons.pix),
                  ),
                )),
                if (_hasCadastro) _getIconEdit(() => _atualizaEstado(numeroPixEnabled: true)),
              ],
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
                  if (!this._hasCampoHabilitado()) {
                    return;
                  }
                  Motorista motorista = this._crateMotoristaFromState(formMotoristaNovo.currentState);
                  if (motorista.cadastrar()) {
                    _atualizaEstado(
                      hasCadastro: true,
                      nomeMotoristaEnabled: false,
                      numeroCarroEnabled: false,
                      numeroPixEnabled: false,
                      motorista: motorista,
                    );
                    _exibirToast(context, "Motorista cadastrado com sucesso");
                  }
                },
              ),
            )
          ],
        )
      ),
    );
  }

  IconButton _getIconEdit(onPressed) {
    return IconButton(icon: Icon(Icons.edit), onPressed: onPressed);
  }

  _exibirToast(BuildContext context, String mensagem) {
    final messenger = ScaffoldMessenger.of(context);
    messenger.showSnackBar(SnackBar(
      content: Text(mensagem),
      action: SnackBarAction(
        label: "OK",
        onPressed: messenger.hideCurrentSnackBar
      ),
    ));
  }

  _atualizaEstado({
    bool? hasCadastro,
    bool? nomeMotoristaEnabled,
    bool? numeroCarroEnabled,
    bool? numeroPixEnabled,
    Motorista? motorista,
  }) {
    setState(() {
      this._hasCadastro = hasCadastro ?? this._hasCadastro;
      this._nomeMotoristaEnabled = nomeMotoristaEnabled ?? this._nomeMotoristaEnabled;
      this._numeroCarroEnabled = numeroCarroEnabled ?? this._numeroCarroEnabled;
      this._numeroPixEnabled = numeroPixEnabled ??this._numeroPixEnabled;
      this._motorista = motorista ?? this._motorista;
    });
  }

  bool _hasCampoHabilitado() {
    return this._nomeMotoristaEnabled || this._numeroCarroEnabled || this._numeroPixEnabled;
  }

  Motorista _crateMotoristaFromState(FormBuilderState? state) {
    final fields = state?.fields ?? <String, FormBuilderFieldState>{};
    final nomeMotorista = fields['nome_motorista']?.value;
    final numeroCarro = int.tryParse(fields['numero_carro']?.value ?? "") ?? 0;
    final numeroPix = fields['numero_pix']?.value;

    if (this._motorista == null) {
      return Motorista(
        nome: nomeMotorista, 
        carro: Carro(numeroCarro),
        pix: numeroPix,
      );
    }

    return this._motorista!.copy(
        nome: nomeMotorista, 
        numero: numeroCarro,
        pix: numeroPix,
    );
  }
}