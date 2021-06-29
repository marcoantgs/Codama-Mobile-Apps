import 'package:auto_size_text/auto_size_text.dart';
import 'package:constructo/models/argumentos.dart';
import 'package:constructo/models/gasto.dart';
import 'package:constructo/utils/OperacoesGasto.dart';
import 'package:flutter/material.dart';

class CadastroGasto extends StatefulWidget {
  final Argumentos args;
  CadastroGasto(this.args);

  @override
  _CadastroGastoState createState() => _CadastroGastoState();
}

class _CadastroGastoState extends State<CadastroGasto> {
  bool editando;
  List<Gasto> gastos = List<Gasto>();

  final tituloController = TextEditingController();
  final valorController = TextEditingController();

  @override
  void initState() {
    super.initState();

    final gasto = widget.args.gasto;

    if (gasto == null) {
      editando = false;
    } else {
      editando = true;
      tituloController.text = gasto.titulo;
      valorController.text = gasto.valor.toString();
    }
  }

  _btCadastrar() {
    var id;
    //Pegando os valores
    if (editando == true) {
      id = widget.args.gasto.id;
    } else {
      id = 0;
    }
    final titulo = tituloController.text;
    final valor = double.tryParse(valorController.text);
    final comodo = widget.args.comodo.id;

    //Tratando campos
    //Caso o titulo esteja vazio
    if (titulo.isEmpty) {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
            title: Text('Aviso'),
            content: Text('O campo "Título" não pode estar vazio.'),
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
    //Caso o valor esteja vazio
    if (valorController.text.isEmpty) {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
            title: Text('Aviso'),
            content: Text('O campo "Valor" não pode estar vazio.'),
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
    //Caso o valor seja 0
    if (valor == 0 || valor == 0.0) {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
            title: Text('Aviso'),
            content: Text('O campo "Valor" não pode ser "0".'),
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
    //Caso o valor não seja um número
    if (valor == null) {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
            title: Text('Aviso'),
            content: Text('O campo "Valor" precisa ser um número. \n \n' +
                'Ex.: 1 ou 1.1'),
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
    final novoGasto = Gasto(id, titulo, valor, comodo);
    if (editando == true) {
      OperacoesGasto().atualizar(novoGasto);
    } else {
      OperacoesGasto().inserir(novoGasto);
    }

    //Chamando a outra tela
    setState(() {
      Navigator.popAndPushNamed(context, '/comodo',
          arguments: widget.args.comodo);
    });
  }

  _btCancelar() {
    Navigator.popAndPushNamed(context, '/comodo',
        arguments: widget.args.comodo);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/imagem-fundo2.jpg'),
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
                            "Cadastro de gastos",
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
                              hintText: 'Insira o título do gasto',
                              hintStyle: TextStyle(fontSize: 15),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Container(
                            child: Text(
                              'Valor:',
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
                            controller: valorController,
                            keyboardType: TextInputType.numberWithOptions(decimal: true),
                            decoration: InputDecoration(
                              counterText: '',
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 15.0, horizontal: 20.0),
                              fillColor: Colors.white,
                              filled: true,
                              border: OutlineInputBorder(),
                              hintText: 'Insira o valor do gasto',
                              hintStyle: TextStyle(fontSize: 15),
                            ),
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
                                        'Salvar gasto',
                                        style: TextStyle(
                                          fontSize: 17,
                                        ),
                                      )
                                    : Text(
                                        'Adicionar gasto',
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

                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

