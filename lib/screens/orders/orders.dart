import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import 'package:afkar/AppBar1.dart/appBar2.dart';
import 'package:afkar/models/thinker/order_model.dart';
import 'package:afkar/screens/orders/order_details.dart';

import '../../main.dart';

class Orders extends StatefulWidget {
  @override
  _OrdersState createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  List<OrderModel> orderModel = List();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xfff4f4f4),
        appBar: appBar3(context, "طلباتي"),
        body: _initialView()
    );
  }

///////////////////////////////////////////////////////////
//////////////////// Widget methods ///////////////////////
///////////////////////////////////////////////////////////

  Widget _initialView() {
    return FutureBuilder<List<OrderModel>>(
      future: _getMyOrders(),
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
    //AppState appState = Provider.of<AppState>(context);
    return GestureDetector(
      onTap: () => _onOrderPressed(orderModel),
      child: Container(
        padding: EdgeInsets.only(left: 5, right: 5),
        margin: EdgeInsets.all(4),
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width,
        //height:MediaQuery.of(context).size.height * 0.1,
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: Color(0xfff4f4f4),
            spreadRadius: 2,
          )
        ], color: Colors.white),
        child: Row(
          children: <Widget>[
            _orderNumberView(orderModel),
            _orderItemView(orderModel),
          ],
        ),
      ),
    );
  }

  _orderNumberView(OrderModel orderModel){
    return Container(
        margin: const EdgeInsets.only(left: 12.0),
        width: MediaQuery.of(context).size.width * 0.21,
        height: MediaQuery.of(context).size.width * 0.22,
        decoration: BoxDecoration(
            color: orderModel.investUsers != null && orderModel.investUsers.length != 0? Colors.green : Colors.red,
            borderRadius: BorderRadius.circular(2.0)),
        child: Center(
            child: Text(
              "#"+orderModel.number,
              style: TextStyle(color: Colors.white),
            )));
  }

  _orderItemView(OrderModel orderModel){
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  orderModel.title,
                  style: TextStyle(color: Colors.black54, fontSize: 13),
                ),
              ),
              Icon(
                Icons.keyboard,
                color: Colors.black38,
                size: 18.0,
              )
            ],
          ),

          FittedBox(
            child: Row(
              children: [
                subTitleWidget(
                  orderModel.date.length > 10?orderModel.date.substring(0,10):orderModel.date,
                  Icon(
                    Icons.date_range,
                    color: Colors.black38,
                    size: 12,
                  ),
                ),
                subTitleWidget(
                  orderModel.category,
                  Icon(Icons.category, color: Colors.black38, size: 12),
                ),
                subTitleWidget(
                  orderModel.price,
                  Icon(Icons.monetization_on,
                      color: Colors.black38, size: 12),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }



  Widget subTitleWidget(value, Icon icon) {
    return Padding(
      padding: const EdgeInsets.only(right: 5.0, top: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          icon,
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
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => OrderDetails(orderModel: orderModel))
    );
  }


  Future<List<OrderModel>> _getMyOrders()async{
    AppState appState = Provider.of<AppState>(context,listen: false);
    try{

      final String oredersUrl = "https://afkarestithmar.com/api/api.php?type=myrequests&user_id=${appState.getid}";

      http.Response response = await http.get(oredersUrl);

      var data = jsonDecode(response.body);

      if( data['success']== 1){

        List ordersData = data["allrequests"];

        List<OrderModel> orderModels = List();
        orderModels.addAll(
            ordersData.map(
                    (order) => OrderModel(
                      userId: appState.getid,
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
    }
  }

}
