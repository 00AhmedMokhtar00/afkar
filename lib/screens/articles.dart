import 'dart:convert';
import 'package:afkar/screens/makalah.dart';
import 'package:http/http.dart' as http;
import 'package:afkar/AppBar1.dart/appBar1.dart';
import 'package:afkar/AppBar1.dart/bottomNavBar.dart';
import 'package:afkar/AppBar1.dart/drawer.dart';
import 'package:afkar/backEnd/getDataId.dart';
import 'package:flutter/material.dart';

class Articles extends StatefulWidget{
  @override
  _ArticlesState createState() => _ArticlesState();
}

class _ArticlesState extends State<Articles> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  void initState() {
    getDataId(context).then((v){
      setState((){});
    });
    getTalabaty(context);
    super.initState();
  }
  List <String> titles = [];
  List <String> images = [];
  List <String> details = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: drawer(context),
      backgroundColor: Color(0xfff4f4f4),
      key: _scaffoldKey ,
      appBar:appBar(context , _scaffoldKey),
      bottomNavigationBar: bottomNvBar(context),
      body: Container(
        width:MediaQuery.of(context).size.width,
        height:MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child:Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(12),
              alignment: Alignment.center,
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image(image: AssetImage("images/posts.png"),width: 40,height: 40,),
                  SizedBox(width:5),
                  Text("مقالات عن الاستثمار" , style: TextStyle(color:Colors.black54, fontSize: 18),),
                ],
              ),
            ),
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: images.length,
              itemBuilder: (context , i){
                return makalat(context , titles[i],images[i],details[i]);
              },
           
           )

          ],)
        ),

      )
    );
  }

  Widget makalat(context , title , img , String detail){
    return Container(
              margin: EdgeInsets.only(top:10),
              color:Colors.white,
              width:MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.5,
              child: Column(
                children:<Widget>[
                  Container(
                    padding: EdgeInsets.only(top:10, bottom: 10 , right: 25),
                    alignment: Alignment.centerRight,
                    child:Text("$title" , style: TextStyle(color:Colors.black54, fontSize: 14))
                  ),
                  Container(
                  height: 220,
                  width: MediaQuery.of(context).size.width,  
                  child: Image(image: NetworkImage("https://afkarestithmar.com/$img"),fit: BoxFit.contain,)),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
              children:<Widget>[
                Container(
                          alignment: Alignment.center,
                          width:MediaQuery.of(context).size.width*0.63 ,
                          height: 68,
                          child: Text("$detail" ,style:TextStyle(fontSize:11 , color: Colors.black54)),
                        ),
                Container(color: Colors.black12,height: 70,width: 1,),
                GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>Makalah(title, img, detail)));
                    },
                                    child: Container(
                            alignment: Alignment.center,
                            width: 100,
                            height: 40,
                            color: Theme.of(context).primaryColor,
                            child: Text("عرض المزيد" ,style:TextStyle(fontSize:13 , color: Colors.white)),
                          ),
                ),

              ]
            ),
                    ),
                  )
                ]
              ),
            );
  }
  // https://afkarestithmar.com/api/api.php?type=allarticles
  Future getTalabaty(BuildContext context)async{
    try{var url = "https://afkarestithmar.com/api/api.php?type=allarticles";
        var request = await http.get(url);
        var data = jsonDecode(request.body);

        if("${data['success']}"== "1"){
          for (var i = 0; i < data["articles"].length; i++) {
             titles.add(data["articles"][i]["title"]);
             images.add(data["articles"][i]["img"]);
             details.add(data["articles"][i]["details"]);
          }
          setState(() {
            
          });
        } 
    }catch(e){
      print(e);
    }
}
}