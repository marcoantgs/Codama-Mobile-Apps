import 'package:constructo/components/sobre.dart';
import 'package:constructo/models/comodo.dart';
import 'package:constructo/utils/OperacoesComodo.dart';
import 'package:flutter/material.dart';

class CadastroComodo extends StatefulWidget {
  final Comodo comodo;

  CadastroComodo({this.comodo});

  @override
  _CadastroComodoState createState() => _CadastroComodoState();
}

class _CadastroComodoState extends State<CadastroComodo> {
  bool editando;
  List<Comodo> comodos = List<Comodo>();

  final tituloController = TextEditingController();
  final descricaoController = TextEditingController();
  String valorTipoComodo = 'Selecione';

  @override
  void initState() {
    super.initState();

    OperacoesComodo().getComodos().then((lista) {
      comodos = lista;
    });

    final comodo = widget.comodo;

    if (comodo == null) {
      editando = false;
    } else {
      editando = true;
      tituloController.text = comodo.titulo;
      descricaoController.text = comodo.descricao;
      valorTipoComodo = comodo.tipoComodo;
    }
  }

  _trocaDeTela(int index) {
    if (index == 0) {
      setState(() {
        Navigator.popAndPushNamed(context, '/home');
      });
    } else if (index == 2) {
      setState(() {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Sobre()));
      });
    }
  }

  int gerarIndex() {
    if (comodos.isNotEmpty) {
      return comodos.last.id + 1;
    }
    return 1;
  }

  _btCadastrar() {
    //Pegando os valores
    int id;
    if (editando == true) {
      id = widget.comodo.id;
    } else {
      id = gerarIndex();
    }

    final titulo = tituloController.text;
    final descricao = descricaoController.text;
    final tipoComodo = Text(valorTipoComodo).data;
    final valorTotal = 0.0;

    //Caso o titulo esteja vazio
    if (titulo.isEmpty) {
      return;
    } else
    //Caso não tenha selecioando o tipo
    if (tipoComodo.compareTo('Selecione') == 0) {
      return;
    }

    //Atribuindo valores e cadastrando no banco de dados
    final novoComodo = Comodo(id, titulo, descricao, valorTotal, tipoComodo);
    if (editando == true) {
      OperacoesComodo().atualizar(novoComodo);
    } else {
      OperacoesComodo().inserir(novoComodo);
    }

    //Chamando a outra tela
    setState(() {
      Navigator.popAndPushNamed(context, '/comodo', arguments: novoComodo);
    });
  }

  _btCancelar() {
    Navigator.pop(context);
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
                  "Cadastrar cômodo",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                  ),
                ),
              ),
            ),
            Card(
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: <Widget>[
                    TextField(
                      controller: tituloController,
                      decoration: InputDecoration(labelText: 'Título'),
                    ),
                    TextField(
                        maxLines: 3,
                        controller: descricaoController,
                        decoration: InputDecoration(labelText: 'Descrição')),
                    Container(
                      padding: const EdgeInsets.all(10.0),
                    ),
                    DropdownButton<String>(
                        isExpanded: true,
                        value: valorTipoComodo,
                        icon: const Icon(Icons.arrow_downward),
                        iconSize: 24,
                        elevation: 16,
                        style: const TextStyle(
                            color: Color.fromARGB(255, 72, 34, 16)),
                        underline: Container(
                          height: 2,
                          color: Color.fromARGB(255, 72, 34, 16),
                        ),
                        onChanged: (String newValue) {
                          setState(() {
                            valorTipoComodo = newValue;
                          });
                        },
                        items: <String>[
                          'Selecione',
                          'Área de Serviços',
                          'Banheiro',
                          'Cozinha',
                          'Escritório',
                          'Oficina',
                          'Quarto',
                          'Sala'
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList()),
                    Container(
                      padding: const EdgeInsets.all(5.0),
                      margin: const EdgeInsets.only(top: 20.0),
                      height: 45,
                      width: 400,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Color.fromARGB(255, 72, 34, 16), // background
                          onPrimary: Colors.white, // foreground
                        ),
                        child: editando == true
                            ? Text('Salvar')
                            : Text('Cadastrar'),
                        onPressed: _btCadastrar),
                    ),
                    Container(
                      padding: const EdgeInsets.all(5.0),
                      height: 45,
                      width: 400,
                      child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.brown[50], // background
                          onPrimary: Colors.black, // foreground
                        ),
                      child: Text('Cancelar'), 
                      onPressed: _btCancelar)
                    ),
                  ],
                ),
              ),
            ),
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
