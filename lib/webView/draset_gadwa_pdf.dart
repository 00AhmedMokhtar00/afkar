import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:afkar/webView/nesab_model.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import 'generate_pdf.dart';


class PdfScreen extends StatefulWidget {
  final NesabModel nesabModel;

  PdfScreen({this.nesabModel});

  @override
  PdfScreenState createState() {
    return PdfScreenState();
  }
}

class PdfScreenState extends State<PdfScreen> with SingleTickerProviderStateMixin {
  PrintingInfo printingInfo;

  void _showPrintedToast(BuildContext context) {
    final ScaffoldState scaffold = Scaffold.of(context);

    scaffold.showSnackBar(
      const SnackBar(
        content: Text('Document printed successfully'),
      ),
    );
  }

  void _showSharedToast(BuildContext context) {
    final ScaffoldState scaffold = Scaffold.of(context);

    scaffold.showSnackBar(
      const SnackBar(
        content: Text('Document shared successfully'),
      ),
    );
  }

  Future<void> _saveAsFile(
      BuildContext context,
      LayoutCallback build,
      PdfPageFormat pageFormat,
      ) async {
    final Uint8List bytes = await build(pageFormat);

    final Directory appDocDir = await getApplicationDocumentsDirectory();
    final String appDocPath = appDocDir.path;
    final File file = File(appDocPath + '/' + 'Afkar_Nesab.pdf');
    await file.writeAsBytes(bytes);
    //OpenFile.open(file.path);
  }

  @override
  Widget build(BuildContext context) {
    pw.RichText.debug = true;

    final actions = <PdfPreviewAction>[
      PdfPreviewAction(
        icon: const Icon(Icons.save),
        onPressed: _saveAsFile,
      )
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('تقرير حساب النسب'),
      ),

      body: PdfPreview(

        canChangePageFormat: true,
        pageFormats: {
          "A4" : PdfPageFormat.a4,
          "A3" : PdfPageFormat.a3,
          "letter" : PdfPageFormat.letter,
        },
        //maxPageWidth: 700,
        scrollViewDecoration: BoxDecoration(
            color: Colors.white
        ),
        initialPageFormat: PdfPageFormat.a4,
        build: (format) => generateDocument(format, nesabModel: widget.nesabModel),
        //actions: actions,
        onPrinted: _showPrintedToast,
        onShared: _showSharedToast,
      ),
    );
  }

}