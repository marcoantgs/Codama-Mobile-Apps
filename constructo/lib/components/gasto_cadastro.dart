import 'package:constructo/components/sobre.dart';
import 'package:constructo/models/comodo.dart';
import 'package:constructo/models/gasto.dart';
import 'package:constructo/utils/OperacoesGasto.dart';
import 'package:flutter/material.dart';

class CadastroGasto extends StatefulWidget {
  final Comodo comodo;
  CadastroGasto({this.comodo});

  @override
  _CadastroGastoState createState() => _CadastroGastoState();
}

class _CadastroGastoState extends State<CadastroGasto> {
  List<Gasto> gastos = List<Gasto>();

  final tituloController = TextEditingController();
  final valorController = TextEditingController();

  _trocaDeTela(int index) {
    if (index == 0) {
      setState(() {
        Navigator.popAndPushNamed(context, '/home');
      });
    } else if (index == 2) {
      setState(() {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Sobre()));
      });
    }
  }

  _btCadastrar() {
    //Pegando os valores
    final id = 0;
    final titulo = tituloController.text;
    final valor = double.tryParse(valorController.text) ?? 0.0;
    final comodo = widget.comodo.id;

    //Caso o titulo esteja vazio
    if (titulo.isEmpty) {
      return;
    }

    //Atribuindo valores e cadastrando no banco de dados
    final novoGasto = Gasto(id, titulo, valor, comodo);
    OperacoesGasto().inserir(novoGasto);

    //Chamando a outra tela
    setState(() {
      Navigator.popAndPushNamed(context, '/comodo', arguments: widget.comodo);
    });
  }

  _btCancelar() {
    Navigator.pop(context);
  }

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
                  "Cadastrar gasto",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                  ),
                ),
              ),
            ),
            Card(
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: <Widget>[
                    TextField(
                      controller: tituloController,
                      decoration: InputDecoration(labelText: 'Título'),
                    ),
                    TextField(
                      controller: valorController,
                      decoration: InputDecoration(labelText: 'valor')),
                    Container(
                      padding: const EdgeInsets.all(10.0),
                    ),
                    Container(
                      padding: const EdgeInsets.all(5.0),
                      margin: const EdgeInsets.only(top: 20.0),
                      height: 45,
                      width: 400,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Color.fromARGB(255, 72, 34, 16), // background
                          onPrimary: Colors.white, // foreground
                        ),
                        child: Text('Novo Gasto'),
                        onPressed: _btCadastrar),
                    ),
                    Container(
                      padding: const EdgeInsets.all(5.0),
                      height: 45,
                      width: 400,
                      child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.brown[50], // background
                          onPrimary: Colors.black, // foreground
                        ),
                      child: Text('Cancelar'), 
                      onPressed: _btCancelar)
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Color.fromARGB(255, 72, 34, 16),
        iconSize: 40,
        selectedFontSize: 15,
        unselectedFontSize: 15,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.add_box_outlined), label: 'Cômodo'),
          BottomNavigationBarItem(
              icon: Icon(Icons.info_outline), label: 'Sobre'),
        ],
        onTap: (index) {
          _trocaDeTela(index);
        },
      ),
    );
  }








}
