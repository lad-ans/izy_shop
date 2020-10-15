import 'package:flutter/material.dart';
import 'package:flutter_full_pdf_viewer/flutter_full_pdf_viewer.dart';

class PdfRoute {
  String path;
  PdfRoute(this.path);
}

class PDFPreview extends StatelessWidget {
  final PdfRoute route;
  const PDFPreview(
    this.route,
  );
  @override
  Widget build(BuildContext context) {
    return PDFViewerScaffold(
      path: route.path,
    );
  }
}
