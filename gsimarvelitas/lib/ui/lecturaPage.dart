import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_full_pdf_viewer/full_pdf_viewer_scaffold.dart';
import 'package:gsimarvelitas/MenuHamburguesa/navigationBloc.dart';
import 'package:path_provider/path_provider.dart';

void main() => runApp(EpubWidget());

class EpubWidget extends StatefulWidget with NavigationStates {
  @override
  State<StatefulWidget> createState() {
    return new EpubState();
  }
}

class EpubState extends State<EpubWidget> {
  String pathPDF = "";

  @override
  void initState() {
    super.initState();
    createFileOfPdfUrl().then((f) {
      setState(() {
        pathPDF = f.path;
        print(pathPDF);
      });
    });
  }

  Future<File> createFileOfPdfUrl() async {
    final url =
        "https://firebasestorage.googleapis.com/v0/b/marvelitas-1f7db.appspot.com/o/Spider-Gwen.pdf?alt=media&token=415fa7d1-5596-42a4-b5ed-34c1790b6a4b";
    final filename = url.substring(url.lastIndexOf("/") + 1);
    var request = await HttpClient().getUrl(Uri.parse(url));
    var response = await request.close();
    var bytes = await consolidateHttpClientResponseBytes(response);
    String dir = (await getApplicationDocumentsDirectory()).path;
    File file = new File('$dir/$filename');
    await file.writeAsBytes(bytes);
    return file;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Plugin example app')),
      body: Center(
        /*  child: RaisedButton(
          child: Text("Open PDF"),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PDFScreen(pathPDF)),
          ),
        ),*/
        child: GestureDetector(
            child: Container(
              width: 182,
              height: 257,
              decoration: BoxDecoration(
                color: Colors.black,
                image: DecorationImage(
                    image: AssetImage("assets/PortadaNoAcoso.jpg"),
                    fit: BoxFit.cover),
              ),
              child: Text("ClickMe"),
            ),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => PDFScreen(pathPDF)),);
            }),
      ),
    );
  }
}

class PDFScreen extends StatelessWidget {
  String pathPDF = "https://firebasestorage.googleapis.com/v0/b/marvelitas-1f7db.appspot.com/o/Spider-Gwen.pdf?alt=media&token=415fa7d1-5596-42a4-b5ed-34c1790b6a4b";
  PDFScreen(this.pathPDF);

  @override
  Widget build(BuildContext context) {
    return PDFViewerScaffold(
        appBar: AppBar(
          title: Text("Document"),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.share),
              onPressed: () {},
            ),
          ],
        ),
        path: pathPDF);
  }
}
