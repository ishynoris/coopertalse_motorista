import 'package:coopertalse_motorista/carro/carro.dart';
import 'package:coopertalse_motorista/motorista/dao/motorista_dao_interface.dart';
import 'package:coopertalse_motorista/motorista/motorista.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MotoristaSharedPreferences implements MotoristaDAOInterface {

  static const _prefix = "motorista.";
  static const _prefixId = "{$_prefix}.id";
  static const _prefixNome = "{$_prefix}.nom";
  static const _prefixNumeroPix = "{$_prefix}.numero_pix";
  static const _prefixNumeroCarro = "{$_prefix}.numero_carro";

  SharedPreferences prefs;

  MotoristaSharedPreferences(this.prefs);

  @override
  bool insert(Motorista motorista) {
    this.prefs.setInt(_prefixId, motorista.getId ?? 0);
    this.prefs.setString(_prefixNome, motorista.getNome);
    this.prefs.setString(_prefixNumeroPix, motorista.getNumeroPix ?? "");
    this.prefs.setInt(_prefixNumeroCarro, int.parse(motorista.getNumeroCarro));
    return true;
  }

  @override
  Motorista select() {
    final id = this.prefs.getInt(_prefixId);
    final nome = this.prefs.getString(_prefixNome);
    final numeroCarro = this.prefs.getInt(_prefixNumeroPix);
    final pix = this.prefs.getString(_prefixNumeroCarro);

    if (nome == null || nome.isEmpty) {
      throw FormatException("Não é possível salvar um motorista sem nome");
    }

    if (numeroCarro == null || numeroCarro == 0)  {
      throw FormatException("Não é possível salvar o motorista sem o número do carro");
    }

    return Motorista(
      id: id,
      nome: nome, 
      carro: Carro(numeroCarro), 
      pix: pix
    );
  }

  @override
  Motorista update(Motorista motorista) {
    this.insert(motorista);
    return motorista;
  }
}
