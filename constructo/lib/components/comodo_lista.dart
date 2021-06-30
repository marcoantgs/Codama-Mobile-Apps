import 'package:auto_size_text/auto_size_text.dart';
import 'package:constructo/models/comodo.dart';
import 'package:constructo/utils/OperacoesComodo.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class ComodoLista extends StatefulWidget {
  final List<Comodo> comodos;
  ComodoLista(this.comodos);
  @override
  _ComodoLista createState() => _ComodoLista();
}

class _ComodoLista extends State<ComodoLista> {
  ImageProvider imagem;

  void initState() {
    super.initState();
    //Carregando imagem
    imagem = AssetImage('assets/images/imagem-fundo1.jpg');
  }

  IconData retornarIcone(tipoIcone) {
    switch (tipoIcone) {
      case 'Área de Serviços':
        return MdiIcons.washingMachine;
      case 'Banheiro':
        return MdiIcons.shower;
      case 'Cozinha':
        return MdiIcons.fridgeOutline;
      case 'Escritório':
        return MdiIcons.desk;
      case 'Oficina':
        return MdiIcons.hammerWrench;
      case 'Quarto':
        return MdiIcons.hanger;
      case 'Sala':
        return MdiIcons.sofaSingleOutline;
      default:
        return MdiIcons.imageOff;
    }
  }

  @override
  Widget build(BuildContext context) {
    final comodos = widget.comodos;
    return Center(
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
                    Navigator.popAndPushNamed(context, '/comodo',
                        arguments: comodos[index]);
                  },
                  child: Card(
                    child: Row(
                      children: <Widget>[
                        Container(
                          color: Colors.black,
                          width: 110,
                          height: 60,
                          child: Column(
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    child: Icon(
                                      retornarIcone(co.tipoComodo),
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.all(2),
                                    padding: EdgeInsets.only(top: 5, bottom: 3),
                                    child: Text(
                                      co.tipoComodo,
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 11),
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                child: Text(
                                  "Total gasto: \n" + "R\$ ${co.valorTotal}",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 12),
                                ),
                              ),
                            ],
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
                                    precacheImage(imagem, context)
                                        .then((value) {
                                      Navigator.popAndPushNamed(
                                          context, '/adicionarComodo',
                                          arguments: comodos[index]);
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
                                          'Deseja excluir o cômodo: ${comodos[index].titulo}?'),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () {
                                            setState(() {
                                              OperacoesComodo()
                                                  .deletar(comodos[index]);
                                              comodos.removeAt(index);
                                            });
                                            Navigator.pop(context, 'Confirmar');
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
    );
  }
}
