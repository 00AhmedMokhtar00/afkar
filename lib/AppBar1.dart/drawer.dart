

import 'package:afkar/profile/Favourite.dart';
import 'package:afkar/profile/updateProfile.dart';
import 'package:afkar/profile/viewPhoto.dart';
import 'package:afkar/webView/drasetGadwaa.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../main.dart';
import 'package:shared_preferences/shared_preferences.dart';

Widget drawer(BuildContext context){
AppState appState =Provider.of<AppState>(context);
return Drawer(
          child: Container(
            child: Column(
            children:<Widget>[
            Container(
              padding: EdgeInsets.only(top:90,bottom: 0 , left: 10 , right: 10),
              color: Colors.black12,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: <Widget>[
                  Container(
                                    child: Container(
                      width:90,
                      height:90,
                      decoration:BoxDecoration(
                        boxShadow: [
                          BoxShadow(color: Colors.white,spreadRadius: 5,blurRadius: 2)
                        ],
                        borderRadius: BorderRadius.circular(120),
                      ),
                      child: ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: GestureDetector(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>PhotoView(appState.getimage == null || appState.getimage == "" ? "http://matib.jaderplus.com/userfiles/5e6e6b8791988_profile.png":appState.getimage)));
                                  },
                                  child: CachedNetworkImage(
                                    fit: BoxFit.fill,
                           imageUrl: "${appState.getimage}",
                   placeholder: (context, url) => Container(
                     padding: EdgeInsets.all(30),
                     child:CircularProgressIndicator(),),
                  errorWidget: (context, url, error) => Image(image: AssetImage("images/profile2.png")),
                   ),
                                ),
                              ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top:6.0),
                    child: Text("${appState.getname}",style: TextStyle(color: Colors.black54, fontSize: 15 , fontWeight: FontWeight.w500),),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom:8.0),
                    child: Text("",style: TextStyle(color: Colors.black54, fontSize: 14 , fontWeight: FontWeight.w500),),
                  ),
                ]),
            ),
              Column(
              children: <Widget>[
                //Navigator.push(context, MaterialPageRoute(builder: (context)=>Profile(userId , userId , double.parse(myState.getlat) , double.parse(myState.getlong))));
                // GestureDetector(
                //   onTap: (){
                //   },
                // child: customListElement(context,"مساعدة", "images/help.png")),
                GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>UpdateProfile(appState.getid, appState.getimage, appState.getname, appState.getphone, appState.getabout, appState.getemail)));
                  },
                child: customListElement(context,"الاعدادات", "images/setting.png")),
                if(appState.gettyper == "think")...[
                GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>HesabElNesab()));
                  },
                child: customListElement(context,"حساب النسب", "images/terms2.png")),
                GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>DrasetGadwaa(appState.getid)));
                },  
                child: customListElement(context,"دراسة جدوي", "images/terms2.png")),
                ],
                // if(appState.gettyper != "think")...[
                // GestureDetector(
                //   onTap: (){
                //     Navigator.push(context, MaterialPageRoute(builder: (context)=>Favourite()));
                //   },
                // child: customListElement(context,"تفضيلات المجالات", "images/terms2.png")),
                // ], 
                GestureDetector(
                  onTap: (){
                    appState.signOut();
                    _deleteData().then((v){
                      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => MyApp()),
          (Route<dynamic> route) => false,
        );
                    });
                  },
                  child: customListElement(context,"تسجيل الخروج", "images/logout.png")),
              ],
            ),
            ])
          ),
        );
}

Widget customListElement(BuildContext context ,String name ,String image){
    return Container(
                  width:MediaQuery.of(context).size.width*0.9,
                  decoration: BoxDecoration(
                    border: Border(
            top: BorderSide(width: 1.0, color: Colors.black12),
                    )
                  ),
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                      
                      children:<Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left :8.0),
                          child: Image(image: AssetImage(image), width: 28 , height:28,)
                        ),
                        Text(name,style: TextStyle(color: Colors.black54, fontSize: 13 , fontWeight: FontWeight.w500),),
                        
                      ]
                    ),
                                      ),
                  ),
                );
  }
  Future _deleteData() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }