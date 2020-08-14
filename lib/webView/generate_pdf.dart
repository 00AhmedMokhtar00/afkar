import 'dart:typed_data';

import 'package:afkar/webView/nesab_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

 //  01001691406  ام منه

Future<Uint8List> generateDocument(PdfPageFormat format, {NesabModel nesabModel}) async {
  var data = await rootBundle.load("fonts/Hacen-Egypt.ttf");
  var myFont = pw.Font.ttf(data);
  final pw.Document doc = pw.Document();
  double header1Size = 24;
  double header2Size = 20;
  double header3Size = 18;

  List<String> output = List();
  output.addAll([
    nesabModel.rasElmal.toStringAsFixed(2),
    nesabModel.fekraValue.toStringAsFixed(2),
    nesabModel.totalRasElmal.toStringAsFixed(2),
    nesabModel.investorShare.toStringAsFixed(2),
    nesabModel.thinkerShare.toStringAsFixed(2),
    nesabModel.rasElmalProfit.toStringAsFixed(2),
    nesabModel.investorProfit.toStringAsFixed(2),
    nesabModel.thinkerProfit.toStringAsFixed(2),
    nesabModel.projectProfit.toStringAsFixed(2),
    nesabModel.investorNetProfit.toStringAsFixed(2),
    nesabModel.thinkerNetProfit.toStringAsFixed(2),
    nesabModel.rasElmalRefundDuration.toStringAsFixed(2),
    nesabModel.investorRasElmalRefundDuration.toStringAsFixed(2),
    nesabModel.thinkerRasElmalRefundDuration.toStringAsFixed(2),

    
  ]
  );

  doc.addPage(
      pw.MultiPage(

          pageFormat:
          PdfPageFormat.a4.copyWith(marginBottom: 1.0 * PdfPageFormat.cm),
          crossAxisAlignment: pw.CrossAxisAlignment.end,
          header: (pw.Context context) {

            return pw.Container(
                alignment: pw.Alignment.centerLeft,
                margin: const pw.EdgeInsets.only(bottom: 3.0 * PdfPageFormat.mm),
                padding: const pw.EdgeInsets.only(bottom: 3.0 * PdfPageFormat.mm),
                decoration: const pw.BoxDecoration(
                    border: pw.BoxBorder(
                        bottom: true, width: 0.5, color: PdfColors.grey)),
                child: pw.Text('Afkar Application',
                    style: pw.Theme.of(context)
                        .defaultTextStyle
                        .copyWith(
                        color: PdfColors.grey,
                        font: myFont
                    )
                )
            );
          },
          footer: (pw.Context context) {
            return pw.Container(
                alignment: pw.Alignment.centerRight,
                margin: const pw.EdgeInsets.only(top: 1.0 * PdfPageFormat.cm),
                child: pw.Text(
                    'Page ${context.pageNumber} of ${context.pagesCount}',
                    style: pw.Theme.of(context)
                        .defaultTextStyle
                        .copyWith(color: PdfColors.grey)));
          },
          build: (pw.Context context) => <pw.Widget>[
            pw.Header(
                level: 0,
                child: pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.end,
                    children: <pw.Widget>[
                      pw.Text('تقرير حساب نسب المشروع', textScaleFactor: 1, textDirection: pw.TextDirection.rtl,textAlign: pw.TextAlign.left, style: pw.TextStyle(font: myFont, fontSize: header1Size)),
                    ])),

            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Text(output[0], textDirection: pw.TextDirection.rtl, textAlign: pw.TextAlign.right,style: pw.TextStyle(font: myFont, fontSize: 20.0)),
                pw.Text("راس مال المشروع:",  textDirection: pw.TextDirection.rtl, textAlign: pw.TextAlign.right,style: pw.TextStyle(font: myFont, fontSize: 20.0)),

              ]
            ),
            pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text(output[1], textDirection: pw.TextDirection.rtl, textAlign: pw.TextAlign.right,style: pw.TextStyle(font: myFont, fontSize: 20.0)),
                  pw.Text("قيمة الفكرة والدراسة:",  textDirection: pw.TextDirection.rtl, textAlign: pw.TextAlign.right,style: pw.TextStyle(font: myFont, fontSize: 20.0)),

                ]
            ),
            pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text(output[2], textDirection: pw.TextDirection.rtl, textAlign: pw.TextAlign.right,style: pw.TextStyle(font: myFont, fontSize: 20.0)),
                  pw.Text("راس المال الكلي:",  textDirection: pw.TextDirection.rtl, textAlign: pw.TextAlign.right,style: pw.TextStyle(font: myFont, fontSize: 20.0)),

                ]
            ),
            pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text("% "+output[3], textDirection: pw.TextDirection.rtl, textAlign: pw.TextAlign.right,style: pw.TextStyle(font: myFont, fontSize: 20.0)),
                  pw.Text("حصة المستثمر:",  textDirection: pw.TextDirection.rtl, textAlign: pw.TextAlign.right,style: pw.TextStyle(font: myFont, fontSize: 20.0)),

                ]
            ),
            pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text("% "+output[4], textDirection: pw.TextDirection.rtl, textAlign: pw.TextAlign.right,style: pw.TextStyle(font: myFont, fontSize: 20.0)),
                  pw.Text("حصة المفكر:",  textDirection: pw.TextDirection.rtl, textAlign: pw.TextAlign.right,style: pw.TextStyle(font: myFont, fontSize: 20.0)),

                ]
            ),
            pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text("% "+output[5], textDirection: pw.TextDirection.rtl, textAlign: pw.TextAlign.right,style: pw.TextStyle(font: myFont, fontSize: 20.0)),
                  pw.Text("العائد على راس مال المشروع:",  textDirection: pw.TextDirection.rtl, textAlign: pw.TextAlign.right,style: pw.TextStyle(font: myFont, fontSize: 20.0)),

                ]
            ),
            pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text("% "+output[6], textDirection: pw.TextDirection.rtl, textAlign: pw.TextAlign.right,style: pw.TextStyle(font: myFont, fontSize: 20.0)),
                  pw.Text("العائد الفعلي على رأس مال المستثمر:",  textDirection: pw.TextDirection.rtl, textAlign: pw.TextAlign.right,style: pw.TextStyle(font: myFont, fontSize: 20.0)),

                ]
            ),
            pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text("% "+output[7], textDirection: pw.TextDirection.rtl, textAlign: pw.TextAlign.right,style: pw.TextStyle(font: myFont, fontSize: 20.0)),
                  pw.Text("العائد الفعلي على رأس مال المفكر:",  textDirection: pw.TextDirection.rtl, textAlign: pw.TextAlign.right,style: pw.TextStyle(font: myFont, fontSize: 20.0)),

                ]
            ),
            pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text(output[8], textDirection: pw.TextDirection.rtl, textAlign: pw.TextAlign.right,style: pw.TextStyle(font: myFont, fontSize: 20.0)),
                  pw.Text("صافي ربح المشروع:",  textDirection: pw.TextDirection.rtl, textAlign: pw.TextAlign.right,style: pw.TextStyle(font: myFont, fontSize: 20.0)),

                ]
            ),
            pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text(output[9], textDirection: pw.TextDirection.rtl, textAlign: pw.TextAlign.right,style: pw.TextStyle(font: myFont, fontSize: 20.0)),
                  pw.Text("صافي ربح المستثمر:",  textDirection: pw.TextDirection.rtl, textAlign: pw.TextAlign.right,style: pw.TextStyle(font: myFont, fontSize: 20.0)),

                ]
            ),
            pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text(output[10], textDirection: pw.TextDirection.rtl, textAlign: pw.TextAlign.right,style: pw.TextStyle(font: myFont, fontSize: 20.0)),
                  pw.Text("صافي ربح المفكر:",  textDirection: pw.TextDirection.rtl, textAlign: pw.TextAlign.right,style: pw.TextStyle(font: myFont, fontSize: 20.0)),

                ]
            ),
            pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text(output[11], textDirection: pw.TextDirection.rtl, textAlign: pw.TextAlign.right,style: pw.TextStyle(font: myFont, fontSize: 20.0)),
                  pw.Text("فترة استرداد راس المال )بالسنوات(:",  textDirection: pw.TextDirection.rtl, textAlign: pw.TextAlign.right,style: pw.TextStyle(font: myFont, fontSize: 20.0)),

                ]
            ),
            pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text(output[12], textDirection: pw.TextDirection.rtl, textAlign: pw.TextAlign.right,style: pw.TextStyle(font: myFont, fontSize: 20.0)),
                  pw.Text("فترة استرداد راس مال المستثمر )بالسنوات(:",  textDirection: pw.TextDirection.rtl, textAlign: pw.TextAlign.right,style: pw.TextStyle(font: myFont, fontSize: 20.0)),

                ]
            ),
            pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text(output[13], textDirection: pw.TextDirection.rtl, textAlign: pw.TextAlign.right,style: pw.TextStyle(font: myFont, fontSize: 20.0)),
                  pw.Text("فترة استرداد راس مال المستثمر )بالسنوات(:",  textDirection: pw.TextDirection.rtl, textAlign: pw.TextAlign.right,style: pw.TextStyle(font: myFont, fontSize: 20.0)),

                ]
            ),
            pw.Padding(padding: const pw.EdgeInsets.all(10)),
          ]));

  return doc.save();
}