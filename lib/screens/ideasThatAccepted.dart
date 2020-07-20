
import 'dart:convert';
import 'package:afkar/main.dart';
import 'package:afkar/screens/ideasDetails.dart';
import 'package:afkar/screens/ideasThatAcceptedDetails.dart';
import 'package:http/http.dart' as http;
import 'package:afkar/AppBar1.dart/appBar2.dart';
import 'package:afkar/AppBar1.dart/bottomNavBar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class IdeasThatAccepted extends StatefulWidget{
  @override
  _IdeasThatAcceptedState createState() => _IdeasThatAcceptedState();
}

class _IdeasThatAcceptedState extends State<IdeasThatAccepted> {
  List<String> titles =[];
  List<String> names =[];
  List<String> ids =[];
  List<String> detailses =[];
  List<String> domains =[];
  List<String> pres =[];
  List<String> proposals =[];
    @override
  void initState() {
    getallideas(context);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff4f4f4),
      appBar:appBar3(context , "الافكار اللتي تم قبولها"),
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
          itemCount: titles.length,
          itemBuilder: (context, i){
            return ideasThatAcceptedCard(context, titles[i] , names[i] , ids[i] , detailses[i] , domains[i] , pres[i] , proposals[i]);
          },
        ),
      )
      )
    );
  }
  Future getallideas(BuildContext context )async{
    AppState appState = Provider.of<AppState>(context,listen: false);
    try{var url = "https://afkarestithmar.com/api/api.php?type=afkaraccepted&user_id=${appState.getid}";
        var request = await http.get(url);
        var data = jsonDecode(request.body);

        if("${data['success']}"== "1"){
          print(data);
          for (var i = 0; i < data["allideas"].length; i++) {
             titles.add(data["allideas"][i]["title"]);
             names.add(data["allideas"][i]["uname"]);
             ids.add("${data["allideas"][i]["id"]}");
              detailses.add("${data["allideas"][i]["details"]}");
              domains.add("${data["allideas"][i]["domain_name"]}");
              pres.add("${data["allideas"][i]["invest_per"]}");
              proposals.add("${data["allideas"][i]["proposed_price"]}");
          }
          setState(() {
            
          });
        } 
    }catch(e){
      print(e);
    }
}

  Widget ideasThatAcceptedCard(BuildContext context ,String title , String name ,String id , String details , String domain , String pre ,String proposel){
    return GestureDetector(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>IdeasThatAcceptedDetails(id , name , details , domain , pre , proposel)));
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
            Container(
              width: MediaQuery.of(context).size.width*0.76,
              child: Text("$title" , style: TextStyle(color:Colors.black54, fontSize: 15),)),
            Text("#$id" , style: TextStyle(color:Colors.black54, fontSize: 15),),
          ],
        ),
      ),
    );
  }
  
}