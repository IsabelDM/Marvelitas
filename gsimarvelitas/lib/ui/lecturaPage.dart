import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_full_pdf_viewer/full_pdf_viewer_scaffold.dart';
import 'package:gsimarvelitas/MenuHamburguesa/navigationBloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:getflutter/getflutter.dart';

void main() => runApp(EpubWidget());

class EpubWidget extends StatefulWidget with NavigationStates {
  @override
  State<StatefulWidget> createState() {
    return new EpubState();
  }
}

class EpubState extends State<EpubWidget> {
  var seriePDFSpiderGwen = [
    "https://firebasestorage.googleapis.com/v0/b/marvelitas-1f7db.appspot.com/o/Spider-Gwen%20%231.pdf?alt=media&token=8b156569-b95d-4a78-b0ac-bc6cf5a38797",
    "https://firebasestorage.googleapis.com/v0/b/marvelitas-1f7db.appspot.com/o/Spider-Gwen%20%232.pdf?alt=media&token=07029c2c-9e7e-4684-9207-825abdcb6c2a",
    "https://firebasestorage.googleapis.com/v0/b/marvelitas-1f7db.appspot.com/o/Spider-Gwen%20%233.pdf?alt=media&token=ae401113-02c0-4f82-8e03-82fb5057beb1",
    "https://firebasestorage.googleapis.com/v0/b/marvelitas-1f7db.appspot.com/o/Spider-Gwen%20%234.pdf?alt=media&token=e93738d9-c8a7-4b1d-b2eb-62e795066de80",
    "https://firebasestorage.googleapis.com/v0/b/marvelitas-1f7db.appspot.com/o/Spider-Gwen%20%235.pdf?alt=media&token=0a607a6c-ee83-431f-abac-d753e0a68729",
    "https://firebasestorage.googleapis.com/v0/b/marvelitas-1f7db.appspot.com/o/Spider-Gwen.pdf?alt=media&token=415fa7d1-5596-42a4-b5ed-34c1790b6a4b",
    "https://firebasestorage.googleapis.com/v0/b/marvelitas-1f7db.appspot.com/o/The%20Mighty%20Thor%20-%20At%20The%20Gates%20Of%20Valhalla.pdf?alt=media&token=cc2755a6-e205-447a-8844-de41c3f86a41"
  ];
  final List<String> seriePortadasSpiderGwen = [
    "https://firebasestorage.googleapis.com/v0/b/marvelitas-1f7db.appspot.com/o/Portadas%2FSpiderGwen%2FSpider-Gwen-1.jpg?alt=media&token=2c63215a-1330-435b-801c-e85ae36cf050",
    "https://firebasestorage.googleapis.com/v0/b/marvelitas-1f7db.appspot.com/o/Portadas%2FSpiderGwen%2FLa-portada-del-dia-Spider-Gwen-2.jpg?alt=media&token=292a6073-2fca-4f6a-8ba8-63a0f0deac44",
    "https://firebasestorage.googleapis.com/v0/b/marvelitas-1f7db.appspot.com/o/Portadas%2FSpiderGwen%2FSpider-Gwen-3.jpg?alt=media&token=e15ffaca-947f-46a2-a17a-754ace3a872f",
    "https://firebasestorage.googleapis.com/v0/b/marvelitas-1f7db.appspot.com/o/Portadas%2FSpiderGwen%2FSpider-Gwen_Vol_1_4.webp?alt=media&token=240cd008-63aa-47e1-a98a-e9e639831cb9",
    "https://firebasestorage.googleapis.com/v0/b/marvelitas-1f7db.appspot.com/o/Portadas%2FSpiderGwen%2Fspgwen15esp1.jpg?alt=media&token=ceb40386-11d8-441e-8d12-9aec82d332cd",
    "https://firebasestorage.googleapis.com/v0/b/marvelitas-1f7db.appspot.com/o/Portadas%2FSpiderGwen%2F2a11c5b021085e9c48676e645d8b60b0.jpg?alt=media&token=2121e114-d40b-44e6-9ea3-c3d3964c51a6",
    "https://firebasestorage.googleapis.com/v0/b/marvelitas-1f7db.appspot.com/o/Portadas%2FSpiderGwen.jpg?alt=media&token=970e77cc-629f-4aa0-b06e-07fc66693efc",
  ];
  final List<String> seriePortadasOtrosComics = [
    "https://firebasestorage.googleapis.com/v0/b/marvelitas-1f7db.appspot.com/o/Portadas%2FThorValhalla1_portada.jpg?alt=media&token=3291ee12-6a77-4534-875f-8d75a22d76f6",
    "https://firebasestorage.googleapis.com/v0/b/marvelitas-1f7db.appspot.com/o/Portadas%2FSpiderGwen%2FSpider-Gwen-1.jpg?alt=media&token=2c63215a-1330-435b-801c-e85ae36cf050",
    "https://firebasestorage.googleapis.com/v0/b/marvelitas-1f7db.appspot.com/o/Portadas%2FSpiderGwen%2FSpider-Gwen_Vol_1_4.webp?alt=media&token=240cd008-63aa-47e1-a98a-e9e639831cb9",
    "https://firebasestorage.googleapis.com/v0/b/marvelitas-1f7db.appspot.com/o/Portadas%2FSpiderGwen%2Fspgwen15esp1.jpg?alt=media&token=ceb40386-11d8-441e-8d12-9aec82d332cd",
  ];
  @override
  void initState() {
    super.initState();
    for (int i = 0; i < seriePDFSpiderGwen.length; i++) {
      createFileOfPdfUrl(seriePDFSpiderGwen[i]).then((f) {
        setState(() {
          seriePDFSpiderGwen[i] = f.path;
          print(seriePDFSpiderGwen[i]);
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
        appBar: AppBar(
          backgroundColor: Colors.black,
          centerTitle: true,
          title: Image.asset('assets/login_logo.png', height: 350, width: 100),
        ),
        backgroundColor: Colors.transparent,
        body: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/background1.jpg"),
                    fit: BoxFit.cover)),
            child: Container(
              child: new ListView(
                children: <Widget>[
                  SizedBox(
                    height: 45.0,
                  ),
                  GFTypography(
                    text: 'Spider Gwen',
                    type: GFTypographyType.typo1,
                    textColor: Colors.black,
                    dividerColor: Colors.black,
                  ),
                  GFItemsCarousel(
                    rowCount: 3,
                    children: seriePortadasSpiderGwen.map(
                      (url) {
                        return GestureDetector(
                          child: Container(
                            margin: EdgeInsets.all(5.0),
                            child: ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                              child: Image.network(url,
                                  fit: BoxFit.cover, width: 1000.0),
                            ),
                          ),
                          onTap: () {
                            var index = seriePortadasSpiderGwen.indexOf(url);
                            
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      PDFScreen(seriePDFSpiderGwen[index])),
                            );
                          },
                        );
                      },
                    ).toList(),
                  ),
                  SizedBox(height: 20,),
                  GFTypography(
                    text: 'Comics del dia',
                    type: GFTypographyType.typo1,
                    textColor: Colors.black,
                    dividerColor: Colors.black,
                  ),
                  GFItemsCarousel(
                    rowCount: 4,
                    children: seriePortadasOtrosComics.map(
                      (url) {
                        return Container(
                          margin: EdgeInsets.all(5.0),
                          child: ClipRRect(
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                            child: Image.network(url,
                                fit: BoxFit.cover, width: 1000.0),
                          ),
                        );
                      },
                    ).toList(),
                  ),
                ],
              ),
            )));
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
