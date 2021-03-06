import 'package:flutter/material.dart';

class Sobre extends StatefulWidget {
  @override
  _SobreState createState() => _SobreState();
}

class _SobreState extends State<Sobre> {
  ImageProvider imagem;
  bool voltar = false;

  @override
  void initState() {
    super.initState();
    //Carregando imagem ao iniciar a tela sobre
    imagem = AssetImage('assets/images/imagem-fundo1.jpg');
  }

  _trocaDeTela(int index) {
    if (index == 0) {
      setState(() {
        Navigator.popAndPushNamed(context, '/home');
      });
    } else if (index == 1) {
      setState(() {
        precacheImage(imagem, context).then((value) {
          Navigator.popAndPushNamed(context, '/adicionarComodo');
        });
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
                      "A fun????o principal da aplica????o ?? auxiliar na organiza????o do que est?? sendo realizado em cada c??modo de sua constru????o e efetuar a contabiliza????o das despesas ao longo do tempo.\n\n"
                      "A aplica????o permite o cadastro dos c??modos com t??tulo e descri????o. Cada c??modo adicionado tem sua p??gina contendo as informa????es e a lista de itens, onde o voc?? poder?? organizar todos os servi??os realizados durante a constru????o juntamente com os custos.\n\n"
                      "Esses registros ser??o armazenados e ficar??o dispon??veis para consulta e edi????o quando desejar. Na p??gina de cada c??modo voc?? ter?? a op????o para gerar um relat??rio em PDF contendo a lista detalhada de itens do c??modo atual.\n\n"
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
              label: 'C??modo',
              tooltip: 'Adicionar c??modo',
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
