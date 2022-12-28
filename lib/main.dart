import 'package:coopertalse_motorista/dependencias/dependencias.dart';
import 'package:coopertalse_motorista/dispositivo/bloc/dispositivo_bloc.dart';
import 'package:coopertalse_motorista/motorista/bloc/motorista_bloc.dart';
import 'package:coopertalse_motorista/motorista/pages/motorista_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Dependencias.init();

  runApp(
    MultiProvider(
      providers: [
        Provider(create: (_) => MotoristaBloc()),
        Provider(create: (_) => DispositivoBloc()),
      ],
      child: const App(),
    ));
}

class App extends StatefulWidget {
  const App({ super.key });

  @override
  State<StatefulWidget> createState() => _AppState();
}

class _AppState extends State<App> {

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MotoristaPage(),
    );
  }
}