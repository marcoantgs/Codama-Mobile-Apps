import 'package:constructo/components/comodo_cadastro.dart';
import 'package:constructo/components/sobre.dart';
import 'package:flutter/material.dart';

class TelaComodo extends StatefulWidget {
  @override
  _TelaComodoState createState() => _TelaComodoState();
}

class _TelaComodoState extends State<TelaComodo> {
  _trocaDeTela(int index) {
    if (index == 0) {
      setState(() {
        Navigator.popAndPushNamed(context, '/home');
      });
    } else if (index == 1) {
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
                "bla bla bla",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                ),
              )),
            ),
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
