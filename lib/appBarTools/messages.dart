import 'package:afkar/AppBar1.dart/appBar2.dart';
import 'package:afkar/screens/mostasmerPage.dart';
import 'package:flutter/material.dart';

class Messages extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:appBar3(context,"الرسائل"),
      body:Container(
        margin: EdgeInsets.only(top:5),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height-5,
        child: ListView(
          children:<Widget>[
            messagesCard(context),
            messagesCard(context),
            messagesCard(context),
            messagesCard(context),
          ]
        ),
      )
    );
  }
  Widget messagesCard(BuildContext context){
    return GestureDetector(
        onTap: (){
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
                GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>MostasmerPage("محمد احمد")));
                  },
                                  child: Container(
                    decoration: BoxDecoration(
                      shape:BoxShape.circle,
                    ),
                    child: Image(image: AssetImage("images/profileimg.png")),
                  ),
                ),
                SizedBox(width:10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("محمد احمد" , style: TextStyle(color:Colors.black54, fontSize: 14),),
                    Text("شكرا علي الفكرة الجميلة" , style: TextStyle(color:Colors.black54, fontSize: 12),),
                  ],
                ),
              ],
            ),
            Container(
              height: 60,
            child: Text("05:00pm" , style: TextStyle(color:Colors.black54, fontSize: 13),)),
          ],
        ),
      ),
    );
  }
}