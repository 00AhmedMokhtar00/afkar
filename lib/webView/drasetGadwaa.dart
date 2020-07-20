import 'dart:async';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/material.dart';

class DrasetGadwaa extends StatefulWidget {
  @override
  _DrasetGadwaaState createState() => _DrasetGadwaaState();
}

class _DrasetGadwaaState extends State<DrasetGadwaa> {
  Completer<WebViewController> _controller = Completer<WebViewController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('دراسة الجدوي' , style: TextStyle(color:Colors.white),),
        // This drop down menu demonstrates that Flutter widgets can be shown over the web view.
      ),
      body: WebView(
        initialUrl: 'https://afkarestithmar.com/login/',
        onWebViewCreated: (WebViewController webViewController) {
          _controller.complete(webViewController);
        },
      ),
     
    );
  }
}


class HesabElNesab extends StatefulWidget {
  @override
  _HesabElNesabState createState() => _HesabElNesabState();
}

class _HesabElNesabState extends State<HesabElNesab> {
  Completer<WebViewController> _controller = Completer<WebViewController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('حساب النسب' , style: TextStyle(color:Colors.white),),
        // This drop down menu demonstrates that Flutter widgets can be shown over the web view.
      ),
      body: WebView(
        initialUrl: 'https://afkarestithmar.com/login/',
        onWebViewCreated: (WebViewController webViewController) {
          _controller.complete(webViewController);
        },
      ),
     
    );
  }
}