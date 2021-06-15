import 'package:constructo/components/comodo_cadastro.dart';
import 'package:constructo/components/comodo_lista.dart';
import 'package:constructo/components/sobre.dart';
import 'package:constructo/models/gastoComodo.dart';
import 'package:constructo/utils/DatabaseListaGasto.dart';
import 'package:flutter/material.dart';

import 'gastoComodo_lista.dart';

class TelaComodo extends StatefulWidget {
  @override
  _TelaComodo createState() => _TelaComodo();
}

class _TelaComodo extends State<TelaComodo> {
  List<GastoComodo> gastos = List<GastoComodo>();

  @override
  void initState() {
    super.initState();

    DataBaseListaGasto().getGasto().then((lista) {
      setState(() {
        gastos = lista;
        for (var i = 0; i < gastos.length; i++) {
            GastoComodo gastosCadastrados = GastoComodo(
              gastos[i].id,
              gastos[i].titulo,
              gastos[i].valor,
              );
          _listaGasto.add(gastosCadastrados);
        }
      });
    });
  }

  final List<GastoComodo> _listaGasto = [];

  _trocaDeTela(int index) {
    if (index == 1) {
      setState(() {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => CadastroComodo()));
      });
    } else if (index == 2) {
      setState(() {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Sobre()));
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
              )),
            ),
            //Image.asset('assets/images/logo2.png'),
            GastoComodoLista(_listaGasto ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Color.fromARGB(255, 72, 34, 16),
        iconSize: 40,
        selectedFontSize: 20,
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
