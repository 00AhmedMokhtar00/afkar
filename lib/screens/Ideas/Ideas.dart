import 'package:afkar/AppBar1.dart/appBar2.dart';
import 'package:afkar/screens/orders/order_details.dart';
import 'package:flutter/material.dart';

import 'Idea_details.dart';

class Ideas extends StatefulWidget{
  @override
  _IdeasState createState() => _IdeasState();
}

class _IdeasState extends State<Ideas> {

    void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
     return Scaffold(
      backgroundColor: Color(0xfff4f4f4),
      appBar:appBar3(context , "الافكار"),
      body:Container(
        margin: EdgeInsets.only(top:5),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height-5,
        child: ListView.builder(
          itemCount: 5,
          itemBuilder: (context, i){
            return orderCard(context, "#1524", "طلب دراسه جدوي للمشروع", "about",Colors.green
            ,"20-10-2010",'اقتصاد','150 ر٠س');
          },
        ),
      )
     );
  }



   Widget orderCard(BuildContext context, String orderNumber , String name , String about ,Color orderColor,
   String date,String cat,String price){
    //AppState appState = Provider.of<AppState>(context);
    return GestureDetector(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>IdeaDetails()));
        },
          child: Container(
        padding: EdgeInsets.only(left:5,right: 5),
        margin: EdgeInsets.all(4),
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width,
        height:100,
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
                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(2),
                                      child: Container(
                                        width: 62,
                                        height: 62,
                                        color:orderColor,
                                        child:Center(child:Text("$orderNumber",style: TextStyle(color: Colors.white),))
                                      ),
                                  ),
                ),
                SizedBox(width:10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(width: MediaQuery.of(context).size.width-100,
                    child: ListTile(
                 title: Text("$name" , style: TextStyle(color:Colors.black54, fontSize: 13),),
                  
                  trailing :Container(width: 80,
                  child: Row(
                    children: <Widget>[
                     Icon(Icons.monetization_on,color: Colors.black38,size: 20,),
                    Column(children: <Widget>[
                       Text("100%",style: TextStyle(fontSize: 12),),
                       Text("حصه المستسمر",style: TextStyle(fontSize: 8),)

                    ],) ],)),
                  )),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                    subTitleWidget(date,Icon(Icons.date_range,color: Colors.black38,size: 20,),),
                    subTitleWidget(cat,Icon(Icons.category,color: Colors.black38,size: 20),),
                    subTitleWidget(price,Icon(Icons.monetization_on,color: Colors.black38,size: 20),),
                    ],)
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

Widget subTitleWidget(value,Icon icon){
  return Container(width: MediaQuery.of(context).size.width/4.2,
                     child:Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                       children: <Widget>[
                         icon,
                 
                 SizedBox(width: 2,),
                  Text("$value" , style: TextStyle(color:Colors.black54, fontSize: 12),),
                 ],),
                    );
}
}