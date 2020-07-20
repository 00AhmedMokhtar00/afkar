import 'dart:convert';
import 'dart:io';
import 'package:afkar/login.dart';
import 'package:afkar/screens/articles.dart';
import 'package:afkar/screens/verifyAccount.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
    try{var url = "https://afkarestithmar.com/api/api.php?type=reginvest&phone=${widget.phone}&pass=${widget.pass}&name=${widget.name}&email=${widget.email}&address=&about=${conAbout.text}&price=1&domain_id=1";
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