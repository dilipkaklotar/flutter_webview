import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

//import 'package:url_launcher/url_launcher.dart';
//import 'dart:async';

String url = 'https://google.com';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: 'Webview Example',
      theme: ThemeData(primarySwatch: Colors.pink),
      routes: {
        '/': (_) => Home(),
        '/webview': (_) => WebviewScaffold(
              url: url,
              appBar: AppBar(
                title: Text('Webview'),
              ),
              withJavascript: true,
              withLocalStorage: true,
              withZoom: true,
            ),
      },
      //home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final webView = FlutterWebviewPlugin();
  TextEditingController controller = TextEditingController(text: url);

  @override
  void initState() {
    super.initState();
    webView.close();

    controller.addListener(() {
      url = controller.text;
    });
  }

  @override
  void dispose() {
    webView.dispose();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Webview Example'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(10.0),
              child: TextField(
                controller: controller,
              ),
            ),
            RaisedButton(
                child: Text('Open website'),
                onPressed: () {
                  Navigator.of(context).pushNamed("/webview");
                })
          ],
        ),
      ),
    );
  }
}
