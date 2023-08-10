import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';

class PDFGenerator {
  Future<String> generatePDF() async {
    final pdf = pw.Document();

    pdf.addPage(pw.Page(
      build: (pw.Context context) {
        return pw.Center(
          child: pw.Text('Hello, PDF!', style: pw.TextStyle(fontSize: 40)),
        );
      },
    ));

    final Directory appDocDir = await getApplicationDocumentsDirectory();
    final String pdfPath = "${appDocDir.path}/example.pdf";
    final File pdfFile = File(pdfPath);
    await pdfFile.writeAsBytes(await pdf.save());

    return pdfPath;
  }
}

void main() {
  runApp(MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  final PDFGenerator pdfGenerator = PDFGenerator();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('PDF Generation')),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            String pdfPath = await pdfGenerator.generatePDF();
            print('PDF saved at: $pdfPath');
          },
          child: Text('Generate PDF'),
        ),
      ),
    );
  }
}
