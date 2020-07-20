
import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:afkar/AppBar1.dart/appBar2.dart';
import 'package:afkar/main.dart';
import 'package:afkar/profile/profile.dart';
import 'package:afkar/profile/viewPhoto.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:http/http.dart'as http;

class MostasmerList extends StatefulWidget{
  @override
  _MostasmerListState createState() => _MostasmerListState();
}

class _MostasmerListState extends State<MostasmerList> {
  List<String> names = [];
  List<String> images = [];
  List<String> abouts = [];
  List<String> ids = [];
  @override
  void initState() {
    getMostasmerList(context);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:appBar3(context,"المستثمرين"),
      body:Container(
        margin: EdgeInsets.only(top:5),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height-5,
        child: ListView.builder(
          itemCount: names.length,
          itemBuilder: (context, i){
            return messagesCard(context, images[i], names[i], abouts[i],ids[i]);
          },
        ),
      )
    );
  }

  Widget messagesCard(BuildContext context, String imgurl , String name , String about ,String userId ){
    AppState appState = Provider.of<AppState>(context);
    return GestureDetector(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>Profile(appState.id, userId)));
        },
          child: Container(
        padding: EdgeInsets.only(left:20,right: 20 , top: 10 , bottom: 10),
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
            Row(
              children: <Widget>[
                Container(
                  // decoration: BoxDecoration(
                  //   shape:BoxShape.circle,
                  // ),
                  child: GestureDetector(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>PhotoView(imgurl == null || imgurl == "" ? "http://matib.jaderplus.com/userfiles/5e6e6b8791988_profile.png":imgurl)));
                                  },
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(200),
                                      child: Container(
                                        width: 65,
                                        height: 65,
                                        child: CachedNetworkImage(
                                        fit: BoxFit.cover,
                           imageUrl: "$imgurl",
                   placeholder: (context, url) => Container(
                    padding: EdgeInsets.all(30),
                     child:CircularProgressIndicator(),),
                  errorWidget: (context, url, error) => Image(image: AssetImage("images/profile2.png")),
                   ),
                                      ),
                                  ),),
                ),
                SizedBox(width:10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("$name" , style: TextStyle(color:Colors.black54, fontSize: 14),),
                    Text("$about" , style: TextStyle(color:Colors.black54, fontSize: 12),),
                  ],
                ),
              ],
            ),
            Container()
          ],
        ),
      ),
    );
  }

  Future getMostasmerList(BuildContext context)async{
    try{var url = "https://afkarestithmar.com/api/api.php?type=users&tt=1";
        var request = await http.get(url);
        var data = jsonDecode(request.body);

        if("${data['success']}"== "1"){
          print(data);
          for (var i = 0; i < data["users"].length; i++) {
            names.add(data["users"][i]["Name"]);
            images.add(data["users"][i]["img"]);
            abouts.add(data["users"][i]["About"]);
            ids.add(data["users"][i]["Id"]);
          }
          setState(() {
            
          });
          
        } 
    }catch(e){
      print(e);
    }
}
}