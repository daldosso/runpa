import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class EventsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool isLoading = true;

    return Scaffold(
      appBar: AppBar(
        title: Text('Eventi'),
      ),
      body: WebViewScreen(),
    );
  }
}

class WebViewState extends State<WebViewScreen> {
  String title, url;
  bool isLoading = true;
  final _key = UniqueKey();

  WebViewState(String title, String url) {
    this.title = title;
    this.url = url;
  }
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        WebView(
          key: _key,
          initialUrl: this.url,
          javascriptMode: JavascriptMode.unrestricted,
          onPageFinished: (finish) {
            setState(() {
              isLoading = false;
            });
          },
        ),
        isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Stack(),
      ],
    );
  }
}

class WebViewScreen extends StatefulWidget {
  @override
  WebViewState createState() {
    return WebViewState("", "https://www.podisticaarona.it");
  }
}
