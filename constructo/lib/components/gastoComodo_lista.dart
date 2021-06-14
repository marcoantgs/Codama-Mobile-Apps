import 'package:constructo/models/comodo.dart';
import 'package:flutter/material.dart';
import '../models/comodo.dart';

class ComodoLista extends StatelessWidget {
  final List<Comodo> comodos;
  ComodoLista(this.comodos);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 600,
        child: ListView.builder(
          itemCount: comodos.length,
          itemBuilder: (ctx, index) {
            final co = comodos[index];
            return Card(
                child: Row(
              children: <Widget>[
                Container(
                  color: Colors.black,
                  width: 80,
                  height: 60,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20, left: 25),
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
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Text(
                        co.titulo,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 25, bottom: 12),
                      child: Text(
                        co.descricao,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 10,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 25, bottom: 12),
                      child: Text(
                        co.tipoComodo,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ));
          },
        ),
      ),
    );
  }
}
