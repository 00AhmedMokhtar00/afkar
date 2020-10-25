

import 'dart:convert';
import 'package:afkar/alerts/alerts.dart';
import 'package:afkar/login.dart';
import 'package:http/http.dart' as http;
import 'package:afkar/firebase/push_notifications.dart';
import 'package:flutter_inappbrowser/flutter_inappbrowser.dart';
import 'package:afkar/AppBar1.dart/appBar2.dart';
import 'package:flutter/material.dart';

class VerifyAccount extends StatefulWidget{
  String id, token;

  VerifyAccount({this.id, this.token});

  @override
  _VerifyAccountState createState() => _VerifyAccountState();
}

class _VerifyAccountState extends State<VerifyAccount> {
  String get userID => widget.id;
  String get token => widget.token;
  InAppWebViewController webView;
  String url;
  int success = 0, failure = 0;
  double progress = 0;

  @override
  void initState() {
    url = "https://invideas.com/payactiviateM/$userID";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:appBar3(context , "تفعيل الحساب" , back: false),
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
                if (newUrl.contains("https://invideas.com/payment_success_activiateM/")) {
                  success++;
                  print(success);
                }else if(success == 0){
                  alertTost("برجاء إنتظار رد الإداره لتفعيل حسابك", seconds: 2);
                  await Navigator.push(context, MaterialPageRoute(builder: (context)=>LogIn()));
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
                await verify();
                success = 0;
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

  Future verify()async{
    try{
          String verifyUrl = "https://afkarestithmar.com/api/api.php?type=payedactiviateacc&token=$token";
          http.Response verifyResponse = await http.get(verifyUrl);
          var decodedBody = jsonDecode(verifyResponse.body);
          print(verifyResponse.body);
          await alertTost(decodedBody['message']);
          Navigator.push(context, MaterialPageRoute(builder: (context)=>LogIn()));
    }catch(e){
      print(e);
    }
  }
}