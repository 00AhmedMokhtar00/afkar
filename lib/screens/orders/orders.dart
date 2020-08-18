import 'package:afkar/AppBar1.dart/appBar2.dart';
import 'package:afkar/models/thinker/order_model.dart';
import 'package:afkar/screens/orders/order_details.dart';
import 'package:flutter/material.dart';

class Orders extends StatefulWidget {
  @override
  _OrdersState createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  // temporary just to test the screen
  OrderModel orderModel;

  @override
  void initState() {
    orderModel = OrderModel(
        number: "#1524",
        title: "طلب دراسه جدوي للمشروع",
        details: "about",
        category: "اقتصاد",
        price: "150 ر٠س",
        date: "20-10-2010",
        hasOffers: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xfff4f4f4),
        appBar: appBar3(context, "طلباتي"),
        body: _initialView());
  }

///////////////////////////////////////////////////////////
//////////////////// Widget methods ///////////////////////
///////////////////////////////////////////////////////////

  Widget _initialView() {
    return Container(
      margin: EdgeInsets.only(top: 5),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, i) {
          return orderCard(orderModel);
        },
      ),
    );
  }

  Widget orderCard(OrderModel orderModel) {
    //AppState appState = Provider.of<AppState>(context);
    return GestureDetector(
      onTap: _onOrderPressed,
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
            _orderNumberView(),
            _orderItemView(),
          ],
        ),
      ),
    );
  }

  _orderNumberView(){
    return Container(
        margin: const EdgeInsets.only(left: 12.0),
        width: MediaQuery.of(context).size.width * 0.22,
        height: MediaQuery.of(context).size.width * 0.22,
        decoration: BoxDecoration(
            color: orderModel.hasOffers ? Colors.green : Colors.red,
            borderRadius: BorderRadius.circular(2.0)),
        child: Center(
            child: Text(
              orderModel.number,
              style: TextStyle(color: Colors.white),
            )));
  }

  _orderItemView(){
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                orderModel.title,
                style: TextStyle(color: Colors.black54, fontSize: 13),
              ),
              Icon(
                Icons.keyboard,
                color: Colors.black38,
                size: 18.0,
              )
            ],
          ),
          Row(
            children: [
              subTitleWidget(
                orderModel.date,
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
            "$value",
            style: TextStyle(color: Colors.black54, fontSize: 8),
          ),
        ],
      ),
    );
  }

///////////////////////////////////////////////////////////
//////////////////// Helper methods ///////////////////////
///////////////////////////////////////////////////////////

  _onOrderPressed(){
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => OrderDetails(orderModel: orderModel))
    );
  }

}
