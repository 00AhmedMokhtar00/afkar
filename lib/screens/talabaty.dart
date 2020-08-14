
import 'dart:convert';
import 'package:afkar/main.dart';
import 'package:afkar/screens/offers.dart';
import 'package:http/http.dart' as http;
import 'package:afkar/AppBar1.dart/appBar2.dart';
import 'package:afkar/AppBar1.dart/bottomNavBar.dart';
import 'package:afkar/screens/offersVerefied.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class Talabaty extends StatefulWidget{
  @override
  _TalabatyState createState() => _TalabatyState();
}

class _TalabatyState extends State<Talabaty> {
  List<String> names =[];
    List<String> ids =[];
    @override
  void initState() {
    getTalabaty(context);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff4f4f4),
      appBar:appBar3(context , "طلباتي"),
      bottomNavigationBar: bottomNvBar(context , index:2) ,
      body:Container(
        margin: EdgeInsets.only(top:5),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height-5,
        child: Container(
        margin: EdgeInsets.only(top:5),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height-5,
        child: ListView.builder(
          itemCount: names.length,
          itemBuilder: (context, i){
            return talabatyCard(context, names[i] , ids[i]);
          },
        ),
      )
      )
    );
  }
  Future getTalabaty(BuildContext context )async{
    AppState appState = Provider.of<AppState>(context,listen: false);
    try{var url = "https://afkarestithmar.com/api/api.php?type=myrequests&user_id=${appState.getid}";
        var request = await http.get(url);
        var data = jsonDecode(request.body);

        if("${data['success']}"== "1"){
          print(data);
          for (var i = 0; i < data["allrequests"].length; i++) {
             names.add(data["allrequests"][i]["title"]);
             ids.add("${data["allrequests"][i]["id"]}");
          }
          setState(() {
            
          });
        } 
    }catch(e){
      print(e);
    }
}

  Widget talabatyCard(BuildContext context , String name ,String id){
    return GestureDetector(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>Offers(id)));
        },
          child: Container(
        padding: EdgeInsets.all(20),
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width,
        height: 90,
        decoration: BoxDecoration(
          boxShadow:[
            BoxShadow(
            color: Color(0xfff4f4f4),
            spreadRadius: 2,
            )
          ],
          color: Colors.white
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(name.length > 25? name.substring(0,24)+" ...":name, style: TextStyle(color:Colors.black54, fontSize: 15),),
            Text("#$id" , style: TextStyle(color:Colors.black54, fontSize: 15),),
          ],
        ),
      ),
    );
  }
  
}