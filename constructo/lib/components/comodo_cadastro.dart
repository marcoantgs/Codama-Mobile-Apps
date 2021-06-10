import 'package:constructo/components/home.dart';
import 'package:constructo/models/comodo.dart';
import 'package:constructo/utils/DatabaseComodo.dart';
import 'package:flutter/material.dart';

class CadastroComodo extends StatefulWidget {
  @override
  _CadastroComodoState createState() => _CadastroComodoState();
}

class _CadastroComodoState extends State<CadastroComodo> {
  List<Comodo> comodos = List<Comodo>();

  final tituloController = TextEditingController();
  final descricaoController = TextEditingController();
  String tipoComodo = 'Área de Serviços';

  @override
  void initState() {
    super.initState();

    DataBaseComodo().getComodo().then((lista) {
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
    final titulo = tituloController.text;
    final descricao = descricaoController.text;
    final tipoComodoText = Text(tipoComodo);

    //Caso o titulo esteja vazio
    if (titulo.isEmpty) {
      return;
    }

    //Atribuindo valores e cadastrando no banco de dados
    final novoComodo =
        Comodo(gerarIndex(), titulo, descricao, 0, tipoComodoText.data);
    DataBaseComodo().criar(novoComodo);

    //Chamando a outra tela
    setState(() {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomeConstructo()));
    });
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
                value: tipoComodo,
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
                    tipoComodo = newValue;
                  });
                },
                items: <String>[
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
            FlatButton(child: Text('Novo cômodo'), onPressed: _btCadastrar)
          ],
        ),
      ),
    );
  }
}
