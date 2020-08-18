import 'package:afkar/AppBar1.dart/appBar2.dart';
import 'package:flutter/material.dart';

class OrdersDetails extends StatefulWidget{
  @override
  _OrdersDetailsState createState() => _OrdersDetailsState();
}

class _OrdersDetailsState extends State<OrdersDetails> {

    void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
     return Scaffold(
      backgroundColor: Color(0xfff4f4f4),
      appBar:appBar3(context , "#1524"),
       body:Container(
        margin: EdgeInsets.only(top:5),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height-5,
        child: ListView(children: <Widget>[
          orderCard(context, "#1524", "طلب دراسه جدوي للمشروع", "about",Colors.green
            ,"20-10-2010",'اقتصاد','150 ر٠س'),

            Container(margin: EdgeInsets.all(5),
         color: Colors.white,
            padding: EdgeInsets.all(10),
            height: 170,
            child:Center(child: Column(children: <Widget>[
Icon(Icons.monetization_on,size: 50,),
Text("356",style: TextStyle(fontSize: 25),),
Text("السعر المطلوب")

            ],),)),

              Container(
                margin: EdgeInsets.all(5),
         color: Colors.white,
            padding: EdgeInsets.all(10),
            height: 50,
            child:Row(children: <Widget>[
              Icon(Icons.local_offer),
              Text("العروض"),


            ])
            
              ),
              widgetOffers(),
widgetOffers(),

 Container(
                margin: EdgeInsets.all(5),
         color: Colors.white,
            padding: EdgeInsets.all(10),
            height: 50,
            child:Row(children: <Widget>[
              Icon(Icons.local_offer),
              Text("المرفقات"),
            ])
            
              ),
              Container(
color: Colors.white,
                child:ListTile(leading: Icon(Icons.content_paste),
              title: Text("مرفق رقم ١",style: TextStyle(fontSize: 15),),
              trailing: Icon(Icons.arrow_downward),)
              ),
                Container(
color: Colors.white,
margin: EdgeInsets.all(10),
                child:ListTile(leading: Icon(Icons.content_paste),
              title: Text("مرفق رقم ١",style: TextStyle(fontSize: 15),),
              trailing: Icon(Icons.arrow_downward),)
              )
          ])

      )
     );
  }

Widget widgetOffers(){
  return Container(
    color: Colors.white,
        padding: EdgeInsets.only(left:5,right: 5),
        margin: EdgeInsets.all(4),
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width,
        height:100,
        child: ListTile(leading:  Container(
                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(2),
                                      child: Container(
                                        width: 70,
                                        height: 70,
                                        color:Colors.orange,
                                        child:Center(child:Image.asset('images/message.png'),))
                                      ),
                                  
                                  
                ),
                title: Text("Lamia zaghloul",style: TextStyle(fontSize: 14),),
                subtitle: Text("300.00"),
                trailing: Icon(Icons.email,color: Colors.orange,size: 30,),),
                
  );
}

  Widget orderCard(BuildContext context, String orderNumber , String name , String about ,Color orderColor,
   String date,String cat,String price){
    //AppState appState = Provider.of<AppState>(context);
    return GestureDetector(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>OrdersDetails()));
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
                  
                  trailing :Icon(Icons.keyboard,color: Colors.black38,),
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