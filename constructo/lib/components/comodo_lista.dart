import 'package:constructo/models/comodo.dart';
import 'package:constructo/utils/OperacoesComodo.dart';
import 'package:flutter/material.dart';

class ComodoLista extends StatefulWidget {
  final List<Comodo> comodos;
  ComodoLista(this.comodos);

  @override
  _ComodoLista createState() => _ComodoLista();
}

class _ComodoLista extends State<ComodoLista> {
  @override
  Widget build(BuildContext context) {
    double alturaTela = MediaQuery.of(context).size.height;
    final comodos = widget.comodos;
    return Center(
      child: Container(
        //height: 435,
        height: alturaTela * 0.6797,
        child: comodos.isEmpty
            ? Container(
                width: 210,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/logo2.png'),
                  ),
                ),
              )
            : ListView.builder(
                itemCount: comodos.length,
                itemBuilder: (ctx, index) {
                  final co = comodos[index];
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        Navigator.popAndPushNamed(context, '/comodo',
                            arguments: comodos[index]);
                      });
                    },
                    child: Card(
                      child: Row(
                        children: <Widget>[
                          Container(
                            color: Colors.black,
                            width: 90,
                            height: 60,
                            child: Center(
                              child: Text(
                                "Total gasto: \n" +
                                    "R\$ " +
                                    co.valorTotal.toString(),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: <Widget>[
                                Container(
                                  alignment: Alignment.topCenter,
                                  child: Text(
                                    co.titulo,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  child: Text(
                                    co.descricao,
                                    style: TextStyle(
                                        color: Colors.black54,
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.bottomCenter,
                                  child: Text(
                                    co.tipoComodo,
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            children: [
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
                                          context, '/adicionarComodo',
                                          arguments: comodos[index]);
                                    });
                                  },
                                  child: Icon(
                                    Icons.edit,
                                    color: Colors.black,
                                    size: 26.0,
                                  ),
                                ),
                              ),
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
                                            'Deseja excluir o cômodo: ${comodos[index].titulo} ?'),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () {
                                              setState(() {
                                                OperacoesComodo()
                                                    .deletar(comodos[index]);
                                                comodos.removeAt(index);
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
