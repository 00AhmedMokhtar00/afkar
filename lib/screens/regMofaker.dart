

import 'dart:convert';
import 'package:afkar/login.dart';
import 'package:afkar/screens/verifyAccount.dart';
import 'package:http/http.dart' as http;
import 'package:afkar/AppBar1.dart/appBar2.dart';
import 'package:afkar/screens/articles.dart';
import 'package:country_code_picker/country_code_picker.dart';

import 'package:flutter/material.dart';

class RegMofaker extends StatefulWidget{
  @override
  _RegMofakerState createState() => _RegMofakerState();
}

class _RegMofakerState extends State<RegMofaker> {
  String message = "";
  String codeNational = "";
  bool isLoading = false;
  TextEditingController conName = TextEditingController();
  TextEditingController conPass = TextEditingController();
  TextEditingController conRePass = TextEditingController();
  TextEditingController conPhone = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff4f4f4),
      appBar:appBar3(context, "مفكر"),
      body:Container(
        alignment:Alignment.center,
        child: Container(
        width: MediaQuery.of(context).size.width*0.9,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child:Column(
            
            children:<Widget>[
              TextField(
                controller: conName,
                      keyboardType: TextInputType.text,
                      style: TextStyle(color: Colors.black54, fontSize: 15 ,),textAlign: TextAlign.center ,
                      maxLines: 1,
                      // maxLength: 160,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(10.0),
                        border: InputBorder.none,
                        filled: true,
                        fillColor: Color(0xffffffff),
                        hintText: "الاسم كاملا",
                        hintStyle:
                            TextStyle(color: Colors.black26, fontSize: 15),
                      ),
                    ),
                    SizedBox(height:10),
                    Container(
                             // padding: EdgeInsets.only(left: 20, right: 20),
                              child: Row(
                                children: <Widget>[
                                  Container(
                                  padding: EdgeInsets.only(left: 15),
                                    alignment: Alignment.center,
                                    color: Colors.white,
                                    child: CountryCodePicker(
                                      onChanged: (val) {
                                        setState(() {
                                          codeNational = val.dialCode;
                                        });
                                      },
                                      // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                                      initialSelection: 'IT',
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
                                          controller: conPhone,
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
                  fillColor: Colors.white,
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
                    SizedBox(height:10),
                    TextField(
                      controller: conPass,
                      keyboardType: TextInputType.text,
                      style: TextStyle(color: Colors.black54, fontSize: 15 ,),textAlign: TextAlign.center ,
                      maxLines: 1,
                      // maxLength: 160,
                      obscureText: true,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(10.0),
                        border: InputBorder.none,
                        filled: true,
                        fillColor: Color(0xffffffff),
                        hintText: "كلمة المرور",
                        hintStyle:
                            TextStyle(color: Colors.black26, fontSize: 15),
                      ),
                    ),
                    SizedBox(height:10),
                    TextField(
                      controller: conRePass,
                      keyboardType: TextInputType.text,
                      style: TextStyle(color: Colors.black54, fontSize: 15 ,),textAlign: TextAlign.center ,
                      maxLines: 1,
                      // maxLength: 160,
                      obscureText: true,
                      decoration: InputDecoration(
                        
                        contentPadding: const EdgeInsets.all(10.0),
                        border: InputBorder.none,
                        filled: true,
                        fillColor: Color(0xffffffff),
                        hintText: "اعادة ادخال كلمة المرور",
                        hintStyle:
                            TextStyle(color: Colors.black26, fontSize: 15),
                      ),
                    ),
                    SizedBox(height:10),
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
                      onTap: (){
                       
                          if(conName.text.trim()!="" || conPhone.text.trim()!=""  ||
                          conPass.text.trim()!="" || conRePass.text.trim()!="" ){
                            if(conPass.text != conRePass.text){
                              setState(() {
                            message = "كلمة المرور غير متطابقة";
                          });
                            }else{
                              setState(() {
                                isLoading = true;
                              });
                              regesterMofaker(context);
                            }
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
  Future regesterMofaker(BuildContext context)async{
    try{var url = "https://afkarestithmar.com/api/api.php?type=regthink&phone=$codeNational&pass=${conPass.text}&name=${conName.text}";
        var request = await http.get(url);
        var data = jsonDecode(request.body);
        if("${data['success']}"== "1"){
          print(data);
          Navigator.push(context, MaterialPageRoute(builder: (context)=>VerifyAccount()));
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