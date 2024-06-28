import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf_viewer_plugin/pdf_viewer_plugin.dart';

class PdfScreen extends StatefulWidget {
  final String url;
  final String pdfName;
  const PdfScreen({Key? key, required this.url, required this.pdfName}) : super(key: key);

  @override
  _PDFViewerState createState() => _PDFViewerState();
}

class _PDFViewerState extends State<PdfScreen> {
  String? _localPath;

  @override
  void initState() {
    super.initState();
    _downloadFile();
  }

  Future<void> _downloadFile() async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/${widget.url.split('/').last}');

    await FirebaseStorage.instance.refFromURL(widget.url).writeToFile(file);

    setState(() {
      _localPath = file.path;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.pdfName),
      ),
      body: _localPath!= null
          ? PdfView(
        path: _localPath!,
      )
          : Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}