import 'package:constructo/models/gastoComodo.dart';
import 'package:constructo/utils/DatabaseListaGasto.dart';
import 'package:flutter/material.dart';

class CadastroGasto extends StatefulWidget {
  @override
  _CadastroGastoState createState() => _CadastroGastoState();
}

class _CadastroGastoState extends State<CadastroGasto> {
  List<GastoComodo> gastos = List<GastoComodo>();

  final tituloController = TextEditingController();
  final valorController = TextEditingController();

  @override
  void initState() {
    super.initState();

    DataBaseListaGasto().getGasto().then((lista) {
      gastos = lista;
    });
  }

  int gerarIndex() {
    if (gastos.isNotEmpty) {
      return gastos.last.id + 1;
    }
    return 1;
  }

  _btCadastrar() {
    //Pegando os valores
    final titulo = tituloController.text;
    final valor = double.tryParse(valorController.text) ?? 0.0;

    //Caso o titulo esteja vazio
    if (titulo.isEmpty) {
      return;
    }

    //Atribuindo valores e cadastrando no banco de dados
    final novoGasto =
        GastoComodo(gerarIndex(), titulo, valor);
    DataBaseListaGasto().inserir(novoGasto);

    //Chamando a outra tela
    setState(() {
      Navigator.popAndPushNamed(context, '/gasto');
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
                decoration: InputDecoration(labelText: 'valor')
            ),
            FlatButton(child: Text('Novo Gasto'), onPressed: _btCadastrar),
            FlatButton(child: Text('Cancelar'), onPressed: _btCancelar)
          ],
        ),
      ),
    );
  }
}
