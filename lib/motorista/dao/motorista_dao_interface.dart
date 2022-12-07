import '../motorista.dart';

abstract class MotoristaDAOInterface {

  bool insert(Motorista motorista);

  Motorista select();

  Motorista update(Motorista motorista);
}