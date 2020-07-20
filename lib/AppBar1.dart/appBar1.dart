import 'package:afkar/appBarTools/notification.dart';
import 'package:afkar/main.dart';
import 'package:afkar/profile/massegs.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
Widget appBar(BuildContext context ,  final GlobalKey<ScaffoldState> _scaffoldKey ){
  AppState appState = Provider.of<AppState>(context,listen: false);
  return PreferredSize(child: 
 Column(children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 30, left: 10, right: 10),
              width: MediaQuery.of(context).size.width,
              height: 80,
              color: Theme.of(context).primaryColor,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Directionality(
                      textDirection: TextDirection.ltr,
                        child: Row(
                        children: <Widget>[
                        IconButton(
                          padding: EdgeInsets.all(0),
                            alignment: Alignment.center,
                            icon: Image(
                              image: AssetImage("images/message.png"),
                              width: 39,
                              height: 39,
                            ),
                            onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>Massegs(appState.getid)));
                            }),
                            // IconButton(
                            //   padding: EdgeInsets.all(0),
                            // alignment: Alignment.center,
                            // icon: Image(
                            //   image: AssetImage("images/notification.png"),
                            //   width: 40,
                            //   height: 40,
                            // ),
                            // onPressed: () {
                            // Navigator.push(context, MaterialPageRoute(builder: (context)=>Notifications()));

                            // }),
                            // IconButton(
                            //   padding: EdgeInsets.all(0),
                            // alignment: Alignment.center,
                            // icon: Image(
                            //   image: AssetImage("images/search.png"),
                            //   width: 35,
                            //   height: 35,
                            // ),
                            // onPressed: () {}),
                      ]),
                    ),
                    Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width*0.22,
                      child: Image(
                        image: AssetImage("images/logo2.png"),
                        width: 50,
                        height: 50,
                      ),
                    ),
                    IconButton(
                        alignment: Alignment.centerLeft,
                        icon: Image(
                          image: AssetImage("images/menu.png"),
                          width: 35,
                          height: 35,
                        ),
                        onPressed: () {
                          _scaffoldKey.currentState.openEndDrawer();
                        }),
                  ]),
            ),
          ]), preferredSize: Size(
          MediaQuery.of(context).size.width,
          60.0
        ),);
}