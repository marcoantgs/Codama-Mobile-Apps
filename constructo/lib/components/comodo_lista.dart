import 'package:constructo/components/tela_comodo.dart';
import 'package:constructo/models/comodo.dart';
import 'package:flutter/material.dart';

class ComodoLista extends StatefulWidget {
  final List<Comodo> comodos;
  ComodoLista(this.comodos);

  @override
  _ComodoLista createState() => _ComodoLista();
}

class _ComodoLista extends State<ComodoLista> {
  bool pressionado = false;

  @override
  Widget build(BuildContext context) {
    final comodos = widget.comodos;
    return Center(
      child: Container(
        height: 600,
        child: ListView.builder(
          itemCount: comodos.length,
          itemBuilder: (ctx, index) {
            final co = comodos[index];
            return GestureDetector(
              onTap: () {
                setState(() {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TelaComodo(comodos[index])));
                });
              },
              //Pensar em como fazer o update e o delete por esse metodo
              onLongPress: () {
                pressionado = true;
              },
              child: Card(
                child: Row(
                  children: <Widget>[
                    Container(
                      color: Colors.black,
                      width: 80,
                      height: 60,
                      child: Center(
                        child: Text(
                          co.valorTotal.toString(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                    Column(
                      children: <Widget>[
                        Container(
                          alignment: Alignment.topCenter,
                          child: Text(
                            co.titulo,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          child: Text(
                            co.descricao,
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 10,
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.bottomCenter,
                          child: Text(
                            co.tipoComodo,
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 10,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

//testes com a estrutura do widget
/*
return Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                setState(() {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              TelaComodo(comodos[index])));
                });
              },
              onLongPress: () {
                setState(() {
                  pressionado = true;
                });
              },
              onLongPressEnd: (details) {
                setState(() {
                  pressionado = false;
                });
              },
              child: Row(
                children: <Widget>[
                  Container(
                    color: Colors.black,
                    width: 80,
                    height: 60,
                    child: Center(
                      child: Text(
                        co.valorTotal.toString(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                  Column(
                    children: <Widget>[
                      Container(
                        alignment: Alignment.topCenter,
                        child: Text(
                          co.titulo,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: Text(
                          co.descricao,
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 10,
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.bottomCenter,
                        child: Text(
                          co.tipoComodo,
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Visibility(
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {},
                          child: Icon(
                            Icons.edit,
                            color: Colors.black,
                            size: 24.0,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Icon(
                            Icons.delete,
                            color: Colors.black,
                            size: 24.0,
                          ),
                        ),
                      ],
                    ),
                    visible: pressionado == true ? true : false,
                  ),
                ],
              ),
            ),
          ],
        ),
      );
*/
