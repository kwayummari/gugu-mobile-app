// ignore_for_file: depend_on_referenced_packages

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

buildPrintableData(image) => pw.Padding(
      padding: const pw.EdgeInsets.all(16.00),
      child: pw.Column(
        children: [
          pw.Align(
            alignment: pw.Alignment.center,
            child: pw.Image(
              image,
              width: 100,
              height: 100,
            ),
          ),
          pw.SizedBox(height: 10.00),
          pw.Divider(),
          pw.Column(
            children: [
              pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.end,
                children: [
                  pw.SizedBox(width: 5.5),
                  pw.Text(
                    "Report",
                    style: pw.TextStyle(
                        fontSize: 23.00, fontWeight: pw.FontWeight.bold),
                  )
                ],
              ),
              pw.SizedBox(height: 10.00),
              pw.Text(
                "Thanks for choosing our service!",
                style: const pw.TextStyle(
                    color: PdfColor(0.5, 0.5, 0.5, 0.5), fontSize: 12.00),
              ),
              pw.SizedBox(height: 5.00),
              pw.Text(
                "Contact the branch for any clarifications.",
                style: const pw.TextStyle(
                    color: PdfColor(0.5, 0.5, 0.5, 0.5), fontSize: 12.00),
              ),
              pw.SizedBox(height: 15.00),
            ],
          ),
        ],
      ),
    );
