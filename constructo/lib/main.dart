import 'package:constructo/components/gasto_cadastro.dart';
import 'package:constructo/components/comodo_cadastro.dart';
import 'package:constructo/components/home.dart';
import 'package:constructo/components/sobre.dart';
import 'package:constructo/components/tela_comodo.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.brown,
        accentColor: Color.fromARGB(255, 72, 34, 16),
      ),
      home: HomeConstructo(),
      onGenerateRoute: (RouteSettings settings) {
        final arguments = settings.arguments;
        switch (settings.name) {
          case '/home':
            return MaterialPageRoute(builder: (context) => HomeConstructo());
          case '/adicionar':
            return MaterialPageRoute(builder: (context) => CadastroComodo());
          case '/sobre':
            return MaterialPageRoute(builder: (context) => Sobre());
          case '/comodo':
            return MaterialPageRoute(
                builder: (context) => TelaComodo(arguments));
          case '/gasto':
            return MaterialPageRoute(builder: (context) => CadastroGasto());
          default:
            return null;
        }
      }));
}
