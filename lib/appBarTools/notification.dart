import 'package:afkar/AppBar1.dart/appBar2.dart';
import 'package:flutter/material.dart';

class Notifications extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:appBar3(context,"التنبيهات"),
      body:Container(
        margin: EdgeInsets.only(top:5),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height-5,
        child: ListView(
          children:<Widget>[
            doneCard(context),
            manangerCard(context),
            doneCard(context),
            manangerCard(context),
          ]
        ),
      )
    );
  }
  Widget doneCard(BuildContext context){
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
                Container(
                  decoration: BoxDecoration(
                    shape:BoxShape.circle,
                  ),
                  child: Image(image: AssetImage("images/idea.png")),
                ),
                SizedBox(width:10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("تم بنجاح" , style: TextStyle(color:Colors.black54, fontSize: 14,fontWeight: FontWeight.w600),),
                    Text("طلب @٦٤٣٦ تمويل لمشروعه" , style: TextStyle(color:Colors.black54, fontSize: 10),),
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
  Widget manangerCard(BuildContext context){
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
                Container(
                  decoration: BoxDecoration(
                    shape:BoxShape.circle,
                  ),
                  child: Image(image: AssetImage("images/w.png")),
                ),
                SizedBox(width:10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("تنبيه اداري" , style: TextStyle(color:Colors.black54, fontSize: 14,fontWeight: FontWeight.w600) ,),
                    Text("يرجي تحديث معلوماتك الشخصية واكمال الملف الشخصي" , style: TextStyle(color:Colors.black54, fontSize: 10),),
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