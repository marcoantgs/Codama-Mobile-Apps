import 'package:constructo/models/comodo.dart';
import 'package:constructo/utils/OperacoesComodo.dart';
import 'package:flutter/material.dart';

class CadastroComodo extends StatefulWidget {
  @override
  _CadastroComodoState createState() => _CadastroComodoState();
}

class _CadastroComodoState extends State<CadastroComodo> {
  List<Comodo> comodos = List<Comodo>();

  final tituloController = TextEditingController();
  final descricaoController = TextEditingController();
  String valorTipoComodo = 'Selecione';

  @override
  void initState() {
    super.initState();

    OperacoesComodo().getComodos().then((lista) {
      comodos = lista;
    });
  }

  int gerarIndex() {
    if (comodos.isNotEmpty) {
      return comodos.last.id + 1;
    }
    return 1;
  }

  _btCadastrar() {
    //Pegando os valores
    final id = gerarIndex();
    final titulo = tituloController.text;
    final descricao = descricaoController.text;
    final tipoComodo = Text(valorTipoComodo).data;
    final valorTotal = 0.0;

    //Caso o titulo esteja vazio
    if (titulo.isEmpty) {
      return;
    } else
    //Caso não tenha selecioando o tipo
    if (tipoComodo.compareTo('Selecione') == 0) {
      return;
    }

    //Atribuindo valores e cadastrando no banco de dados
    final novoComodo = Comodo(id, titulo, descricao, valorTotal, tipoComodo);

    OperacoesComodo().inserir(novoComodo);

    //Chamando a outra tela
    setState(() {
      Navigator.popAndPushNamed(context, '/comodo', arguments: novoComodo);
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
                controller: descricaoController,
                decoration: InputDecoration(labelText: 'Descrição')),
            DropdownButton<String>(
                value: valorTipoComodo,
                icon: const Icon(Icons.arrow_downward),
                iconSize: 24,
                elevation: 16,
                style: const TextStyle(color: Color.fromARGB(255, 72, 34, 16)),
                underline: Container(
                  height: 2,
                  color: Color.fromARGB(255, 72, 34, 16),
                ),
                onChanged: (String newValue) {
                  setState(() {
                    valorTipoComodo = newValue;
                  });
                },
                items: <String>[
                  'Selecione',
                  'Área de Serviços',
                  'Banheiro',
                  'Cozinha',
                  'Escritório',
                  'Oficina',
                  'Quarto',
                  'Sala'
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList()),
            FlatButton(child: Text('Novo cômodo'), onPressed: _btCadastrar),
            FlatButton(child: Text('Cancelar'), onPressed: _btCancelar)
          ],
        ),
      ),
    );
  }
}
