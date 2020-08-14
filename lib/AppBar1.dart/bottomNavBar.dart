
import 'package:afkar/main.dart';
import 'package:afkar/profile/profile.dart';
import 'package:afkar/screens/addMofaker.dart';
import 'package:afkar/screens/ideasInestor.dart';
import 'package:afkar/screens/ideasThatAccepted.dart';
import 'package:afkar/screens/mofakereen.dart';
import 'package:afkar/screens/mostasmerList.dart';
import 'package:afkar/screens/talabaty.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Widget bottomNvBar(BuildContext context , {int index}){
  AppState appState =Provider.of<AppState>(context,listen: false);
  print("MMMMMMMMMMM: " + index.toString());
  return Container(
        width:MediaQuery.of(context).size.width,
        height: 60,
        color: Theme.of(context).primaryColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            GestureDetector(
              onTap: (){
                if(index != 1) {
                appState.gettyper != "think"? Navigator.push(context, MaterialPageRoute(builder: (context)=>IdeasInvestors())):Navigator.push(context, MaterialPageRoute(builder: (context)=>AddMofaker()));
               }
              },
              child: Container(
              width:MediaQuery.of(context).size.width*0.23,
              height: 60,
              color: index == 1 ? Colors.black12 : Theme.of(context).primaryColor,
              child: appState.gettyper != "think"?
              Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:<Widget>[
                  Image(image: AssetImage("images/add.png"),width: 35,height: 30,),
                  Text("افكار جديدة" , style: TextStyle(color:Colors.white70, fontSize: 12),),
                  ]
                ):Image(image: AssetImage("images/add.png"),width: 50,height: 50,)),
            ),
            Container(color: Color(0xffe2e2e2),height: 40,width: 1,),
            GestureDetector(
              onTap:(){
                if(index != 2)
               {appState.gettyper != "think"?Navigator.push(context, MaterialPageRoute(builder: (context)=>IdeasThatAccepted())):Navigator.push(context, MaterialPageRoute(builder: (context)=>Talabaty()));}
              },
              child: Container(
                width:MediaQuery.of(context).size.width*0.25,
              height: 60,
              color: index == 2 ? Colors.black12 : Theme.of(context).primaryColor,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:<Widget>[
                  Image(image: AssetImage("images/order.png"),width: 35,height: 30,),
                  Text(appState.gettyper != "think"?" تم الموافقة":"طلباتي" , style: TextStyle(color:Colors.white70, fontSize: 12),),
                  ]
                ),
              ),
            ),
            Container(color: Color(0xffe2e2e2),height: 40,width: 1,),
            GestureDetector(
                onTap: (){
                  if(index != 3)
               {
                 appState.gettyper != "think"?Navigator.push(context, MaterialPageRoute(builder: (context)=>Mofakereen())) : Navigator.push(context, MaterialPageRoute(builder: (context)=>MostasmerList()));}
               
                },
                              child: Container(
                  width:MediaQuery.of(context).size.width*0.25,
            height: 60,
            color: index == 3 ? Colors.black12 : Theme.of(context).primaryColor,
                  child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:<Widget>[
                  Image(image: AssetImage("images/Investor.png"),width: 35,height: 30,),
                  Text(appState.gettyper != "think"?"المفكرين":"المستثمرين" , style: TextStyle(color:Colors.white, fontSize: 12),),
                  ]
            ),
                ),
              ),
            Container(color: Color(0xffe2e2e2),height: 40,width: 1,),
            GestureDetector(
              onTap: ()
              {Navigator.push(context, MaterialPageRoute(builder: (context)=>Profile(appState.getid,appState.getid)));},
                          child: Container(
                width:MediaQuery.of(context).size.width*0.25,
              height: 60,
              color: index == 4 ? Colors.black12 : Theme.of(context).primaryColor,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:<Widget>[
                  Image(image: AssetImage("images/profile.png"),width: 30,height: 28,),
                  Text("صفحتي" , style: TextStyle(color:Colors.white, fontSize: 12),),
                  ]
                ),
              ),
            ),
          ],
        ),
      );
}