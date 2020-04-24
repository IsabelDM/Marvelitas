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
  var pathPDF = [
    "https://firebasestorage.googleapis.com/v0/b/marvelitas-1f7db.appspot.com/o/Spider-Gwen%20%231.pdf?alt=media&token=8b156569-b95d-4a78-b0ac-bc6cf5a38797",
    "https://firebasestorage.googleapis.com/v0/b/marvelitas-1f7db.appspot.com/o/Spider-Gwen%20%232.pdf?alt=media&token=07029c2c-9e7e-4684-9207-825abdcb6c2a",
    "https://firebasestorage.googleapis.com/v0/b/marvelitas-1f7db.appspot.com/o/Spider-Gwen%20%233.pdf?alt=media&token=ae401113-02c0-4f82-8e03-82fb5057beb1",
    "https://firebasestorage.googleapis.com/v0/b/marvelitas-1f7db.appspot.com/o/Spider-Gwen%20%234.pdf?alt=media&token=e93738d9-c8a7-4b1d-b2eb-62e795066de80",
    "https://firebasestorage.googleapis.com/v0/b/marvelitas-1f7db.appspot.com/o/Spider-Gwen%20%235.pdf?alt=media&token=0a607a6c-ee83-431f-abac-d753e0a68729",
    "https://firebasestorage.googleapis.com/v0/b/marvelitas-1f7db.appspot.com/o/Spider-Gwen.pdf?alt=media&token=415fa7d1-5596-42a4-b5ed-34c1790b6a4b",
    "https://firebasestorage.googleapis.com/v0/b/marvelitas-1f7db.appspot.com/o/The%20Mighty%20Thor%20-%20At%20The%20Gates%20Of%20Valhalla.pdf?alt=media&token=cc2755a6-e205-447a-8844-de41c3f86a41"
  ];

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < pathPDF.length; i++) {
      createFileOfPdfUrl(pathPDF[i]).then((f) {
        setState(() {
          pathPDF[i] = f.path;
          print(pathPDF[i]);
        });
      });
    }
  }

  Future<File> createFileOfPdfUrl(String url) async {
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
      appBar: AppBar(title: const Text('Lector de Cómics')),
      body: new ListView(
        children: <Widget>[
          /*  child: RaisedButton(
          child: Text("Open PDF"),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PDFScreen(pathPDF)),
          ),
        ),*/
          Expanded(
            child: GestureDetector(
              child: Container(
                width: 182,
                height: 257,
                decoration: BoxDecoration(
                  color: Colors.black,
                  image: DecorationImage(
                      image: NetworkImage(
                          "https://firebasestorage.googleapis.com/v0/b/marvelitas-1f7db.appspot.com/o/Portadas%2FSpiderGwen.jpg?alt=media&token=970e77cc-629f-4aa0-b06e-07fc66693efc"),
                      fit: BoxFit.cover),
                ),
                child: Text("ClickMe"),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PDFScreen(pathPDF[0])),
                );
              },
            ),
          ),
          Expanded(
            child: GestureDetector(
              child: Container(
                width: 182,
                height: 257,
                decoration: BoxDecoration(
                  color: Colors.black,
                  image: DecorationImage(
                      image: NetworkImage(
                          "https://firebasestorage.googleapis.com/v0/b/marvelitas-1f7db.appspot.com/o/Portadas%2FThorValhalla1_portada.jpg?alt=media&token=3291ee12-6a77-4534-875f-8d75a22d76f6"),
                      fit: BoxFit.cover),
                ),
              ),
              onTap: () {
                //pathPDF ="";
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PDFScreen(pathPDF[1])),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class PDFScreen extends StatelessWidget {
  String pathPDF = "";
  PDFScreen(this.pathPDF);

  @override
  Widget build(BuildContext context) {
    return PDFViewerScaffold(
        appBar: AppBar(
          title: Text("Lector de Cómics"),
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
