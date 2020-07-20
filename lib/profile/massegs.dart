import 'dart:convert';
import 'package:afkar/AppBar1.dart/appBar2.dart';
import 'package:afkar/profile/profile.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'chat.dart';


class Massegs extends StatefulWidget{
  final String id;
  Massegs(this.id);

  @override
  _MassegsState createState() => _MassegsState(this.id);
}

class _MassegsState extends State<Massegs> {
  
  List listLast=[];
  List idLast =[];
  List list = [];
  String id;


  _MassegsState(this.id);
  @override
  void initState() {
    getData(id);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:appBar3(context,"الرسائل"),
      body: Container(
        width:MediaQuery.of(context).size.width,
          height:MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              ListView.builder(
                shrinkWrap: true,
                  itemCount: list.length,
                  itemBuilder: (context , index){
                    return customCard(context , list[index] , listLast , idLast);
                  },
                
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget cardes(String imgurl , String userID){
    return GestureDetector(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>Profile(id,userID)));
          },
          child: Container(
                        padding: EdgeInsets.all(5),
                        width: 70,
                        height: 70,
                        child: ClipRRect(
                                        borderRadius: BorderRadius.circular(100),
                                        child: CachedNetworkImage(
                                          fit: BoxFit.fill,
                                   imageUrl: "$imgurl",
                           placeholder: (context, url) => Container(
                             padding: EdgeInsets.all(30),
                             child:CircularProgressIndicator(),),
                          errorWidget: (context, url, error) => Image(image: AssetImage("images/profile.png")),
                                        )),
                      ),
    );
  }

  Widget customCard(BuildContext context , var dout , List listLast , List idLast){
    String userId = dout["username"];
    String name = dout["fullname"];
    print(dout["image"]);
    String img = dout["image"];
    int unReadedCount = dout["unread_messages_count"];
    String myId = id;
    String userchatId = dout["userID"];
    var lastmessage;
    // print("user id :$userchatId");
    // print(listLast);
    if(idLast.contains(userId)){
      int index;
      for(int i =0 ;i< idLast.length; i++){
        if(idLast[i] == userId ){
          index = i;
          break;
        }
      }
       lastmessage = listLast[index];
    }
    else{
      lastmessage = "";
    }
    
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>Chat(myId,userId,userchatId,name)));
      },
          child: Container(
                margin: EdgeInsets.all(5),
                padding: EdgeInsets.only( left: 20 , right: 20),
                decoration: BoxDecoration(
                  boxShadow:[
                    BoxShadow(color: Color(0xfff6f6f6), spreadRadius: 2)
                  ]
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children:<Widget>[
                    Container(
                      padding: EdgeInsets.only(top:10 , bottom: 10),
                      child: Row(children: <Widget>[
      Container(
        margin: EdgeInsets.only(left:15),
        width: 50,
        height:50,
        decoration: BoxDecoration(
          boxShadow:[
                      BoxShadow(color: Colors.black12, spreadRadius: 2)
                  ],
          borderRadius: BorderRadius.circular(25),
        ),
        child: GestureDetector(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>Profile(myId , userId)));
          },
                  child: ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: CachedNetworkImage(
                                    fit: BoxFit.fill,
                             imageUrl: "$img",
                     placeholder: (context, url) => Container(
                       padding: EdgeInsets.all(30),
                       child:CircularProgressIndicator(),),
                    errorWidget: (context, url, error) => Image(image: AssetImage("images/profile.png")),
                                  )),
        )
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:<Widget>[
          Text("$name" ,style: TextStyle(color: Colors.black54 , fontSize:14,fontWeight: FontWeight.w500),),
          Container(
            width: 200,
            child: Text("$lastmessage",overflow: TextOverflow.ellipsis,textAlign: TextAlign.start ,style: TextStyle(color: Colors.black54 , fontSize:12),)),
        ]
      )
                      ],),
                    ),
                    Column(
                      children: <Widget>[
                        unReadedCount > 0 ? Container(
                          alignment: Alignment.center,
                          width: unReadedCount>999?35:25,
                          height: 25,
                          margin: EdgeInsets.only(bottom:20),
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(15)
                          ),
                          child: Text("$unReadedCount" , style: TextStyle(color: Colors.white , fontSize: 12),),
                        ):Container(),
                        // Container(
                        //   alignment: Alignment.bottomCenter,
                        //   child: Text("01:20",textAlign: TextAlign.end ,style: TextStyle(color: Colors.black54 , fontSize:10),),
                        // ),
                      ],
                    )
                  ]
                ),
              ),
    );
  }

  getData(String id) async{
    try{var url = "https://afkarestithmar.com/chat2/servicesapis.php?ApiType=getUsers&userID=$id";
        var request = await http.get(url);
        //print(request.body);
        var data = jsonDecode(request.body);
        
        setState(() {
          list = data[1];
        });
        int s = list.length, i =0;
        while(i < s){
        getonChatData(id,list[i]["username"]);
        i++;
        }
        
      }catch(e){
      print(e);
    }
  }

  getonChatData(String myid , String userId) async{
    try{var url = "https://afkarestithmar.com/chat2/servicesapis.php?ApiType=getChat&username=$myid&%20to_username=$userId";
        var request = await http.get(url);
        //print(request.body);
        var data = json.decode(utf8.decode(request.bodyBytes));
        print(data);
        List listdata = data["items"];
        setState(() {
          if(listdata.length > 0){
            setState(() {
              listLast.add(listdata[listdata.length-1]["msg"]);
              idLast.add(listdata[listdata.length-1]["tusername"]);
            });
          }
        });
      }catch(e){
      print(e);
    }
  }
  
}
