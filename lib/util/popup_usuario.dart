import 'package:flutter/material.dart';

class PopupUsuario {

  final String mensagem;
  final String textoBotao;

  PopupUsuario(this.mensagem, { 
    this.textoBotao = "" 
  });

  showSnakbar(BuildContext context) {
    final messenger = ScaffoldMessenger.of(context);
    messenger.showSnackBar(
      SnackBar(content: Text(this.mensagem),
      action: this.textoBotao.isEmpty
          ? null
          : SnackBarAction(
              label: this.textoBotao, 
              onPressed: messenger.hideCurrentSnackBar
            )
      ),
    );
  }
}