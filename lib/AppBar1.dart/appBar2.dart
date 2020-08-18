
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


Widget appBar3(BuildContext context , String title){
    return AppBar(
    centerTitle: true,
        leading: IconButton(icon: Icon(Icons.arrow_back_ios),
        color: Colors.black54,
         onPressed: (){
          //Navigator.push(context, MaterialPageRoute(builder: (_) => Articles()));
          Navigator.pop(context);
        }),
        title: Text("$title" , style: TextStyle(color:Colors.white),),
      );
}