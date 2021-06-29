import 'dart:io';

import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:flutter/material.dart';
import 'package:share_extend/share_extend.dart';

class TelaVerPDF extends StatefulWidget {
  final File file;
  TelaVerPDF(this.file);
  @override
  _TelaVerPDFState createState() => _TelaVerPDFState();
}

class _TelaVerPDFState extends State<TelaVerPDF> {
  var _loading;
  var _doc;

  @override
  void initState() {
    super.initState();
    _initPdf();
  }

  _initPdf() async {
    setState(() {
      _loading = true;
    });
    final doc = await PDFDocument.fromFile(widget.file);
    setState(() {
      _doc = doc;
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : PDFViewer(document: _doc),
      appBar: AppBar(
        title: Text('Flutter PDF'),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
                icon: Icon(
                  Icons.share,
                  color: Colors.white,
                ),
                iconSize: 30,
                onPressed: () {
                  ShareExtend.share(widget.file.path, "file",
                      sharePanelTitle: "Enviar PDF", subject: "example-pdf");
                }),
          )
        ],
      ),
    );
  }
}
