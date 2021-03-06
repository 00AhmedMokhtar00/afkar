import 'dart:convert';
import 'dart:io';
import 'package:afkar/alerts/alerts.dart';
import 'package:afkar/firebase/push_notifications.dart';
import 'package:afkar/login.dart';
import 'package:afkar/screens/verifyAccount.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../HomePage.dart';

class Reg2 extends StatefulWidget{
  final File image;
  final String name ;
  final String phone ;
  final String email ;
  final String pass ;
  Reg2(this.image , this.name ,this.phone , this.email , this.pass);

  @override
  _Reg2State createState() => _Reg2State();
}

class _Reg2State extends State<Reg2> {
  TextEditingController conAbout = TextEditingController();

  bool isLoading = false;
  String message = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff4f4f4),
      appBar:AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back_ios),
        color: Colors.black54,
         onPressed: (){
          Navigator.pop(context);
        }),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children:<Widget>[
            Spacer(flex:1),
            Image(image: AssetImage("images/Investor2.png"),width: 40,height: 40,),
            Text("مستثمر" , style: TextStyle(color:Colors.white),),
            Spacer(flex:2)
          ]
        ),
      ),
      body:Container(
        alignment:Alignment.center,
        child: Container(
        width: MediaQuery.of(context).size.width*0.9,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child:Column(
            
            children:<Widget>[
              SizedBox(height:15),
              TextField(
                      controller: conAbout,
                      keyboardType: TextInputType.text,
                      style: TextStyle(color: Colors.black54, fontSize: 15 ,) ,
                      maxLines: 12,
                      //maxLength: 160,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(10.0),
                        border: InputBorder.none,
                        filled: true,
                        fillColor: Color(0xffffffff),
                        hintText: "نبذة",
                        hintStyle:
                            TextStyle(color: Colors.black26, fontSize: 15),
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
                      onTap: (){
                        if(conAbout.text.trim() != ""){
                          setState(() {
                            isLoading = true;
                          });
                          reg(context);
                        }
                      },
                        child: Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width*0.9,
                        height: 45,
                        color: Theme.of(context).primaryColor,
                        child: Text("تسجيل" ,style:TextStyle(fontSize:17 , color: Colors.white)),
                      ),
                    ),
            ]
          )
        ),
        ),
      ),
    );
  }
  Future reg(BuildContext context)async{
    PushNotificationsManager pushNotificationsManager = PushNotificationsManager();
    try{
      String url = "https://afkarestithmar.com/api/api.php?type=reginvest&phone=${widget.phone.trim()}&pass=${widget.pass.trim()}&name=${widget.name.trim()}&email=${widget.email.trim()}&address=adress&about=${conAbout.text.trim()}&price=1&domain_id=1";
        var request = await http.get(url);
        var data = jsonDecode(request.body);
        print(request.body);

        if(data['success'] == "1"){
          pushNotificationsManager.investorSubscription();
          Navigator.push(context, MaterialPageRoute(builder: (context)=>VerifyAccount(id: data["user_id"].toString(), token: data["token"],)));
        } else{
          await alertTost(data['message']);
          Navigator.push(context, MaterialPageRoute(builder: (_) => HomePage()));
          setState(() {
            isLoading = false;
            message = "${data['message']}";
          });
        }
    }catch(e){
      print("CATCH ERROR: " + e.toString());
      await alertTost(e.toString());
      Navigator.push(context, MaterialPageRoute(builder: (_) => HomePage()));
      setState(() {
        isLoading = false;
        message = "$e";
      });
    }
}
}