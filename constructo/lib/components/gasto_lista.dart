import 'package:constructo/models/argumentos.dart';
import 'package:constructo/models/gasto.dart';
import 'package:constructo/utils/OperacoesGasto.dart';
import 'package:flutter/material.dart';

class GastoLista extends StatefulWidget {
  final List<Gasto> gastos;
  final comodo;
  GastoLista(this.gastos, this.comodo);
  @override
  _GastoLista createState() => _GastoLista();
}

class _GastoLista extends State<GastoLista> {
  @override
  Widget build(BuildContext context) {
    double alturaTela = MediaQuery.of(context).size.height;
    final gastos = widget.gastos;
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
                              Row(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(right: 2),
                                    decoration: BoxDecoration(
                                      color: Colors.red[400],
                                      border: Border.all(color: Colors.black),
                                    ),
                                    child: GestureDetector(
                                      onTap: () {
                                        showDialog<String>(
                                          context: context,
                                          builder: (BuildContext context) =>
                                              AlertDialog(
                                            title: const Text('Confirmação'),
                                            content: Text(
                                                'Deseja excluir o gasto: ${gastos[index].titulo} ?'),
                                            actions: <Widget>[
                                              TextButton(
                                                onPressed: () {
                                                  setState(() {
                                                    OperacoesGasto().deletar(
                                                        gastos[index].comodo);
                                                    gastos.removeAt(index);
                                                  });
                                                  Navigator.pop(
                                                      context, 'Confirmar');
                                                },
                                                child: const Text('Confirmar'),
                                              ),
                                              TextButton(
                                                onPressed: () => Navigator.pop(
                                                    context, 'Cancelar'),
                                                child: const Text('Cancelar'),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                      child: Icon(
                                        Icons.delete,
                                        color: Colors.black,
                                        size: 26.0,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(right: 2),
                                    decoration: BoxDecoration(
                                      color: Colors.grey[400],
                                      border: Border.all(color: Colors.black),
                                    ),
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          Navigator.popAndPushNamed(
                                              context, '/adicionarGasto',
                                              arguments: Argumentos(
                                                  widget.comodo,
                                                  gastos[index]));
                                        });
                                      },
                                      child: Icon(
                                        Icons.edit,
                                        color: Colors.black,
                                        size: 26.0,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
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
