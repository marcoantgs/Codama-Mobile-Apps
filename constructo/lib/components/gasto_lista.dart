import 'package:constructo/models/gasto.dart';
import 'package:flutter/material.dart';

class GastoLista extends StatelessWidget {
  final List<Gasto> gastos;
  GastoLista(this.gastos);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 385,
        child: gastos.isEmpty
            ? Container(
                padding: const EdgeInsets.all(15.0),
                margin: const EdgeInsets.all(15.0),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/logo2.png'),
                  ),
                ),
              )
            : ListView.builder(
                itemCount: gastos.length,
                itemBuilder: (ctx, index) {
                  final ga = gastos[index];
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
                              ga.valor.toString(),
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
                                ga.titulo,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  );
                },
              ),
      ),
    );
  }
}
