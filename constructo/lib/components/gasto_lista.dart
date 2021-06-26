import 'package:constructo/models/gasto.dart';
import 'package:flutter/material.dart';

class GastoLista extends StatelessWidget {
  final List<Gasto> gastos;
  GastoLista(this.gastos);

  @override
  Widget build(BuildContext context) {
    double alturaTela = MediaQuery.of(context).size.height;
    return Center(
      child: Container(
        //height: 365,
        height: alturaTela * 0.5704,
        child: gastos.isEmpty
            ? Container(
                width: 210,
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
                        Expanded(
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: Text(
                                  ga.titulo,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          color: Colors.black,
                          width: 100,
                          height: 60,
                          child: Center(
                            child: Text(
                              "Valor: \n" + "R\$ " + ga.valor.toString(),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
      ),
    );
  }
}
