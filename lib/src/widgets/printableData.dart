// ignore_for_file: depend_on_referenced_packages

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;



String getCurrentDate() {
  DateTime now = DateTime.now();
  DateFormat formatter = DateFormat('dd/MM/yyyy');
  return formatter.format(now);
}


String currentDate = getCurrentDate();
String branchId = dotenv.env['BRANCH_ID'] ?? '1';
buildPrintableData(image, style, amount, name, customer, customerPhone, randomNumber) => pw.Padding(
      padding: const pw.EdgeInsets.all(16.00),
      child: pw.Column(
        children: [
          pw.Align(
            alignment: pw.Alignment.center,
            child: pw.Image(
              image,
              width: 80,
              height: 80,
            ),
          ),
          pw.Align(
            alignment: pw.Alignment.center,
            child: pw.Text(
              'P.O.Box: 104874',
              style:
                  pw.TextStyle(fontSize: 8.00, fontWeight: pw.FontWeight.bold),
            ),
          ),
          pw.Align(
            alignment: pw.Alignment.center,
            child: pw.Text(
              'Dar es Salaam',
              style:
                  pw.TextStyle(fontSize: 8.00, fontWeight: pw.FontWeight.bold),
            ),
          ),
          pw.Align(
            alignment: pw.Alignment.center,
            child: pw.Text(
              branchId == '2' ? 'Mwananyamala,Tanzania' : 'Kinondoni,Tanzania',
              style:
                  pw.TextStyle(fontSize: 8.00, fontWeight: pw.FontWeight.bold),
            ),
          ),
          pw.Align(
            alignment: pw.Alignment.center,
            child: pw.Text(
              branchId == '2' ? 'Tel: 0712673638' : '0678673638',
              style:
                  pw.TextStyle(fontSize: 8.00, fontWeight: pw.FontWeight.bold),
            ),
          ),
          pw.Align(
            alignment: pw.Alignment.center,
            child: pw.Text(
              currentDate,
              style:
                  pw.TextStyle(fontSize: 8.00, fontWeight: pw.FontWeight.bold),
            ),
          ),
          pw.SizedBox(height: 10.0),
          pw.Column(
            children: [
              pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.end,
                children: [
                  pw.SizedBox(width: 5.5),
                  pw.Text(
                    'Receipt no:',
                    style:  pw.TextStyle(
                        color: PdfColor(0, 0, 0, 0), fontSize: 8.00, fontWeight: pw.FontWeight.bold),
                  ),
                  pw.Spacer(),
                  pw.Text(
                    randomNumber.toString(),
                    style:  pw.TextStyle(
                        color: PdfColor(0, 0, 0, 0), fontSize: 8.00, fontWeight: pw.FontWeight.bold),
                  ),
                  pw.SizedBox(width: 5.5),
                ],
              ),
              pw.SizedBox(height: 8.5),
              pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.end,
                children: [
                  pw.SizedBox(width: 5.5),
                  pw.Text(
                    'Customer:',
                    style:  pw.TextStyle(
                        color: PdfColor(0, 0, 0, 0), fontSize: 8.00, fontWeight: pw.FontWeight.bold),
                  ),
                  pw.Spacer(),
                  pw.Text(
                    customer,
                    style:  pw.TextStyle(
                        color: PdfColor(0, 0, 0, 0), fontSize: 8.00, fontWeight: pw.FontWeight.bold),
                  ),
                  pw.SizedBox(width: 5.5),
                ],
              ),
              pw.SizedBox(height: 8.5),
              pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.end,
                children: [
                  pw.SizedBox(width: 5.5),
                  pw.Text(
                    'Customer Phone:',
                    style:  pw.TextStyle(
                        color: PdfColor(0, 0, 0, 0), fontSize: 8.00, fontWeight: pw.FontWeight.bold),
                  ),
                  pw.Spacer(),
                  pw.Text(
                    customerPhone,
                    style:  pw.TextStyle(
                        color: PdfColor(0, 0, 0, 0), fontSize: 8.00, fontWeight: pw.FontWeight.bold),
                  ),
                  pw.SizedBox(width: 5.5),
                ],
              ),
              pw.SizedBox(height: 8.5),
              pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.end,
                children: [
                  pw.SizedBox(width: 5.5),
                  pw.Text(
                    'Style',
                    style:  pw.TextStyle(
                        color: PdfColor(0, 0, 0, 0), fontSize: 8.00, fontWeight: pw.FontWeight.bold),
                  ),
                  pw.Spacer(),
                  pw.Text(
                    style,
                    style:  pw.TextStyle(
                        color: PdfColor(0, 0, 0, 0), fontSize: 8.00, fontWeight: pw.FontWeight.bold),
                  ),
                  pw.SizedBox(width: 5.5),
                ],
              ),
              pw.SizedBox(height: 8.5),
              pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.end,
                children: [
                  pw.SizedBox(width: 5.5),
                  pw.Text(
                    'Styler:',
                    style:  pw.TextStyle(
                        color: PdfColor(0, 0, 0, 0), fontSize: 8.00, fontWeight: pw.FontWeight.bold),
                  ),
                  pw.Spacer(),
                  pw.Text(
                    name,
                    style:  pw.TextStyle(
                        color: PdfColor(0, 0, 0, 0), fontSize: 8.00, fontWeight: pw.FontWeight.bold),
                  ),
                  pw.SizedBox(width: 5.5),
                ],
              ),
              pw.SizedBox(height: 8.5),
              pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.end,
                children: [
                  pw.SizedBox(width: 5.5),
                  pw.Text(
                    'Total:',
                    style:  pw.TextStyle(
                        color: PdfColor(0, 0, 0, 0), fontSize: 8.00, fontWeight: pw.FontWeight.bold),
                  ),
                  pw.Spacer(),
                  pw.Text(
                    amount,
                    style:  pw.TextStyle(
                        color: PdfColor(0, 0, 0, 0), fontSize: 8.00, fontWeight: pw.FontWeight.bold),
                  ),
                  pw.SizedBox(width: 5.5),
                ],
              ),
              pw.SizedBox(height: 8.5),
            ],
          ),
        ],
      ),
    );
