import 'package:afkar/AppBar1.dart/appBar1.dart';
import 'package:afkar/AppBar1.dart/drawer.dart';
import 'package:afkar/login.dart';
import 'package:afkar/screens/reg1.dart';
import 'package:afkar/screens/regMofaker.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: drawer(context),
      key: _scaffoldKey,
      backgroundColor: Color(0xfff5f5f5),
      appBar: appBar(context,_scaffoldKey, loggedOut: true),
        body:  Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: SingleChildScrollView(
                child:Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>Reg1()));
                      },
                      child: Container(
                      margin: EdgeInsets.only(bottom:MediaQuery.of(context).size.height*0.03 , top:MediaQuery.of(context).size.height*0.03),
                      width:MediaQuery.of(context).size.width*0.9,
                      height:MediaQuery.of(context).size.height*0.34,
                      color: Colors.white,
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children:<Widget>[
                          Container(
                        alignment: Alignment.center,
                        child: Image(
                          image: AssetImage("images/most.png"),
                          width: MediaQuery.of(context).size.height*0.21,
                          height: MediaQuery.of(context).size.height*0.21,
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width*0.83,
                        height: MediaQuery.of(context).size.height*0.09,
                        color: Color(0xfff4f4f4),
                        child: Text("مستثمر" ,style:TextStyle(fontSize:18, color: Colors.black54)),
                      )
                        ]
                      ),
                    ),
                  ),
                  GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>RegMofaker()));
                      },
                                      child: Container(
                      margin: EdgeInsets.only(bottom:MediaQuery.of(context).size.height*0.03),
                      width:MediaQuery.of(context).size.width*0.9,
                      height:MediaQuery.of(context).size.height*0.34,
                      color: Colors.white,
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children:<Widget>[
                          Container(
                        alignment: Alignment.center,
                        child: Image(
                          image: AssetImage("images/his.png"),
                          width: MediaQuery.of(context).size.height*0.21,
                          height: MediaQuery.of(context).size.height*0.21,
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width*0.83,
                        height: MediaQuery.of(context).size.height*0.09,
                        color: Color(0xfff4f4f4),
                        child: Text("صاحب مشروع او فكرة" ,style:TextStyle(fontSize:18, color: Colors.black54)),
                      )
                        ]
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>LogIn()));
                    },
                                      child: Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width*0.9,
                        height: MediaQuery.of(context).size.height*0.07,
                        color: Color(0xffffffff),
                        child: Text("تسجيل الدخول" ,style:TextStyle(fontSize:18, color: Colors.black54)),
                      ),
                  ),

                  // Row(
                  //   mainAxisAlignment:MainAxisAlignment.spaceEvenly,
                  //   children:<Widget>[
                  //     Container(
                  //     alignment: Alignment.center,
                  //     width: MediaQuery.of(context).size.width*0.42,
                  //     height: MediaQuery.of(context).size.height*0.07,
                  //     color: Color(0xffffffff),
                  //     child: Text("تخطي" ,style:TextStyle(fontSize:18, color: Colors.black54)),
                  //   ),
                  //   Container(
                  //     alignment: Alignment.center,
                  //     width: MediaQuery.of(context).size.width*0.42,
                  //     height: MediaQuery.of(context).size.height*0.07,
                  //     color: Theme.of(context).primaryColor,
                  //     child: Text("تم" ,style:TextStyle(fontSize:18 , color: Colors.white)),
                  //   )
                  //   ]
                  // )
                ],)
              ),
            ));
  }
}
