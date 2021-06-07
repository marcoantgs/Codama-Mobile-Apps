import 'package:flutter/material.dart';

class ComodoForm extends StatefulWidget {
  final void Function(String, String) onSubmit;
  ComodoForm(this.onSubmit);

  @override
  _ComodoFormState createState() => _ComodoFormState();
}

class _ComodoFormState extends State<ComodoForm> {
  final tituloController = TextEditingController();

  final descricaoController = TextEditingController();

  _submitForm() {
    final titulo = tituloController.text;
    final descricao = descricaoController.text;
    //Pegando os dois valores
    if (titulo.isEmpty) {
      return;
      //Caso o titulo esteja vazio

    }
    widget.onSubmit(titulo, descricao);
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
            // ignore: deprecated_member_use
            FlatButton(child: Text('Novo comômdo'), onPressed: _submitForm)
          ],
        ),
      ),
    );
  }
}
