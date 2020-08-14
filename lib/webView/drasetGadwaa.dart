import 'dart:async';
import 'package:afkar/webView/preview_file.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'package:flutter/material.dart';

class DrasetGadwaa extends StatefulWidget {
  final String id;

  DrasetGadwaa(this.id);

  @override
  _DrasetGadwaaState createState() => _DrasetGadwaaState();
}

class _DrasetGadwaaState extends State<DrasetGadwaa> {
  Completer<WebViewController> _controller = Completer<WebViewController>();
  Completer<WebViewController> _controller2 = Completer<WebViewController>();
  String url, downloadUrl;
  bool isLoading = true;
  @override
  void initState() {
    url = "https://invideas.com/feasability2/${widget.id}";
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'دراسة الجدوى',
          style: TextStyle(color: Colors.white),
        ),
        // This drop down menu demonstrates that Flutter widgets can be shown over the web view.
      ),

      body: Stack(
        children: [
          WebView(
            onPageStarted: (val){
              setState(() {
                isLoading = false;
              });
            },
            initialUrl: url,
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (WebViewController webViewController) {
              _controller.complete(webViewController);
            },
            navigationDelegate: (NavigationRequest request) async{
              Navigator.push(context, MaterialPageRoute(builder: (_) => PreviewFile(request.url)));
              return NavigationDecision.navigate;
            },
          ),
          isLoading?Center(child: CircularProgressIndicator()):Container()
        ],
      ),
    );
  }

}

class HesabElNesab extends StatefulWidget {
  @override
  _HesabElNesabState createState() => _HesabElNesabState();
}

class _HesabElNesabState extends State<HesabElNesab> {
  //Completer<WebViewController> _controller = Completer<WebViewController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'حساب النسب',
          style: TextStyle(color: Colors.white),
        ),
        // This drop down menu demonstrates that Flutter widgets can be shown over the web view.
      ),
      body: Container(),
    );
  }
}


/*
*
* WebView(
          initialUrl: 'https://invideas.com/feasability2/${widget.id}',
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) {
            _controller.complete(webViewController);
          },
          navigationDelegate: (NavigationRequest request) {
            print('allowing navigation to $request');
            return NavigationDecision.navigate;
          },
          onPageStarted: (String url) {
            print('Page started loading: $url');
          },
          onPageFinished: (String url) {
            print('Page finished loading: $url');
          },
          gestureNavigationEnabled: true,

        )
* */
