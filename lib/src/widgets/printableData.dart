// ignore_for_file: depend_on_referenced_packages

import 'dart:math';

import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

int generateRandomSixDigitNumber() {
  final random = Random();
  return 100000 + random.nextInt(900000);
}

String getCurrentDate() {
  DateTime now = DateTime.now();
  DateFormat formatter = DateFormat('dd/MM/yyyy');
  return formatter.format(now);
}

int randomNumber = generateRandomSixDigitNumber();
String currentDate = getCurrentDate();
buildPrintableData(image,style,amount) => pw.Padding(
      padding: const pw.EdgeInsets.all(16.00),
      child: pw.Column(
        children: [
          pw.Align(
            alignment: pw.Alignment.center,
            child: pw.Image(
              image,
              width: 200,
              height: 200,
            ),
          ),
          pw.SizedBox(height: 10.00),
          pw.Align(
            alignment: pw.Alignment.center,
            child: pw.Text(
              'P.O.Box 104874',
              style:
                  pw.TextStyle(fontSize: 23.00, fontWeight: pw.FontWeight.bold),
            ),
          ),
          pw.Align(
            alignment: pw.Alignment.center,
            child: pw.Text(
              'Dar es Salaam',
              style:
                  pw.TextStyle(fontSize: 23.00, fontWeight: pw.FontWeight.bold),
            ),
          ),
          pw.Align(
            alignment: pw.Alignment.center,
            child: pw.Text(
              'Tanzania',
              style:
                  pw.TextStyle(fontSize: 23.00, fontWeight: pw.FontWeight.bold),
            ),
          ),
          pw.Align(
            alignment: pw.Alignment.center,
            child: pw.Text(
              'Tel: 0712673638',
              style:
                  pw.TextStyle(fontSize: 23.00, fontWeight: pw.FontWeight.bold),
            ),
          ),
          pw.Align(
            alignment: pw.Alignment.center,
            child: pw.Text(
              currentDate,
              style:
                  pw.TextStyle(fontSize: 23.00, fontWeight: pw.FontWeight.bold),
            ),
          ),
          pw.Column(
            children: [
              pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.end,
                children: [
                  pw.SizedBox(width: 5.5),
                  pw.Text(
                    'Receipt number',
                    style: const pw.TextStyle(
                        color: PdfColor(0, 0, 0, 0), fontSize: 12.00),
                  ),
                  pw.Spacer(),
                  pw.Text(
                    randomNumber.toString(),
                    style: const pw.TextStyle(
                        color: PdfColor(0, 0, 0, 0), fontSize: 12.00),
                  ),
                  pw.SizedBox(width: 5.5),
                ],
              ),
              pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.end,
                children: [
                  pw.SizedBox(width: 5.5),
                  pw.Text(
                    'Style',
                    style: const pw.TextStyle(
                        color: PdfColor(0, 0, 0, 0), fontSize: 12.00),
                  ),
                  pw.Spacer(),
                  pw.Text(
                    style,
                    style: const pw.TextStyle(
                        color: PdfColor(0, 0, 0, 0), fontSize: 12.00),
                  ),
                  pw.SizedBox(width: 5.5),
                ],
              ),
              pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.end,
                children: [
                  pw.SizedBox(width: 5.5),
                  pw.Text(
                    'Total Amount',
                    style: const pw.TextStyle(
                        color: PdfColor(0, 0, 0, 0), fontSize: 12.00),
                  ),
                  pw.Spacer(),
                  pw.Text(
                    amount,
                    style: const pw.TextStyle(
                        color: PdfColor(0, 0, 0, 0), fontSize: 12.00),
                  ),
                  pw.SizedBox(width: 5.5),
                ],
              ),
            ],
          ),
          pw.Divider(),
        ],
      ),
    );
