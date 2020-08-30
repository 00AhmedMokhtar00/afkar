import 'dart:convert';
import 'package:afkar/backEnd/getDataId.dart';
import 'package:afkar/main.dart';
import 'package:afkar/screens/articles.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:country_code_picker/country_code_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'firebase/push_notifications.dart';

class LogIn extends StatefulWidget {
  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  String message = "";
  String codeNational = "20";
  bool isLoading = false;

  final TextEditingController _emailController = new TextEditingController();
  final TextEditingController _passwordController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff5f5f5),
      body: Container(
         width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              color: Color(0xfff5f5f5),
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage("images/backGround.png"))),
        child: Stack(
              children: <Widget>[
                Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            
                ),
                Positioned(
                  //top:MediaQuery.of(context).size.height*0.08,
                  width: MediaQuery.of(context).size.width,
                                  child: Container(
                          //height: MediaQuery.of(context).size.height * 0.53,
                          child: Image(image: AssetImage("images/logo3.png"))),
                ),
                Positioned(
                  bottom: 0,
                    child: ConstrainedBox(
                      constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height*0.46 , maxWidth: MediaQuery.of(context).size.width),
                      child: SingleChildScrollView(
                        child: Column(
                        children: <Widget>[
                          Container(
                              width: 220,
                              child: Text(
                                "قم بإدخال رقم الهاتف ورمز التفعيل لاستخدام التطبيق",
                                style: TextStyle(color: Colors.black87, fontSize: 16),
                                textAlign: TextAlign.center,
                              )),
                          SizedBox(height: 20),
                          Container(
                              padding: EdgeInsets.only(left: 20, right: 20),
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.only(left: 15),
                                    alignment: Alignment.center,
                                    color: Color(0xffebebeb),
                                    child: CountryCodePicker(
                                      onChanged: (val) {
                                        setState(() {
                                          codeNational = val.dialCode;
                                        });
                                      },
                                      // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                                      initialSelection: 'EG',
                                      favorite: ['+966', 'SA'],
                                      // optional. Shows only country name and flag
                                      showCountryOnly: false,
                                      // optional. Shows only country name and flag when popup is closed.
                                      showOnlyCountryWhenClosed: false,
                                      // optional. aligns the flag and the Text left
                                      alignLeft: false,
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Flexible(
                                    child: Stack(
                                      children: <Widget>[
                                        TextField(
                                          controller: _emailController,
                                          keyboardType: TextInputType.number,
                                          style: TextStyle(
                  color: Colors.black54,
                  fontSize: 15,
                                          ),
                                          //maxLength: 160,
                                          decoration: InputDecoration(
                  //icon: Icon(Icons.phone),
                  contentPadding:
                          const EdgeInsets.only(right: 50.0),
                  border: InputBorder.none,
                  filled: true,
                  fillColor: Color(0xffebebeb),
                  hintText: "ادخل رقم الهاتف",
                  hintStyle: TextStyle(
                          color: Colors.black26, fontSize: 12),
                                          ),
                                        ),
                                        Container(
                  width: 45,
                  height: 50,
                  alignment: Alignment.center,
                  child: Image(
                        image: AssetImage("images/call.png"),
                        width: 30,
                        height: 30,
                  )),
                                        Positioned(
                                          top: 5,
                                          right: 42,
                                          child: Container(
                        padding: EdgeInsets.only(top: 5),
                        width: 1,
                        height: 40,
                        color: Colors.black12),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              )),
                          SizedBox(height: 10),
                          Container(
                            padding: EdgeInsets.only(left: 20, right: 20),
                            child: Stack(
                              children: <Widget>[
                                TextField(
                                  controller: _passwordController,
                                  keyboardType: TextInputType.text,
                                  style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 15,
                                  ),
                                  //maxLength: 160,
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    //icon: Icon(Icons.phone),
                                    contentPadding:
                                        const EdgeInsets.only(right: 60.0),
                                    border: InputBorder.none,
                                    filled: true,
                                    
                                    fillColor: Color(0xffebebeb),
                                    hintText: "ادخل كلمة السر",
                                    hintStyle: TextStyle(
                                        color: Colors.black26, fontSize: 12),
                                  ),
                                ),
                                Container(
                                    width: 45,
                                    height: 50,
                                    alignment: Alignment.center,
                                    child: Image(
                                      image: AssetImage("images/entercode.png"),
                                      width: 30,
                                      height: 30,
                                    )),
                                Positioned(
                                  top: 5,
                                  right: 47,
                                  child: Container(
                                      padding: EdgeInsets.only(top: 5),
                                      width: 1,
                                      height: 40,
                                      color: Colors.black12),
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: 15),
                          isLoading == true
                              ? CircularProgressIndicator()
                              : Container(),
                          Text(
                            "$message",
                            style: TextStyle(color: Colors.red, fontSize: 13),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          GestureDetector(
                            onTap: () {
                              String email, password;
                              if (_emailController.text.trim() != "" &&
                                  _passwordController.text.trim() != "") {
                                setState(() {
                                  isLoading = true;
                                });

                                email = _emailController.text.trim();
                                password = _passwordController.text.trim();
                                loginData(email, password);
                              }
                            },
                            child: Container(
                              alignment: Alignment.center,
                              width: 100,
                              height: 50,
                              color: Theme.of(context).primaryColor,
                              child: Text("ارسال",
                                  style:
                                      TextStyle(fontSize: 20, color: Colors.white)),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ]),
                      ),
                    ),
                ),
              ],
            ),
      )
    );
  }

  loginData(String email, String password) async {
    PushNotificationsManager pushNotificationsManager = PushNotificationsManager();
    final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
    String firetoken = await _firebaseMessaging.getToken();
    print("FirebaseMessaging token: $firetoken");
    try {
      var url =
          "https://afkarestithmar.com/api/api.php?type=login&username=$codeNational$email&pass=$password&firebaseAcess=$firetoken";
      var request = await http.get(url);
      print(request.body);
      var data = jsonDecode(request.body);

      _saveTok(data['token']);
      _savechatId(data['chatfriendID']);
      _savetype(data['type']);
      _saveId(data['id']).then((v){
        if ("${data['success']}" == "1") {
          data['type'] == "think"?pushNotificationsManager.thinkerSubscription():pushNotificationsManager.investorSubscription();
        getDataId(context , user_id: data['id'] ).then((v){
          Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => MyApp()),
          (Route<dynamic> route) => false,
        );
        });
      } else {
        setState(() {
          isLoading = false;
          message = data['message'];
        });
      }
      });
      
    } catch (e) {
      print(e);
      setState(() {
        isLoading = false;
        message = "Error From Server or Network";
      });
    }
  }

  _saveTok(token) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = token;
    prefs.setString(key, value);
    print("saved in prefren token : $token");
  }

  Future _saveId(id) async {
    AppState appState = Provider.of<AppState>(context,listen: false);
    final prefs = await SharedPreferences.getInstance();
    final key = 'id';
    final value = id;
    prefs.setString(key, value);
    appState.setid(id);
    print("saved in prefren id : $id");
  }

  _savechatId(chatid) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'chatid';
    final value = chatid;
    prefs.setString(key, value);
    print("saved in prefren chatid : $chatid");
  }
  _savetype(typer) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'type';
    final value = typer;
    prefs.setString(key, value);
    print("saved in prefren typer : $typer");
   }
}

