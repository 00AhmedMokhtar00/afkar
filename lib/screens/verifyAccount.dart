

import 'dart:convert';
import 'package:afkar/alerts/alerts.dart';
import 'package:afkar/login.dart';
import 'package:http/http.dart' as http;
import 'package:afkar/AppBar1.dart/appBar2.dart';
import 'package:flutter/material.dart';

class VerifyAccount extends StatefulWidget{
  @override
  _VerifyAccountState createState() => _VerifyAccountState();
}

class _VerifyAccountState extends State<VerifyAccount> {
  String message = "";
  bool isLoading = false;

  TextEditingController conPhone = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:appBar3(context , "تفعيل الحساب" ),
      body:Container(
        alignment:Alignment.center,
        child: Container(
        width: MediaQuery.of(context).size.width*0.9,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child:Column(
            children:<Widget>[
                    TextField(
                      controller: conPhone,
                      keyboardType: TextInputType.text,
                      style: TextStyle(color: Colors.black54, fontSize: 15 ,),textAlign: TextAlign.center ,
                      maxLines: 1,
                      // maxLength: 160,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(10.0),
                        border: InputBorder.none,
                        filled: true,
                        fillColor: Color(0xffffffff),
                        hintText: "رقم الجوال",
                        hintStyle:
                            TextStyle(color: Colors.black26, fontSize: 15),
                      ),
                    ),
                    
                    GestureDetector(
                      onTap: (){
                          setState(() {
                            isLoading =true;
                          });
                          if(conPhone.text.trim()!="" ){
                              verifay(context);
                          }else{
                          setState(() {
                            message = "الرجاء ملئ جميع الحقول";
                          });
                          }
                      },
                        child: Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width*0.9,
                        height: 50,
                        color: Theme.of(context).primaryColor,
                        child: Text("الــتــالي" ,style:TextStyle(fontSize:17 , color: Colors.white)),
                      ),
                    ),
            ]
          )
        ),
        ),
      ),
    );
  }
  Future verifay(BuildContext context)async{
    try{var url = "https://afkarestithmar.com/api/api.php?type=confirmreg&phone=${conPhone.text}";
        var request = await http.get(url);
        var data = jsonDecode(request.body);
        if("${data['success']}"== "1"){
          print(data);
          alertTost("${data['message']}");
          Navigator.push(context, MaterialPageRoute(builder: (context)=>LogIn()));
        } 
    }catch(e){
      print(e);
      setState(() {
        isLoading = false;
        message = "$e";
      });
    }
  }
}