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
    return Card(
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
            FlatButton(child: Text('Novo Gasto'), onPressed: _btCadastrar),
            FlatButton(child: Text('Cancelar'), onPressed: _btCancelar)
          ],
        ),
      ),
    );
  }
}
