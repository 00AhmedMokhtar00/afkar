import 'package:afkar/AppBar1.dart/appBar2.dart';
import 'package:flutter/material.dart';

class Efada extends StatefulWidget {
  final  String requestId, investorId;

  Efada({this.investorId, this.requestId});

  @override
  _EfadaState createState() => _EfadaState();
}

class _EfadaState extends State<Efada> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar3(context, "عمل إفادة"),
      body: _initialView(),
    );
  }

  Widget _initialView(){
    return Container(
        margin: EdgeInsets.only(top: 5),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: ListView(children: <Widget>[
          _mainTitle("عمل إفادة جديدة", icon: "images/note2.png"),

        ]));
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



  _getAllQuestions
}
