

import 'dart:convert';
import 'package:afkar/alerts/alerts.dart';
import 'package:afkar/login.dart';
import 'package:http/http.dart' as http;
import 'package:afkar/firebase/push_notifications.dart';
import 'package:flutter_inappbrowser/flutter_inappbrowser.dart';
import 'package:afkar/AppBar1.dart/appBar2.dart';
import 'package:flutter/material.dart';

import 'orders/orders.dart';

class VerifyIdea extends StatefulWidget{
  String ideaID;

  VerifyIdea({this.ideaID});

  @override
  _VerifyIdeaState createState() => _VerifyIdeaState();
}

class _VerifyIdeaState extends State<VerifyIdea> {
  String get ideaID => widget.ideaID;
  InAppWebViewController webView;
  String url;
  int success = 0;
  double progress = 0;

  @override
  void initState() {
    url = "https://invideas.com/payM/$ideaID";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: IconButton(icon: Icon(Icons.clear, color: Colors.red),
            color: Colors.black54,
            onPressed: ()async{
              bool payLater = await showDialog(
                  context: context,
                  child: AlertDialog(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
                    title: Column(
                      children: [
                        Text("هل تريد الدفع لاحقاً؟", textAlign: TextAlign.center, style: TextStyle(color: Colors.black, fontSize: 16.0),),
                        SizedBox(height: 8.0,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            RaisedButton(
                              color: Theme.of(context).primaryColor,
                              onPressed: (){
                                Navigator.pop(context, true);
                              },
                              child: Text("نعم", style: TextStyle(color: Colors.white),),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
                            ),
                            RaisedButton(
                              color: Theme.of(context).primaryColor,
                              onPressed: (){
                                Navigator.pop(context, false);
                              },
                              child: Text("لا", style: TextStyle(color: Colors.white),),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
                            ),
                          ],
                        )
                      ],
                    ),
                  )
              );
              if(payLater) {
                await Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => Orders()
                    )
                );
              }
            }),
        title: Text("إضافة فكرة" , style: TextStyle(color:Colors.white),),
      ),
      body: Stack(
        children: <Widget>[
          InAppWebView(
            initialUrl: url,
            initialHeaders: {},
            initialOptions: new InAppWebViewWidgetOptions(androidInAppWebViewOptions: AndroidInAppWebViewOptions(textZoom: 120)),
            onWebViewCreated: (InAppWebViewController controller) {
              webView = controller;
            },
            onLoadStop: (InAppWebViewController controller, String newUrl)async{
              print("onLoadStop NEW URL: " + newUrl);
              if(newUrl != url) {
                if (newUrl.contains("https://invideas.com/payment_successM/")) {
                  success++;
                  print(success);
                }else{
                  alertTost("حدث خطأ، برجاء التأكد من صحة المعلومات او وجود رصيد كافي في البطاقة", seconds: 3);
                  if(await webView.canGoBack()){
                    await webView.goBack();
                    if(await webView.canGoBack()){
                      await webView.goBack();
                    }
                    success = 0;
                  }
                }
              }
              if(success == 2){
                print("success");
                alertTost("تم تسجيل الفكرة بنجاح، وسوف تظهر للمستثمرين", seconds: 3);
                success = 0;
                await Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => Orders()
                    )
                );
              }
            },
            onProgressChanged: (InAppWebViewController controller, int p) {
              setState(() {
                progress = p / 100;
              });
            },
          ),
          progress < 1
              ? SizedBox(
            height: 3,
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: Theme.of(context).accentColor.withOpacity(0.2),
            ),
          )
              : SizedBox(),
        ],
      ),
    );
  }
}