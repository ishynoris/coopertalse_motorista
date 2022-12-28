
// ignore_for_file: prefer_const_constructors

import 'package:coopertalse_motorista/carro/carro.dart';
import 'package:coopertalse_motorista/motorista/bloc/motorista_bloc.dart';
import 'package:coopertalse_motorista/motorista/bloc/motorista_event.dart';
import 'package:coopertalse_motorista/motorista/bloc/motorista_state.dart';
import 'package:coopertalse_motorista/motorista/motorista.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class FormMotorista extends StatelessWidget {

  final _formMotorista = GlobalKey<FormBuilderState>();

  FormMotorista({super.key});

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: _formMotorista,
      child: Padding(
        padding: EdgeInsets.only(top: 0),
        child: BlocBuilder<MotoristaBloc, MotoristaState>(
          builder: (context, state) {
            final motorista = state.motorista;
            return Column(
              children: [
                _InputMotorista(
                  name: "mta_nome", 
                  label: "Nome do motorista",
                  value: motorista.getNome,
                  icon: Icons.person,
                  validador: MotoristaValidator.validarNome,
                ),
                _InputMotorista(
                  name: "cro_numero", 
                  label: "Número do carro", 
                  value: motorista.getNumeroCarro,
                  icon: Icons.directions_bus_filled,
                  validador: CarroValidator.validarNumero,
                ),
                _InputMotorista(
                  name: "chx_chave_pix", 
                  label: "Chave PIX", 
                  value: motorista.getNumeroPix,
                  icon: Icons.pix
                ),
                _ButtonConfirm(texto: "Salvar", onPressed: () => _onClicked(context)),
              ],
            );
          }
        ),
      )
    );
  }

  _onClicked(BuildContext context) {
    Motorista motorista = this._crateMotoristaFromState(this._formMotorista.currentState);
    context.read<MotoristaBloc>().add(MotoristaChangedEvent(motorista: motorista));
  }

  Motorista _crateMotoristaFromState(FormBuilderState? state) {
    final fields = state?.fields ?? <String, FormBuilderFieldState>{};
    final nomeMotorista = fields['mta_nome']?.value ?? "";
    final numeroCarro = fields['cro_numero']?.value ?? "";
    final numeroPix = fields['chx_chave_pix']?.value ?? "";

    return Motorista(
      nome: nomeMotorista, 
      carro: Carro(numeroCarro),
      pix: numeroPix,
    );
  }
}

class _InputMotorista extends StatelessWidget {
  final String name;
  final String label;
  final String value;
  final IconData icon;
  final String? Function(String?)? validador;

  const _InputMotorista({
    required this.name,
    required this.label,
    required this.value,
    required this.icon,
    this.validador,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: FormBuilderTextField(
          name: this.name,
          initialValue: this.value,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: this.validador,
          decoration: InputDecoration(
            labelText: this.label,
            prefixIcon: Icon(this.icon),
          ),
        )),
      ],
    );
  }
}

class _ButtonConfirm extends StatelessWidget {
  final String texto;
  final Function()? onPressed;

  const _ButtonConfirm({
    required this.texto,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      margin: EdgeInsets.only(top: 20),
      child: ElevatedButton(
        onPressed: this.onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.check),
            SizedBox(height: 5),
            Text(this.texto),
          ],
        ),
      ),
    );
  }
}
