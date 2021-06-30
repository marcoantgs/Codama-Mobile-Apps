import 'package:constructo/components/comodo_lista.dart';
import 'package:constructo/models/comodo.dart';
import 'package:constructo/utils/OperacoesComodo.dart';
import 'package:flutter/material.dart';

class HomeConstructo extends StatefulWidget {
  @override
  _HomeConstructo createState() => _HomeConstructo();
}

class _HomeConstructo extends State<HomeConstructo> {
  ImageProvider imagem;
  List<Comodo> comodos = List<Comodo>();
  bool voltar = false;

  @override
  void initState() {
    super.initState();

    //Carregando imagem
    imagem = AssetImage('assets/images/imagem-fundo1.jpg');

    OperacoesComodo().getComodos().then((lista) {
      setState(() {
        comodos = lista;
        for (var i = 0; i < comodos.length; i++) {
          Comodo comodosCadastrados = Comodo(
              comodos[i].id,
              comodos[i].titulo,
              comodos[i].descricao,
              comodos[i].valorTotal,
              comodos[i].tipoComodo);
          _listaComodos.add(comodosCadastrados);
        }
      });
    });
  }

  final List<Comodo> _listaComodos = [];

  _trocaDeTela(int index) {
    if (index == 1) {
      setState(() {
        precacheImage(imagem, context).then((value) {
          Navigator.popAndPushNamed(context, '/adicionarComodo');
        });
      });
    } else if (index == 2) {
      setState(() {
        Navigator.popAndPushNamed(context, '/sobre');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return voltar;
      },
      child: Scaffold(
        body: Column(
          children: <Widget>[
            Container(
              color: Color.fromARGB(255, 72, 34, 16),
              height: 130,
              width: double.infinity,
              child: Center(
                child: Text(
                  "Seja bem-vindo(a)!",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                  ),
                ),
              ),
            ),
            Expanded(
              child: ComodoLista(_listaComodos),
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Color.fromARGB(255, 72, 34, 16),
          iconSize: 40,
          selectedFontSize: 15,
          unselectedFontSize: 15,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: 'Home',
              tooltip: 'Tela principal',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add_box_outlined),
              label: 'Cômodo',
              tooltip: 'Adicionar cômodo',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.info_outline),
              label: 'Sobre',
              tooltip: 'Tela sobre o Aplicativo',
            ),
          ],
          onTap: (index) {
            _trocaDeTela(index);
          },
        ),
      ),
    );
  }
}
