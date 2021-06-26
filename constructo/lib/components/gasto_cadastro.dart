import 'package:constructo/models/comodo.dart';
import 'package:constructo/models/gasto.dart';
import 'package:constructo/utils/OperacoesGasto.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CadastroGasto extends StatefulWidget {
  final Comodo comodo;
  CadastroGasto(this.comodo);

  @override
  _CadastroGastoState createState() => _CadastroGastoState();
}

class _CadastroGastoState extends State<CadastroGasto> {
  List<Gasto> gastos = List<Gasto>();

  final tituloController = TextEditingController();
  final valorController = TextEditingController();

  _btCadastrar() {
    //Pegando os valores
    final id = 0;
    final titulo = tituloController.text;
    final valor = double.tryParse(valorController.text);
    final comodo = widget.comodo.id;

    //Tratando campos
    //Caso o titulo esteja vazio
    if (titulo.isEmpty) {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
            title: Text('Aviso'),
            content: Text('O campo "Título" não pode estar vazio.'),
            actions: [
              FlatButton(
                child: Text("Ok"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ]),
      );
      return;
    } else
    //Caso o valor esteja vazio
    if (valorController.text.isEmpty) {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
            title: Text('Aviso'),
            content: Text('O campo "Valor" não pode estar vazio.'),
            actions: [
              FlatButton(
                child: Text("Ok"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ]),
      );
      return;
    } else
    //Caso o valor seja 0
    if (valor == 0 || valor == 0.0) {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
            title: Text('Aviso'),
            content: Text('O campo "Valor" não pode ser "0".'),
            actions: [
              FlatButton(
                child: Text("Ok"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ]),
      );
      return;
    } else
    //Caso o valor não seja um número
    if (valor == null) {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
            title: Text('Aviso'),
            content: Text('O campo "Valor" precisa ser um número. \n \n' +
                'Ex.: 1 ou 1.1'),
            actions: [
              FlatButton(
                child: Text("Ok"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ]),
      );
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
    Navigator.popAndPushNamed(context, '/home');
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
                  "Cadastro de gastos",
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
                      decoration: InputDecoration(labelText: 'Valor'),
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
                    ),
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
                            primary:
                                Color.fromARGB(255, 72, 34, 16), // background
                            onPrimary: Colors.white, // foreground
                          ),
                          child: Text('Novo gasto'),
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
                            onPressed: _btCancelar)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
