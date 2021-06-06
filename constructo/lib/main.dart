

import 'dart:math';

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

 Future<List<Comodo>> listaComodos = DataBaseComodo().getComodo();
  
  _LerLista(){
    
  }
  
  final _listaComodos = [
     
  ];
  _abrirModalForm( BuildContext context){
    showModalBottomSheet(
      context: context,
      builder: (_){
        return ComodoForm(_addComodo);//Adicionando transação
      }
    );
  }

   _addComodo(String titulo, String descricao){
    final novoComodo = Comodo(
      id: Random().nextInt(500),
      titulo: titulo,
      descricao: descricao,
      valorTotal: 0,

    );
    setState(() {
          _listaComodos.add(novoComodo);
          DataBaseComodo().Criar(novoComodo);
          //Adicionando na lista e mudando o visual 
    });
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Constructor')),
      ),
      body:  SingleChildScrollView(
        child: Column(
          children: <Widget>[

            Container(
              color: Colors.brown,
              height: 130,
              width: double.infinity,
              child: 
              Center(
                child: Text(
                  "Seja bem-vindo(a)!!!",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                  ),
                  )
                
              ),
              
                 
            ),
            
            ComodoLista(_listaComodos),

        
          ],
        ),
        
      ),
      floatingActionButton:FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () =>_abrirModalForm(context),
      ) ,
     
    );
  }
}
