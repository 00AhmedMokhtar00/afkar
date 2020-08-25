
import 'package:afkar/AppBar1.dart/appBar2.dart';
import 'package:afkar/models/thinker/order_model.dart';
import 'package:afkar/profile/chat.dart';
import 'package:afkar/utils/helper_methods.dart';
import 'package:flutter/material.dart';
import 'package:pdf_flutter/pdf_flutter.dart';

class OrderDetails extends StatefulWidget {
  OrderModel orderModel;

  OrderDetails({this.orderModel});

  @override
  _OrderDetailsState createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {

  OrderModel get orderModel {
    return widget.orderModel;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xfff4f4f4),
        appBar: appBar3(context, "#"+orderModel.number),
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
        child: ListView(children: <Widget>[
          orderCard(),
          _priceView(),
          _offersView(),
          _attachmentView(),

        ]));
  }

  Widget orderCard() {
    //AppState appState = Provider.of<AppState>(context);
    return Container(
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
    );
  }

  _orderNumberView(){
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

  _orderItemView(){
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
            "$value",
            style: TextStyle(color: Colors.black54, fontSize: 10),
          ),
        ],
      ),
    );
  }

  Widget _priceView() {
    return Container(
        height: MediaQuery.of(context).size.height * 0.225,
        margin: EdgeInsets.all(5),
        color: Colors.white,
        padding: EdgeInsets.all(10),
        child: Center(
          child: Column(
            children: <Widget>[
              Icon(
                Icons.monetization_on,
                size: MediaQuery.of(context).size.height * 0.07,
              ),
              Text(
                HelperMethods.formatMoney(double.parse(orderModel.price)),
                style: TextStyle(fontSize: 25),
              ),
              Text("السعر المطلوب")
            ],
          ),
        ));
  }

  Widget _mainTitle(String title){
    return Container(
        color: Colors.white,
        padding: EdgeInsets.all(10),
        height: MediaQuery.of(context).size.height * 0.07,
        child: Row(children: <Widget>[
          Icon(Icons.local_offer),
          SizedBox(width: 6.0,),
          Text(title),
        ]));
  }

  Widget _widgetOffers({String offeredMoney, String investorName = "Investor Name", String investorId}) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(left: 5, right: 5),
      margin: EdgeInsets.all(4),
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width,
      height: 100,
      child: ListTile(
        leading: Container(
          child: ClipRRect(
              borderRadius: BorderRadius.circular(2),
              child: Container(
                  width: 70,
                  height: 70,
                  color: Colors.orange,
                  child: Center(
                    child: Image.asset('images/message.png'),
                  ))),
        ),
        title: Text(
          investorName,
          style: TextStyle(fontSize: 14),
        ),
        subtitle: Text(offeredMoney),
        trailing: GestureDetector(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>Chat(orderModel.userId,investorId,investorId,investorName)));
          },
          child: Icon(
            Icons.email,
            color: Colors.orange,
            size: 30,
          ),
        ),
      ),
    );
  }

  Widget _offersView(){
    return Container(
      margin: const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 10.0),
      height: orderModel.investUsers != null && orderModel.investUsers.length != 0? (MediaQuery.of(context).size.height * 0.213) * orderModel.investUsers.length: null,
      child: Column(
        children: [
          _mainTitle("العروض"),
          orderModel.investUsers != null && orderModel.investUsers.length != 0?
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: orderModel.investUsers.map((offer) =>
                _widgetOffers(offeredMoney: offer["part"], investorId: offer["id"], investorName: offer["name"])
            ).toList()
          ):Center(child: Text("لا يوجد عروض"))
        ],
      ),
    );
  }

  Widget _attachmentView(){
    return Container(
      margin: const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 10.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            _mainTitle("المرفقات"),

            orderModel.attachments != null || (orderModel.attachments.first != "" && orderModel.attachments.last != "")?
            Column(children: _getAttachments())
                :
            Center(child: Text("لا يوجد مرفقات"))
          ],
        ),
      ),
    );
  }

  Widget _attachmentItem({String title, String filePath}){
    return Container(
        color: Colors.white,
        child: ExpansionTile(
          leading: Icon(Icons.content_paste),
          title: Text(
            title,
            style: TextStyle(fontSize: 15),
          ),
          trailing: Icon(Icons.arrow_downward),
          children: [
            PDF.network(
              'https://invideas.com/$filePath',
              //height: MediaQuery.of(context).size.height * 0.25,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.7,

            )

          ],
        )
    );
  }

  List<Widget> _getAttachments(){

    return orderModel.attachments.map((attachment) =>
    _attachmentItem(title: attachment.toString().replaceAll("userfiles", ""), filePath: attachment.toString())
    ).toList();
  }
}
