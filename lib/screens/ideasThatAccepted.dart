
import 'dart:convert';
import 'package:afkar/alerts/alerts.dart';
import 'package:afkar/main.dart';
import 'package:afkar/models/thinker/order_model.dart';
import 'package:afkar/screens/ideasDetails.dart';
import 'package:afkar/screens/ideasThatAcceptedDetails.dart';
import 'package:http/http.dart' as http;
import 'package:afkar/AppBar1.dart/appBar2.dart';
import 'package:afkar/AppBar1.dart/bottomNavBar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class IdeasThatAccepted extends StatefulWidget{
  @override
  _IdeasThatAcceptedState createState() => _IdeasThatAcceptedState();
}

class _IdeasThatAcceptedState extends State<IdeasThatAccepted> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff4f4f4),
      appBar:appBar3(context , "الافكار اللتي تم قبولها"),
      bottomNavigationBar: bottomNvBar(context , index:2) ,
      body: _initialView()
    );
  }

///////////////////////////////////////////////////////////
//////////////////// Widget methods ///////////////////////
///////////////////////////////////////////////////////////


  Widget _initialView() {
    return FutureBuilder<List<OrderModel>>(
        future: _getMyAcceptedOrders(),
        builder: (context, snapshot) {
          if(snapshot.hasData) {
            return Container(
              margin: EdgeInsets.only(top: 5),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: snapshot.data.length,
                itemBuilder: (context, i) {
                  return orderCard(snapshot.data[i]);
                },
              ),
            );
          } else if(snapshot.hasError){
            return Text(snapshot.error);
          } else{
            return Center(child: CircularProgressIndicator());
          }
        }
    );
  }

  Widget orderCard(OrderModel orderModel) {

    return GestureDetector(
      onTap: () => _onOrderPressed(orderModel),
      child: Container(
        padding: EdgeInsets.only(left: 15.0, right: 15.0),
        margin: EdgeInsets.all(5.0),
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width,
        //height:MediaQuery.of(context).size.height * 0.1,
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: Color(0xfff4f4f4),
            spreadRadius: 2,
          )
        ], color: Colors.white),
        child: Column(
          children: <Widget>[
            _orderItemView(orderModel),
            Divider(),
            _shareView(orderModel)
          ],
        ),
      ),
    );
  }

  _orderItemView(OrderModel orderModel){
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text(
                orderModel.title,
                style: TextStyle(color: Colors.black54, fontSize: 14),
              ),
            ),
            IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset("images/money1.png", width: 30.0, height: 30.0, fit: BoxFit.fill,),
                  VerticalDivider(width: 2.0,),
                  SizedBox(width: 4.0),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(orderModel.investPercentage + "%"),
                      Text("حصة المستثمر", style: TextStyle(fontSize: 4.0, height: 0.5),),
                    ],
                  )
                ],
              ),
            )
          ],
        ),

        FittedBox(
          child: Row(
            children: [
              subTitleWidget(
                  orderModel.date.length > 10?orderModel.date.substring(0,10):orderModel.date,
                  "images/date.png"
              ),
              subTitleWidget(
                  orderModel.category,
                  "images/type.png"
              ),
              subTitleWidget(
                  orderModel.price,
                  "images/money1.png"
              ),
              subTitleWidget(
                  orderModel.userName??"",
                  "images/man.png"
              ),
            ],
          ),
        )
      ],
    );
  }

  _shareView(OrderModel orderModel){
    return Padding(
      padding: const EdgeInsets.only(bottom: 5.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset("images/note.png", width: 30.0, height: 30.0, fit: BoxFit.fill,),
          SizedBox(width: 3.0,),
          Text(
              "انت مساهم بمبلغ " + (double.parse(orderModel.price) * double.parse(orderModel.investPercentage) / 100).toStringAsFixed(2) + " ر.س في هذا المشروع",
            style: TextStyle(color: Colors.black54, fontSize: 8),
          )
        ],
      ),
    );
  }



  Widget subTitleWidget(value, String icon) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0, left: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Image.asset(icon, width: 18.0, height: 18.0, fit: BoxFit.fill,),
          SizedBox(
            width: 3,
          ),
          Text(
            value,
            textDirection: TextDirection.ltr,
            style: TextStyle(color: Colors.black54, fontSize: 8),
          ),
        ],
      ),
    );
  }



///////////////////////////////////////////////////////////
//////////////////// Helper methods ///////////////////////
///////////////////////////////////////////////////////////

  _onOrderPressed(OrderModel orderModel){
    print(orderModel);
    if(orderModel == null){
      alertTost("NO DATA");
      return;
    }
//    Navigator.push(
//        context, MaterialPageRoute(builder: (context) => IdeasThatAcceptedDetails())
//    );
  }

  Future<List<OrderModel>> _getMyAcceptedOrders()async{
    AppState appState = Provider.of<AppState>(context,listen: false);

    try{
      var url = "https://afkarestithmar.com/api/api.php?type=afkaraccepted&user_id=${appState.getid}";

      http.Response response = await http.get(url);

      var data = jsonDecode(response.body);

        if(data['success']== 1){
          List ordersData = data["allideas"];

          List<OrderModel> orderModels = List();

          orderModels.addAll(
              ordersData.map(
                      (order) => OrderModel(
                      //userId: order["thinker_id"],
                      number: order["id"],
                      category: order["domain_name"],
                      price: order["proposed_price"],
                      title: order["title"],
                      details: order["details"],
                      date: order["created_at"], // TODO
                      attach: order["attach"],
                      attachments: order["attachs"],
                      domainId: order["domain_id"],
                      investPercentage: order["invest_per"],
                      payed: order["payed"],
                      investUsers: order["invest_users"],
                      status: order["status"],
                      userName: order["uname"]
                  )
              ).toList()
          );
          return orderModels;
        } 
    }catch(e){
      print(e);
      return null;
    }
}






  Widget ideasThatAcceptedCard(BuildContext context ,String title , String name ,String id , String details , String domain , String pre ,String proposel){
    return GestureDetector(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>IdeasThatAcceptedDetails(id , name , details , domain , pre , proposel)));
        },
          child: Container(
        padding: EdgeInsets.all(20),
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
            Container(
              width: MediaQuery.of(context).size.width*0.76,
              child: Text("$title" , style: TextStyle(color:Colors.black54, fontSize: 15),)),
            Text("#$id" , style: TextStyle(color:Colors.black54, fontSize: 15),),
          ],
        ),
      ),
    );
  }
  
}