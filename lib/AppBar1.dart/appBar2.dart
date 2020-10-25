
import 'package:afkar/screens/articles.dart';
import 'package:flutter/material.dart';

Widget appBar2(BuildContext context , String title , String image){
  return AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back_ios),
        color: Colors.black54,
         onPressed: (){
          Navigator.pop(context);
        }),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children:<Widget>[
            Spacer(flex:1),
            Image(image: AssetImage("$image"),width: 35,height: 35,),
            Text("$title" , style: TextStyle(color:Colors.white),),
            Spacer(flex:2)
          ]
        ),
      );
}


Widget appBar3(BuildContext context , String title, {bool back = true, toMain = false}){
    return AppBar(
    centerTitle: true,
        automaticallyImplyLeading: false,
        leading: back?IconButton(icon: Icon(Icons.arrow_back_ios),
        color: Colors.black54,
         onPressed: (){
          if(toMain){
            Navigator.push(context, MaterialPageRoute(builder: (_) => Articles()));
          }else {
            Navigator.pop(context);
          }
        }):null,
        title: Text("$title" , style: TextStyle(color:Colors.white),),
      );
}