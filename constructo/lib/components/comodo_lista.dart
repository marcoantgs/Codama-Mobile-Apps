import 'package:constructo/components/comodo_cadastro.dart';
import 'package:constructo/components/tela_comodo.dart';
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
    final comodos = widget.comodos;
    return Center(
      child: Container(
        height: 435,
        child: comodos.isEmpty
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
                itemCount: comodos.length,
                itemBuilder: (ctx, index) {
                  final co = comodos[index];
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    TelaComodo(comodos[index])));
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
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  child: Text(
                                    co.descricao,
                                    style: TextStyle(
                                        color: Colors.black54,
                                        fontSize: 12,
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
                          Container(
                            child: Row(
                              children: <Widget>[
                                Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      CadastroComodo(
                                                          comodo:
                                                              comodos[index])));
                                        });
                                      },
                                      child: Icon(
                                        Icons.edit,
                                        color: Colors.black,
                                        size: 26.0,
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        showDialog<String>(
                                          context: context,
                                          builder: (BuildContext context) =>
                                              AlertDialog(
                                            title: const Text('Confirmação'),
                                            content: Text(
                                                'Deseja mesmo excluir o cômodo "${comodos[index].titulo}" ?'),
                                            actions: <Widget>[
                                              TextButton(
                                                onPressed: () {
                                                  setState(() {
                                                    OperacoesComodo().deletar(
                                                        comodos[index]);
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
                                  ],
                                ),
                              ],
                            ),
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
