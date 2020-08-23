import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:afkar/alerts/alerts.dart';
import 'package:afkar/screens/Ideas/efada.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:afkar/AppBar1.dart/appBar2.dart';
import 'package:afkar/models/thinker/order_model.dart';
import 'package:afkar/profile/chat.dart';
import 'package:afkar/screens/orders/order_details.dart';
import 'package:afkar/webView/preview_file.dart';
import 'package:flutter/material.dart';
import 'package:pdf_flutter/pdf_flutter.dart';


// ignore: must_be_immutable
class IdeasThatAcceptedDetails extends StatefulWidget {
  OrderModel orderModel;

  IdeasThatAcceptedDetails(this.orderModel);

  @override
  _IdeasThatAcceptedDetailsState createState() => _IdeasThatAcceptedDetailsState();
}

class _IdeasThatAcceptedDetailsState extends State<IdeasThatAcceptedDetails> {
  OrderModel get orderModel {
    return widget.orderModel;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xfff4f4f4),
        appBar: appBar3(context, "تفاصيل"),
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
          _investAmountView(),
          _ideaDetailsView(),
          _attachmentView(),
        ]));
  }

  Widget orderCard() {
    //AppState appState = Provider.of<AppState>(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 20.0),
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Image.asset("images/man.png", width: 20.0, height: 20.0, fit: BoxFit.fill,),
              SizedBox(
                width: 3,
              ),
              Text(
                "اسم المفكر: " + (orderModel.userName == null?"":orderModel.userName),
                style: TextStyle(color: Colors.black54, fontSize: 14),
              ),
            ],
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Image.asset("images/type.png", width: 20.0, height: 20.0, fit: BoxFit.fill,),
              SizedBox(
                width: 3,
              ),
              Text(
                "مجال الفكرة: " + orderModel.category,
                style: TextStyle(color: Colors.black54, fontSize: 14),
              ),
            ],
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Image.asset("images/money1.png", width: 20.0, height: 20.0, fit: BoxFit.fill,),
              SizedBox(
                width: 3,
              ),
              Text(
                "رأس المال: " + NumberFormat.decimalPattern().format(double.parse(orderModel.price)),
                style: TextStyle(color: Colors.black54, fontSize: 14),
              ),
            ],
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Image.asset("images/moneybox.png", width: 20.0, height: 20.0, fit: BoxFit.fill,),
              SizedBox(
                width: 3,
              ),
              Text(
                "تم جمع: ",
                style: TextStyle(color: Colors.black54, fontSize: 14),
              ),
            ],
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Image.asset("images/money2.png", width: 20.0, height: 20.0, fit: BoxFit.fill,),
              SizedBox(
                width: 3,
              ),
              Text(
                "المتبقي: ",
                style: TextStyle(color: Colors.black54, fontSize: 14),
              ),
            ],
          ),

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

  Widget _investAmountView() {
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
                NumberFormat.decimalPattern().format((double.parse(orderModel.price) * double.parse(orderModel.investPercentage) / 100)),
                style: TextStyle(fontSize: 25),
              ),
              Text("القيمة المشارك بها")
            ],
          ),
        ));
  }

  Widget _mainTitle(String title, {String icon}){
    return Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        height: MediaQuery.of(context).size.height * 0.055,
        child: Row(children: <Widget>[
          Image.asset(icon, width: 20.0, height: 20.0, fit: BoxFit.fill,),
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
            Navigator.push(context, MaterialPageRoute(builder: (context)=>Chat(orderModel.userId,investorId,investorId,"INVO")));
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

  Widget _ideaDetailsView(){
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.only(bottom: 8.0),
      margin: const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 10.0),
      //height: orderModel.investUsers != null && orderModel.investUsers.length != 0? (MediaQuery.of(context).size.height * 0.213) * orderModel.investUsers.length: null,
      child: Column(
        children: [
          _mainTitle("النص", icon: "images/terms2.png"),
          Divider(),
          Text(orderModel.details, textAlign: TextAlign.right, style: TextStyle(fontSize: 14.0),)
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
            Container(
              color: Colors.white,
              child: ExpansionTile(
                tilePadding: EdgeInsets.only(left: 10.0),
                title: _mainTitle("تحميل المرفقات", icon: "images/attach.png"),
                children: [
                  orderModel.attachments != null?
                  Column(children: _getAttachments())
                      :
                  Center(child: Text("لا يوجد مرفقات"))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _attachmentItem({String title, String filePath}){
    return Container(
        color: Colors.white,
        child: ListTile(
          leading: Icon(Icons.content_paste),
          title: Text(
            title,
            style: TextStyle(fontSize: 15),
          ),
          trailing: Icon(Icons.arrow_downward),
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => PreviewFile("https://invideas.com/$filePath", "مرفق المشروع"))),
        )
    );
  }

  List<Widget> _getAttachments(){

    return orderModel.attachments.map((attachment) =>
        _attachmentItem(title: attachment.toString().replaceAll("userfiles", ""), filePath: attachment.toString())
    ).toList();
  }
}
