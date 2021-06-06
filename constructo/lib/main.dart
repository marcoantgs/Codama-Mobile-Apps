

import 'dart:math';

import 'package:constructo/components/comodo_form.dart';
import 'package:constructo/utils/Database.dart';
import 'package:flutter/material.dart';
import 'components/comodos_lista.dart';
import 'components/comodo_form.dart';
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

  Map<String,String> novoComodo = {};

  Future _Comodofuture;
  
  @override
    void initState() {
      // TODO: implement initState
      super.initState();
      _Comodofuture = getComodo();
    }

    getComodo() async {
      final _comodoData = await DBProvider.db.getComodo();
      return _comodoData;
    }

  final _listaComodos = [
      Comodo(
        id:'t1',
        titulo: 'quarto Arthur',
        descricao: 'quarto novo, reformando parede',
        valorTotal: 25.400
      ),
      Comodo(
        id:'t2',
        titulo: 'quarto novo',
        descricao: 'quarto novo, reformando parede',
        valorTotal: 25.200
      ),
      Comodo(
        id:'t1',
        titulo: 'quarto Arthur',
        descricao: 'quarto novo, reformando parede',
        valorTotal: 25.400
      ),
      Comodo(
        id:'t2',
        titulo: 'quarto novo',
        descricao: 'quarto novo, reformando parede',
        valorTotal: 25.200
      ),Comodo(
        id:'t1',
        titulo: 'quarto Arthur',
        descricao: 'quarto novo, reformando parede',
        valorTotal: 25.400
      ),
      Comodo(
        id:'t2',
        titulo: 'quarto novo',
        descricao: 'quarto novo, reformando parede',
        valorTotal: 25.200
      ),Comodo(
        id:'t1',
        titulo: 'quarto Arthur',
        descricao: 'quarto novo, reformando parede',
        valorTotal: 25.400
      ),
      Comodo(
        id:'t2',
        titulo: 'quarto novo',
        descricao: 'quarto novo, reformando parede',
        valorTotal: 25.200
      ),
      
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
      id: Random().nextDouble().toString(),
      titulo: titulo,
      descricao: descricao,
      valorTotal: 0,

    );
    setState(() {
          _listaComodos.add(novoComodo);
          //Adicionando na lista e mudando o visual 
    });
    var novoDBComodo = Comodo(id: Random().nextDouble().toString(), titulo: titulo, descricao: descricao);
    DBProvider.db.novoComodo(novoDBComodo);

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Constructor')),
      ),
      body: 
       /*SingleChildScrollView(
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
            //ComodoLista(_listaComodos),
        
          ],
        ),
        
      ),
      floatingActionButton:FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () =>_abrirModalForm(context),
      ) ,
     */
    );
  }
}
