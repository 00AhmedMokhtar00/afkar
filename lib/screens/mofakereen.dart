

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:afkar/AppBar1.dart/appBar2.dart';
import 'package:afkar/profile/viewPhoto.dart';
import 'package:material_dropdown_formfield/material_dropdown_formfield.dart';
import 'package:afkar/AppBar1.dart/bottomNavBar.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
class Mofakereen extends StatefulWidget{
  @override
  _MofakereenState createState() => _MofakereenState();
}

class _MofakereenState extends State<Mofakereen> {
  List<String> names = [];
  List<String> images = [];
  List<String> abouts = [];
  @override
  void initState() {
    getMofakerList(context);
    super.initState();
  }
  // String _myActivity;
  // FocusNode focusNode = FocusNode();
  // List dataSource=[
  //   {
  //     "display": "مجال",
  //     "value": "v",
  //   },
  // ];

  // @override
  // void initState() {
  //   super.initState();
  //   _myActivity = '';

  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff5f5f5),
      appBar:appBar2(context , "المفكرين" , "images/Investor.png"),
      bottomNavigationBar: bottomNvBar(context, index : 3),
      // body: Container(
      //   padding: EdgeInsets.all(10),
      //   child: Column(
      //     children:<Widget>[
            // Container(
            //           color: Colors.white,
            //           child: DropDownFormField(
            //            innerBackgroundColor: Colors.white,
            //             wedgeIcon: Icon(Icons.keyboard_arrow_down),
            //             wedgeColor: Colors.black54,
            //             innerTextStyle: TextStyle(color: Colors.black54 , fontSize: 14),
            //             focusNode: focusNode,
            //             inputDecoration: OutlinedDropDownDecoration(
            //                 borderWidth: 0,
            //                 labelStyle: TextStyle(color: Colors.white),
            //                 labelText: "",
            //                 borderColor: Colors.white),
            //             hintText: '-- ترتيب حسب المجال --',
            //             value: _myActivity,
            //             onSaved: (value) {
            //               setState(() {
            //                 _myActivity = value;
            //               });
            //             },
            //             onChanged: (value) {
            //               setState(() {
            //                 _myActivity = value;
            //                 print(_myActivity);
            //               });
            //             },
            //             dataSource: dataSource,
            //             textField: 'display',
            //             valueField: 'value',
            //           ),
            //             ),
                        // SizedBox(height:10),
                      body:Container(
        margin: EdgeInsets.only(top:5),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height-5,
        child: ListView.builder(
          itemCount: names.length,
          itemBuilder: (context, i){
            return mofakerCard(context, images[i], names[i], abouts[i]);
          },
        ),
      )

                        
        //   ]
        // ),
      //),
    );
  }
  Widget mofakerCard(BuildContext context , String imgurl , String name , String about ){
    return GestureDetector(
        onTap: (){
        },
          child: Container(
        padding: EdgeInsets.only(left:10,right: 10 , top: 10 , bottom: 10),
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
            Row(
              children: <Widget>[
                ClipRRect(
                  borderRadius:BorderRadius.circular(15),
                                  child: Container(
                    child: GestureDetector(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>PhotoView(imgurl == null || imgurl == "" ? "http://matib.jaderplus.com/userfiles/5e6e6b8791988_profile.png":imgurl)));
                                  },
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(200),
                                      child: Container(
                                        width: 65,
                                        height: 65,
                                        child: CachedNetworkImage(
                                        fit: BoxFit.cover,
                           imageUrl: "$imgurl",
                   placeholder: (context, url) => Container(
                    padding: EdgeInsets.all(30),
                     child:CircularProgressIndicator(),),
                  errorWidget: (context, url, error) => Image(image: AssetImage("images/profile2.png")),
                   ),
                                      ),
                                  ),),
                  ),
                ),
                SizedBox(width:10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("$name" , style: TextStyle(color:Colors.black54, fontSize: 14),),
                    Text(about.length > 40? about.substring(0,39) + " ...":about , style: TextStyle(color:Colors.black54, fontSize: 12),),
                  ],
                ),
              ],
            ),
            Container()
          ],
        ),
      ),
    );
  }
  Future getMofakerList(BuildContext context)async{
    try{var url = "https://afkarestithmar.com/api/api.php?type=users&tt=2";
        var request = await http.get(url);
        var data = jsonDecode(request.body);

        if("${data['success']}"== "1"){
          print(data);
          for (var i = 0; i < data["users"].length; i++) {
            names.add(data["users"][i]["Name"]);
            images.add(data["users"][i]["img"]);
            abouts.add(data["users"][i]["About"]);
          }
          setState(() {
            
          });
          
        } 
    }catch(e){
      print(e);
    }
}
}