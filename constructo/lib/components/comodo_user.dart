import 'dart:math';

import 'package:flutter/material.dart';
import 'comodos_lista.dart';
import 'comodo_form.dart';
import '../models/comodo.dart';

class  ComodosUser extends StatefulWidget {
 

  @override
  ComodosUserState createState() => ComodosUserState();
}

class ComodosUserState extends State<ComodosUser> {

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
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ComodoLista(_listaComodos),
        ComodoForm(_addComodo)//Passando para o form 
      ],
    );
  }
}