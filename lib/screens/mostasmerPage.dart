
import 'package:afkar/AppBar1.dart/appBar2.dart';
import 'package:flutter/material.dart';

class MostasmerPage extends StatelessWidget{
  final String name;
  MostasmerPage(this.name);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: Color(0xfff5f5f5),
      appBar:appBar3(context,"$name"),
      body:Container(
        margin: EdgeInsets.only(top:5),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height-5,
        child: SingleChildScrollView(
            child: Column(
            children:<Widget>[
              messagesCard(context),
              SizedBox(height:30),
              Container(
                color: Colors.white,
                              child: Column(
                children:<Widget>[
                  SizedBox(height:10),
                  Container(
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.all(10),
                    child: Text("عن $name",style: TextStyle(fontSize:16,color:Colors.black54 ),)),
                  SizedBox(height:10),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Text("هنا تكتب تفاصيل العرض المراد تسليمه هنا تكتب تفاصيل العرض المراد تسليمه هنا تكتب تفاصيل العرض المراد تسليمه هنا تكتب تفاصيل العرض المراد تسليمه",style: TextStyle(fontSize:13,color:Colors.black54 ),)),
                    SizedBox(height:20),
                    Row(
                        mainAxisAlignment:MainAxisAlignment.spaceEvenly,
                        children:<Widget>[
                        Container(
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width*0.4,
                          height: 60,
                          color: Theme.of(context).primaryColor,
                          child: Text("طلب عرض الفكرة" ,style:TextStyle(fontSize:16 , color: Colors.white)),
                        ),
                        Container(
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width*0.4,
                          height: 60,
                          color: Theme.of(context).primaryColor,
                          child: Text("طلب تمويل الفكرة" ,style:TextStyle(fontSize:16, color: Colors.white)),
                        ),
                        ]
                      ),
                      SizedBox(height:30),
                ]
            ),
              ),
            ]
          ),
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
            spreadRadius: 20,
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
                  child: Image(image: AssetImage("images/profileimg.png")),
                ),
                SizedBox(width:10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("محمد احمد" , style: TextStyle(color:Colors.black54, fontSize: 14),),
                    Text("@moh232423" , style: TextStyle(color:Colors.black54, fontSize: 12),),
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
}