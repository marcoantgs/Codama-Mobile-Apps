import 'package:flutter/material.dart';

class ComodoForm extends StatelessWidget {
  final tituloController = TextEditingController();
  final descricaoController = TextEditingController();
     
  final void Function(String, String) onSubmit;
  ComodoForm(this.onSubmit);

  _submitForm(){
    final titulo = tituloController.text;
    final descricao = descricaoController.text;
    //Pegando os dois valores
    if(titulo.isEmpty){
      return;
      //Caso o titulo esteja vazio
      
    }
    onSubmit(titulo,descricao);
  }


  @override
  Widget build(BuildContext context) {
   
    return  Card(
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: <Widget>[
                    TextField(
                      controller: tituloController,
                      onSubmitted: (_)=>onSubmit,
                      decoration: InputDecoration(
                        labelText:'Título'
                      ),
                    ),
                    TextField(
                      controller: descricaoController,
                      onSubmitted: (_)=>onSubmit,
                      decoration: InputDecoration(
                        labelText:'Descrição'
                      )
                    ),
                    // ignore: deprecated_member_use
                    FlatButton(
                      child: Text('Novo comômdo'),
                      onPressed: _submitForm
                    )
                  ],
                ),
              ),

    );
  }
}