import 'package:flutter/material.dart';

class Sobre extends StatefulWidget {
  @override
  _SobreState createState() => _SobreState();
}

class _SobreState extends State<Sobre> {
  _trocaDeTela(int index) {
    if (index == 0) {
      setState(() {
        Navigator.popAndPushNamed(context, '/home');
      });
    } else if (index == 1) {
      setState(() {
        Navigator.popAndPushNamed(context, '/adicionarComodo');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            color: Color.fromARGB(255, 72, 34, 16),
            height: 130,
            width: double.infinity,
            child: Center(
              child: Text(
                "Sobre o aplicativo",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                ),
              ),
            ),
          ),
          Container(
            child: Expanded(
              child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(15.0),
                  margin: const EdgeInsets.all(15.0),
                  decoration:
                      BoxDecoration(color: Colors.black.withOpacity(0.7)),
                  child: Text(
                    "O aplicativo Constructo foi desenvolvido pela equipe Codama, composta pelos alunos:\n\n"
                    "Acley Filho\n"
                    "Arthur Ribeiro\n"
                    "Lucas de Sena\n"
                    "Marco Antonio Silva\n\n"
                    "A função principal da aplicação é auxiliar na organização do que está sendo realizado em cada cômodo de sua construção e efetuar a contabilização das despesas ao longo do tempo.\n\n"
                    "A aplicação permite o cadastro dos cômodos com título e descrição. Cada cômodo adicionado tem sua página contendo as informações e a lista de itens, onde o você poderá organizar todos os serviços realizados durante a construção juntamente com os custos.\n\n"
                    "Esses registros serão armazenados e ficarão disponíveis para consulta e edição quando desejar. Na página de cada cômodo você terá a opção para gerar um relatório em PDF contendo a lista detalhada de itens do cômodo atual.\n\n"
                    "Semestre 2021/1",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
            ),
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
    );
  }
}
