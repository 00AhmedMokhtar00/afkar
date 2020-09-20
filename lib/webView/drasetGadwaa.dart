import 'dart:async';
import 'package:afkar/webView/nesab_model.dart';
import 'package:afkar/webView/preview_file.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'package:flutter/material.dart';

import 'draset_gadwa_pdf.dart';

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
  bool isLoading = true, done = false;
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
              if(done) {
                Navigator.push(context, MaterialPageRoute(
                    builder: (_) => PreviewFile(request.url, "دراسة الجدوى")));
              }
              done = true;
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
  GlobalKey<FormState> _FormKey;
  TextEditingController _projectMoneyController;
  TextEditingController _thinkerShareController ;
  TextEditingController _rasElmalProfitController ;
  FocusNode _thinkerSharefocusNode;
  FocusNode _rasElmalProfitfocusNode;

  @override
  void initState() {
    _FormKey = GlobalKey<FormState>();
    _projectMoneyController   = TextEditingController();
    _thinkerShareController   = TextEditingController();
    _rasElmalProfitController = TextEditingController();
    _thinkerSharefocusNode    = FocusNode();
    _rasElmalProfitfocusNode  = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _projectMoneyController.dispose();
    _thinkerShareController.dispose();
    _rasElmalProfitController.dispose();
    _thinkerSharefocusNode.dispose();
    _rasElmalProfitfocusNode.dispose();
    super.dispose();
  }

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
      body: Form(
        key: _FormKey,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(8),
                  ],
                  textAlign: TextAlign.center,
                  controller: _projectMoneyController,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (_){FocusScope.of(context).requestFocus(_thinkerSharefocusNode);},
                  enableSuggestions: true,
                  autocorrect: true,
                  decoration: InputDecoration(
                      hintText: "رأس مال المشروع",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                          borderSide: BorderSide(color: Theme.of(context).primaryColor)),
                      contentPadding: const EdgeInsets.all(5)
                  ),
                  validator: (value) => double.parse(value) > 1.0? null : "الرجاء إدخال رأس مال صحيح",
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(2),
                  ],
                  textAlign: TextAlign.center,
                  controller: _thinkerShareController,
                  focusNode: _thinkerSharefocusNode,
                  onFieldSubmitted: (_){FocusScope.of(context).requestFocus(_rasElmalProfitfocusNode);},
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  enableSuggestions: true,
                  autocorrect: true,
                  decoration: InputDecoration(
                      hintText: "حصة المفكر",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                          borderSide: BorderSide(color: Theme.of(context).primaryColor)),
                      contentPadding: const EdgeInsets.all(5)
                  ),
                  validator: (value) => double.parse(value) < 100.0 && double.parse(value) >= 1.0? null : "الرجاء إدخال نسبة صحيحة من 1 ل 99",
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(4),
                  ],
                  textAlign: TextAlign.center,
                  controller: _rasElmalProfitController,
                  focusNode: _rasElmalProfitfocusNode,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.done,
                  enableSuggestions: true,
                  autocorrect: true,
                  decoration: InputDecoration(
                      hintText: "العائد على رأس المال",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                          borderSide: BorderSide(color: Theme.of(context).primaryColor)),
                      contentPadding: const EdgeInsets.all(5)
                  ),
                  validator: (value) => double.parse(value) <= 1000.0 && double.parse(value) >= 1.0? null : "الرجاء إدخال عائد صحيح",
                ),
                SizedBox(height: 40.0),
                GestureDetector(
                  onTap: _calculate,
                  child: Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width * 0.6,
                    height: MediaQuery.of(context).size.height * 0.06,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25.0),
                      color: Theme.of(context).primaryColor,
                    ),
                    child: Text("حساب النسب" ,style:TextStyle(fontSize:13 , color: Colors.white)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _calculate()async{
    final bool isValid = _FormKey.currentState.validate();
    if(isValid){
      NesabModel nesabModel = _calculateNesab();
      await Navigator.push(context, MaterialPageRoute(
        builder: (_) => PdfScreen(nesabModel: nesabModel)
      )
      );
    }
  }

  NesabModel _calculateNesab(){
    final double rasElmal                       = double.parse(_projectMoneyController.text);
    final double thinkerShare                   = double.parse(_thinkerShareController.text);
    final double fekraVlaue                     = rasElmal * 0.1;
    final double totalRasElmal                  = rasElmal + fekraVlaue;
    final double investorShare                  = 100 - thinkerShare;
    final double rasElmalProfit                 = double.parse(_rasElmalProfitController.text);
    final double projectProfit                  = totalRasElmal * rasElmalProfit / 100;
    final double investorNetProfit              = projectProfit * investorShare / 100;
    final double thinkerNetProfit               = projectProfit * thinkerShare / 100;
    final double investorProfit                 = investorNetProfit / totalRasElmal * 100;
    final double thinkerProfit                  = thinkerNetProfit / fekraVlaue * 100;
    final double rasElmalRefundDuration         = totalRasElmal / projectProfit;
    final double investorRasElmalRefundDuration = totalRasElmal / investorNetProfit;
    final double thinkerRasElmalRefundDuration  = fekraVlaue / thinkerNetProfit;

    return NesabModel(
        rasElmal: rasElmal,
        thinkerShare: thinkerShare,
        fekraValue: fekraVlaue,
        totalRasElmal: totalRasElmal,
        investorShare: investorShare,
        rasElmalProfit: rasElmalProfit,
        projectProfit: projectProfit,
        investorNetProfit: investorNetProfit,
        thinkerNetProfit: thinkerNetProfit,
        investorProfit: investorProfit,
        thinkerProfit: thinkerProfit,
        rasElmalRefundDuration: rasElmalRefundDuration,
        investorRasElmalRefundDuration: investorRasElmalRefundDuration,
        thinkerRasElmalRefundDuration: thinkerRasElmalRefundDuration
    );
  }

}