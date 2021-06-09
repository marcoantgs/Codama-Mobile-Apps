import 'package:flutter/material.dart';

class ComodoForm extends StatefulWidget {
  final void Function(String, String, Text) onSubmit;
  ComodoForm(this.onSubmit);

  @override
  _ComodoFormState createState() => _ComodoFormState();
}

class _ComodoFormState extends State<ComodoForm> {
  final tituloController = TextEditingController();
  final descricaoController = TextEditingController();
  String tipoComodo = "";

  String dropdownValue = 'Área de Serviços';

  /*
  List <DropdownMenuItem<String>> listaDropComodos = [];

  void tipoComodos(){
    listaDropComodos.add(new DropdownMenuItem(child: new Text('Banheiro'), value: 'Banheiro'));
    listaDropComodos.add(new DropdownMenuItem(child: new Text('Sala'), value: 'Sala'));
    listaDropComodos.add(new DropdownMenuItem(child: new Text('Quarto'), value: 'Quarto'));


  }
  */

  _submitForm() {
    final titulo = tituloController.text;
    final descricao = descricaoController.text;
    final tipoComodoText = Text(tipoComodo);

    //Pegando os dois valores
    if (titulo.isEmpty) {
      return;
      //Caso o titulo esteja vazio

    }
    widget.onSubmit(titulo, descricao, tipoComodoText);
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
              onSubmitted: (_) => widget.onSubmit,
              decoration: InputDecoration(labelText: 'Título'),
            ),
            TextField(
                controller: descricaoController,
                onSubmitted: (_) => widget.onSubmit,
                decoration: InputDecoration(labelText: 'Descrição')),

            DropdownButton<String>(
                value: dropdownValue,
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

            FlatButton(child: Text('Novo cômodo'), onPressed: _submitForm)

            /*
            new DropdownButton<String>(
              items: <String>['A', 'B', 'C', 'D'].map((String value) {
                return new DropdownMenuItem<String>(
                  value: value,
                  child: new Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  dropdownValue = newValue!;
                });
              },
            ),
            */

            // ignore: deprecated_member_use
          ],
        ),
      ),
    );
  }
}
