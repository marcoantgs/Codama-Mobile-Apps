import 'dart:io';

import 'package:constructo/components/gasto_lista.dart';
import 'package:constructo/models/comodo.dart';
import 'package:constructo/models/gasto.dart';
import 'package:constructo/utils/OperacoesComodo.dart';
import 'package:constructo/utils/OperacoesGasto.dart';
import 'package:ext_storage/ext_storage.dart';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';

import 'package:pdf/widgets.dart' as pw;
import 'package:permission_handler/permission_handler.dart';

class TelaComodo extends StatefulWidget {
  @override
  _TelaComodo createState() => _TelaComodo();

  final Comodo comodo;

  final pdf = pw.Document();

  TelaComodo(this.comodo);
}

class _TelaComodo extends State<TelaComodo> {
  List<Gasto> gastos = List<Gasto>();

  @override
  void initState() {
    super.initState();

    OperacoesGasto().getGastos(widget.comodo).then((lista) {
      setState(() {
        gastos = lista;

        for (var i = 0; i < gastos.length; i++) {
          Gasto gastosCadastrados = Gasto(
            gastos[i].id,
            gastos[i].titulo,
            gastos[i].valor,
            gastos[i].comodo,
          );
          _listaGasto.add(gastosCadastrados);
        }
      });
    });
  }

  final List<Gasto> _listaGasto = [];

  _trocaDeTela(int index) {
    if (index == 0) {
      setState(() {
        Navigator.popAndPushNamed(context, '/home');
      });
    } else if (index == 1) {
      setState(() {
        Navigator.popAndPushNamed(context, '/adicionarComodo');
      });
    } else if (index == 2) {
      setState(() {
        Navigator.popAndPushNamed(context, '/sobre');
      });
    }
  }

  _textoTituloPDF() {
    var tituloPdf = '';

    tituloPdf = 'Cômodo: ${widget.comodo.titulo}';

    return tituloPdf;
  }

  _textoGastosPDF() {
    var gastoPdf = '';

    for (var i = 0; i < _listaGasto.length; i++) {
      gastoPdf += "${_listaGasto[i].titulo} = R\$ ${_listaGasto[i].valor}";
      gastoPdf += '\n';
    }

    return gastoPdf;
  }

  _textoValorTotalPDF() {
    var valortotalPdf = '';

    valortotalPdf = 'Valor total = R\$ ${widget.comodo.valorTotal}';

    return valortotalPdf;
  }

  _enviandoPDF() async {
    final pdf = pw.Document();

    //Pegando o caminho da pasta de downloads
    String pathDownloads = await ExtStorage.getExternalStoragePublicDirectory(
        ExtStorage.DIRECTORY_DOWNLOADS);

    //Checando se tem permissão para salvar o arquivo
    var status = await Permission.storage.status;

    //Criando nome do documento
    String nomePDF = "Constructo - " + widget.comodo.titulo;

    //Criando a página PDF
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Column(
              children: <pw.Widget>[
                pw.Row(
                  children: [
                    pw.PdfLogo(),
                    pw.SizedBox(width: 0.5 * PdfPageFormat.cm),
                    pw.Text(
                      'Constructo',
                      style: pw.TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
                pw.Header(
                  level: 0,
                  child: pw.Text(
                    _textoTituloPDF(),
                    style: pw.TextStyle(
                      fontSize: 20,
                      fontWeight: pw.FontWeight.bold,
                      color: PdfColors.white,
                    ),
                  ),
                  padding: pw.EdgeInsets.all(4),
                  margin: pw.EdgeInsets.only(top: 10, bottom: 10),
                  decoration:
                      pw.BoxDecoration(color: PdfColor.fromHex('#482210')),
                ),
                pw.Text(
                  _textoGastosPDF(),
                  style: pw.TextStyle(
                    fontSize: 20,
                  ),
                ),
                pw.Header(
                  level: 1,
                  child: pw.Text(
                    _textoValorTotalPDF(),
                    style: pw.TextStyle(
                      fontSize: 20,
                      fontWeight: pw.FontWeight.bold,
                      color: PdfColors.white,
                    ),
                  ),
                  padding: pw.EdgeInsets.all(4),
                  decoration:
                      pw.BoxDecoration(color: PdfColor.fromHex('#482210')),
                ),
              ],
            ),
          );
        },
      ),
    );

    //Se não tiver a permisssão de "Armazenar arquivos" pede para dar essa permissão
    //caso permita salva o arquivo
    //Ou se já tiver a permissão salva o arquivo
    if (!status.isGranted) {
      await Permission.storage.request().then((value) async {
        if (value.isGranted) {
          File file = File("$pathDownloads/$nomePDF.pdf");
          await file.writeAsBytes(await pdf.save());
        }
      });
    } else {
      File file = File("$pathDownloads/$nomePDF.pdf");
      await file.writeAsBytes(await pdf.save());
    }
  }

  _valorTotal() {
    double valorTotal = 0.0;

    for (var i = 0; i < _listaGasto.length; i++) {
      valorTotal += _listaGasto[i].valor;
    }

    widget.comodo.valorTotal = valorTotal;

    OperacoesComodo().atualizar(widget.comodo);
    return valorTotal;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              color: Color.fromARGB(255, 72, 34, 16),
              height: 80,
              width: double.infinity,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Container(
                    width: 360,
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      widget.comodo.titulo,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              color: Color.fromARGB(255, 72, 34, 16),
              height: 50,
              width: double.infinity,
              alignment: Alignment.bottomRight,
              child: FloatingActionButton(
                heroTag: 'btPDF',
                child: Icon(Icons.picture_as_pdf_outlined, size: 50),
                backgroundColor: Color.fromARGB(255, 72, 34, 16),
                foregroundColor: Colors.white,
                onPressed: () {
                  if (_listaGasto.isNotEmpty) {
                    _enviandoPDF();
                  } else {
                    showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                          title: Text('Aviso'),
                          content: Text('Seu cômodo não tem nenhum gasto'),
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
                },
              ),
            ),
            Column(
              children: <Widget>[
                GastoLista(_listaGasto),
                _listaGasto.isEmpty
                    ? Container(
                        alignment: Alignment.center,
                        height: 56,
                        child: Text(
                          'Ainda não há nenhum gasto!',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.only(left: 75.0, right: 75.0),
                        child: Container(
                          alignment: Alignment.center,
                          height: 56,
                          decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.7)),
                          child: Text(
                            "Valor total = R\$ " + _valorTotal().toString(),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
              ],
            ),
          ],
        ),
      ),
      //extendBody: true,
      floatingActionButton: FloatingActionButton(
          heroTag: 'btAddGasto',
          child: Icon(Icons.add),
          backgroundColor: Color.fromARGB(255, 72, 34, 16),
          foregroundColor: Colors.white,
          onPressed: () {
            setState(() {
              Navigator.popAndPushNamed(context, '/adicionarGasto',
                  arguments: widget.comodo);
            });
          }),
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
