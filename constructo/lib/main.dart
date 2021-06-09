import 'package:constructo/components/comodo_form.dart';
import 'package:constructo/utils/DatabaseComodo.dart';
import 'package:flutter/material.dart';
import 'components/comodo_form.dart';
import 'components/comodos_lista.dart';
import 'models/comodo.dart';

main() => runApp(ExpensesApp());

class ExpensesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
      theme: ThemeData(
        primarySwatch: Colors.brown,
        accentColor: Colors.amber,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Comodo> comodos = List<Comodo>();

  @override
  void initState() {
    super.initState();

    DataBaseComodo().getComodo().then((lista) {
      setState(() {
        comodos = lista;
        for (var i = 0; i < comodos.length; i++) {
          Comodo comodosCadastrados = Comodo(
              comodos[i].id,
              comodos[i].titulo,
              comodos[i].descricao,
              comodos[i].valorTotal,
              comodos[i].tipoComodo);
          _listaComodos.add(comodosCadastrados);
        }
      });
    });
  }

  int gerarIndex() {
    if (_listaComodos.isNotEmpty) {
      return _listaComodos.last.id + 1;
    }
    return 1;
  }

  final List<Comodo> _listaComodos = [];

  _abrirModalForm(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return ComodoForm(_addComodo); //Adicionando comodo
        });
  }

  _addComodo(String titulo, String descricao, Text tipoComodo) {
    final novoComodo =
        Comodo(gerarIndex(), titulo, descricao, 0, tipoComodo.data);

    setState(() {
      _listaComodos.add(novoComodo);
      DataBaseComodo().criar(novoComodo);
      //Adicionando na lista e mudando o visual
    });
    Navigator.of(context).pop();
  }

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              color: Color.fromARGB(255, 72, 34, 16),
              height: 130,
              width: double.infinity,
              child: Center(
                  child: Text(
                "Seja bem-vindo(a)!",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                ),
              )),
            ),
            //Image.asset('assets/images/logo2.png'),
            ComodoLista(_listaComodos),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Color.fromARGB(255, 72, 34, 16),
        foregroundColor: Colors.white,
        onPressed: () => _abrirModalForm(context),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Color.fromARGB(255, 72, 34, 16),
        iconSize: 40,
        selectedFontSize: 20,
        unselectedFontSize: 15,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.add_box_outlined),
              title: Text('Adicionar cômodo')),
          BottomNavigationBarItem(
              icon: Icon(Icons.info_outline), title: Text('Sobre')),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
