import 'package:constructo/components/comodo_cadastro.dart';
import 'package:constructo/components/home.dart';
import 'package:constructo/components/sobre.dart';
import 'package:constructo/components/tela_comodo.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData(
      primarySwatch: Colors.brown,
      accentColor: Colors.amber,
    ),
    home: HomeConstructo(),
    routes: <String, WidgetBuilder>{
      '/home': (BuildContext context) => HomeConstructo(),
      '/adicionar': (BuildContext context) => CadastroComodo(),
      '/sobre': (BuildContext context) => Sobre(),
      '/comodo': (BuildContext context) => TelaComodo(),
    },
  ));
}
