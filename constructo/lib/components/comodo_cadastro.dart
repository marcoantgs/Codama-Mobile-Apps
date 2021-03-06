import 'package:auto_size_text/auto_size_text.dart';
import 'package:constructo/models/comodo.dart';
import 'package:constructo/utils/OperacoesComodo.dart';
import 'package:flutter/material.dart';

class CadastroComodo extends StatefulWidget {
  final Comodo comodo;
  CadastroComodo(this.comodo);

  @override
  _CadastroComodoState createState() => _CadastroComodoState();
}

class _CadastroComodoState extends State<CadastroComodo> {
  bool editando;
  bool voltar = false;
  List<Comodo> comodos = List<Comodo>();

  final tituloController = TextEditingController();
  final descricaoController = TextEditingController();
  String valorTipoComodo;

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
    var tipoComodo;

    if (valorTipoComodo == null) {
      tipoComodo = "";
    } else {
      tipoComodo = Text(valorTipoComodo).data;
    }

    final valorTotal = 0.0;

    //Tratando campos
    //Caso o titulo esteja vazio
    if (titulo.isEmpty) {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
            title: Text('Aviso'),
            content: Text('O campo "Titulo" não pode estar vazio.'),
            actions: [
              FlatButton(
                child: Text("Ok"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ]),
      );
      return;
    } else
    //Caso não tenha selecioando o tipo
    if (tipoComodo == "") {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
            title: Text('Aviso'),
            content: Text('Selecione o tipo do cômodo.'),
            actions: [
              FlatButton(
                child: Text("Ok"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ]),
      );
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
    Navigator.popAndPushNamed(context, '/home');
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return voltar;
      },
      child: Scaffold(
        body: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/imagem-fundo1.jpg'),
                fit: BoxFit.cover),
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 30.0, right: 30.0),
                  child: Container(
                    height: 500,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          height: 60,
                          child: Center(
                            child: AutoSizeText(
                              "Cadastro de cômodos",
                              maxFontSize: 96,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                              ),
                            ),
                          ),
                        ),
                        Column(
                          children: <Widget>[
                            Container(
                              child: Text(
                                'Título:',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                              alignment: Alignment.bottomLeft,
                            ),
                            TextField(
                              textAlign: TextAlign.center,
                              maxLength: 20,
                              controller: tituloController,
                              decoration: InputDecoration(
                                counterText: '',
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 15.0, horizontal: 20.0),
                                fillColor: Colors.white,
                                filled: true,
                                border: OutlineInputBorder(),
                                hintText: 'Insira o título do cômodo',
                                hintStyle: TextStyle(fontSize: 15),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Container(
                              child: Text(
                                'Descrição:',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                              alignment: Alignment.bottomLeft,
                            ),
                            TextField(
                              textAlign: TextAlign.center,
                              maxLength: 22,
                              controller: descricaoController,
                              decoration: InputDecoration(
                                counterText: '',
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 15.0, horizontal: 20.0),
                                fillColor: Colors.white,
                                filled: true,
                                border: OutlineInputBorder(),
                                hintText: 'Insira a descrição do cômodo',
                                hintStyle: TextStyle(fontSize: 15),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Container(
                              child: Text(
                                'Tipo:',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                              alignment: Alignment.bottomLeft,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5)),
                              child: DropdownButton<String>(
                                  hint: Center(
                                    child: Text('Escolha o tipo do cômodo'),
                                  ),
                                  isExpanded: true,
                                  value: valorTipoComodo,
                                  icon: Icon(Icons.arrow_drop_down),
                                  iconSize: 20,
                                  underline: SizedBox(),
                                  style: const TextStyle(
                                    color: Colors.black,
                                  ),
                                  onChanged: (String newValue) {
                                    setState(() {
                                      valorTipoComodo = newValue;
                                    });
                                  },
                                  items: <String>[
                                    'Área de Serviços',
                                    'Banheiro',
                                    'Cozinha',
                                    'Escritório',
                                    'Oficina',
                                    'Quarto',
                                    'Sala'
                                  ].map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Center(
                                        child: Text(value),
                                      ),
                                    );
                                  }).toList()),
                            ),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Container(
                              padding: const EdgeInsets.all(5.0),
                              height: 55,
                              width: 400,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: Color.fromARGB(
                                        255, 72, 34, 16), // background
                                    onPrimary: Colors.white, // foreground
                                  ),
                                  child: editando == true
                                      ? Text(
                                          'Salvar cômodo',
                                          style: TextStyle(
                                            fontSize: 17,
                                          ),
                                        )
                                      : Text(
                                          'Adicionar cômodo',
                                          style: TextStyle(
                                            fontSize: 17,
                                          ),
                                        ),
                                  onPressed: _btCadastrar),
                            ),
                            Container(
                              padding: const EdgeInsets.all(5.0),
                              height: 55,
                              width: 400,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.black, // background
                                    onPrimary: Colors.white, // foreground
                                  ),
                                  child: Text(
                                    'Cancelar',
                                    style: TextStyle(
                                      fontSize: 17,
                                    ),
                                  ),
                                  onPressed: _btCancelar),
                            ),
                          ],
                        ),
                        Container(
                          height: 40,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/images/logo.png'),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
