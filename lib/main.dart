import 'package:coopertalse_motorista/dependencias/dependencias.dart';
import 'package:coopertalse_motorista/motorista/pages/motorista_page.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Dependencias.init();

  runApp(const App());
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