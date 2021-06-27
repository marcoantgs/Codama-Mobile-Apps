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

  @override
  void initState() {
    super.initState();

    //Carregando imagem ao iniciar primeira tela
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

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    precacheImage(imagem, context);
  }

  final List<Comodo> _listaComodos = [];

  _trocaDeTela(int index) {
    if (index == 1) {
      setState(() {
        Navigator.popAndPushNamed(context, '/adicionarComodo');
      });
    } else if (index == 2) {
      setState(() {
        Navigator.popAndPushNamed(context, '/sobre');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
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
            ComodoLista(_listaComodos),
          ],
        ),
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
              icon: Icon(Icons.home_outlined), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.add_box_outlined), label: 'Cômodo'),
          BottomNavigationBarItem(
              icon: Icon(Icons.info_outline), label: 'Sobre'),
        ],
        onTap: (index) {
          _trocaDeTela(index);
        },
      ),
    );
  }
}
