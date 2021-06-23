import 'dart:io';

import 'package:constructo/components/comodo_cadastro.dart';
import 'package:constructo/components/gasto_cadastro.dart';
import 'package:constructo/components/gasto_lista.dart';
import 'package:constructo/models/comodo.dart';
import 'package:constructo/models/gasto.dart';
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
      await Permission.storage.request();
    } else {
      pdf.addPage(pw.Page(
          pageFormat: PdfPageFormat.a4,
          build: (pw.Context context) {
            return pw.Center(
              child: pw.Text('Olá'),
            ); // Center
          })); // Page
      File file = File("$pathDownloads/$nomePDF.pdf");
      await file.writeAsBytes(await pdf.save());
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
                widget.comodo.titulo,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                ),
              )),
            ),
            RaisedButton(
              onPressed: () {
                _enviandoPDF();
              },
              child: Text('Criar PDF'),
            ),
            //Image.asset('assets/images/logo2.png'),
            GastoLista(_listaGasto),
          ],
        ),
      ),
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
