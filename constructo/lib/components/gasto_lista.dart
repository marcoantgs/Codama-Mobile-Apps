import 'package:auto_size_text/auto_size_text.dart';
import 'package:constructo/models/argumentos.dart';
import 'package:constructo/models/comodo.dart';
import 'package:constructo/models/gasto.dart';
import 'package:constructo/utils/OperacoesComodo.dart';
import 'package:constructo/utils/OperacoesGasto.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class GastoLista extends StatefulWidget {
  final List<Gasto> gastos;
  final Comodo comodo;
  GastoLista(this.gastos, this.comodo);
  @override
  _GastoLista createState() => _GastoLista();
}

class _GastoLista extends State<GastoLista> {
  ImageProvider imagem;

  @override
  void initState() {
    super.initState();
    //Carregando imagem
    imagem = AssetImage('assets/images/imagem-fundo2.jpg');
  }

  _valorTotal() {
    double valorTotal = 0.0;
    String mensagem = '';

    if (widget.gastos.isEmpty) {
      mensagem = 'Ainda não há nenhum gasto!';

      widget.comodo.valorTotal = valorTotal;
      OperacoesComodo().atualizar(widget.comodo);

      return mensagem;
    } else {
      for (var i = 0; i < widget.gastos.length; i++) {
        valorTotal += widget.gastos[i].valor;
      }
      widget.comodo.valorTotal = valorTotal;
      OperacoesComodo().atualizar(widget.comodo);

      return valorTotal;
    }
  }

  @override
  Widget build(BuildContext context) {
    final gastos = widget.gastos;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        gastos.isEmpty
            ? Expanded(
                child: Container(
                  width: 210,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/logo2.png'),
                    ),
                  ),
                ),
              )
            : Expanded(
                child: ListView.builder(
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
                                      margin: EdgeInsets.only(right: 4),
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
                                                  'Deseja excluir o gasto: ${gastos[index].titulo}?'),
                                              actions: <Widget>[
                                                TextButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      OperacoesGasto()
                                                          .deletarUm(
                                                              gastos[index]);
                                                      gastos.removeAt(index);
                                                    });
                                                    Navigator.pop(
                                                        context, 'Confirmar');
                                                  },
                                                  child:
                                                      const Text('Confirmar'),
                                                ),
                                                TextButton(
                                                  onPressed: () =>
                                                      Navigator.pop(
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
                                      margin: EdgeInsets.only(right: 4),
                                      decoration: BoxDecoration(
                                        color: Colors.grey[400],
                                        border: Border.all(color: Colors.black),
                                      ),
                                      child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            precacheImage(imagem, context)
                                                .then((value) {
                                              Navigator.popAndPushNamed(
                                                  context, '/adicionarGasto',
                                                  arguments: Argumentos(
                                                      widget.comodo,
                                                      gastos[index]));
                                            });
                                          });
                                        },
                                        child: Icon(
                                          Icons.edit,
                                          color: Colors.black,
                                          size: 26.0,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        alignment: Alignment.center,
                                        child: Text(
                                          ga.titulo,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Container(
                            color: Colors.black,
                            width: 110,
                            height: 60,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  "Valor:",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                                AutoSizeText(
                                  "R\$ ${ga.valor}",
                                  maxLines: 2,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
        Container(
          padding: EdgeInsets.all(8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              gastos.isEmpty
                  ? Container(
                      alignment: Alignment.center,
                      height: 56,
                      child: Text(
                        _valorTotal(),
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  : Container(
                      padding: EdgeInsets.only(right: 6),
                      margin: EdgeInsets.only(right: 4),
                      alignment: Alignment.center,
                      height: 56,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.black.withOpacity(0.7),
                      ),
                      child: Row(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(right: 1),
                            child: Icon(
                              MdiIcons.calculator,
                              color: Colors.white,
                              size: 40.0,
                            ),
                          ),
                          AutoSizeText(
                            "Valor total = R\$ ${_valorTotal()}",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
              Container(
                child: FloatingActionButton(
                  tooltip: 'Adicionar gasto',
                  child: Icon(Icons.add),
                  backgroundColor: Color.fromARGB(255, 72, 34, 16),
                  foregroundColor: Colors.white,
                  onPressed: () {
                    setState(() {
                      precacheImage(imagem, context).then((value) {
                        Navigator.popAndPushNamed(context, '/adicionarGasto',
                            arguments: Argumentos(widget.comodo, null));
                      });
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
