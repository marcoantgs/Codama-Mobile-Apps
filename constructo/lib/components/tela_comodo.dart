import 'dart:io';

import 'package:constructo/components/comodo_cadastro.dart';
import 'package:constructo/components/gasto_cadastro.dart';
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
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => CadastroComodo()));
      });
    } else if (index == 2) {
      setState(() {
        Navigator.popAndPushNamed(context, '/sobre');
      });
    }
  }

  _telaCadastroGasto() {
    setState(() {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => CadastroGasto(comodo: widget.comodo)));
    });
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

    //Se não tiver a permisssão de "Armazenar arquivos" pede para dar essa permissão
    //Se já tiver a permissão salva o arquivo
    if (!status.isGranted) {
      await Permission.storage.request().then((value) async {
        if (value.isGranted) {
          pdf.addPage(pw.Page(
              pageFormat: PdfPageFormat.a4,
              build: (pw.Context context) {
                return pw.Center(
                  child: pw.ListView.builder(
                      itemCount: _listaGasto.length,
                      // ignore: missing_return
                      itemBuilder: (context, index) {
                        //final ga = _listaGasto[index];
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Container(
                              width: 180,
                              alignment: Alignment.centerRight,
                              child: Text(
                                widget.comodo.titulo,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                ),
                              ),
                            ),
                          ],
                        );
                      }),
                ); // Center
              })); // Page
          File file = File("$pathDownloads/$nomePDF.pdf");
          await file.writeAsBytes(await pdf.save());
        }
      });
    } else {
      pdf.addPage(pw.Page(
          pageFormat: PdfPageFormat.a4,
          build: (pw.Context context) {
            return pw.Center(
              child: pw.ListView(),
            ); // Center
          })); // Page
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
                child: Icon(Icons.picture_as_pdf_outlined, size: 50),
                backgroundColor: Color.fromARGB(255, 72, 34, 16),
                foregroundColor: Colors.white,
                onPressed: () => _enviandoPDF(),
              ),
            ),
            GastoLista(_listaGasto),
            _listaGasto.isEmpty
                ? Container(
                    child: Text(
                      'Ainda não há nenhum gasto!',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                : Container(
                    child: Text(
                      _valorTotal().toString(),
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                  )
          ],
        ),
      ),
      //extendBody: true,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Color.fromARGB(255, 72, 34, 16),
        foregroundColor: Colors.white,
        onPressed: () => _telaCadastroGasto(),
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
