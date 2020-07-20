import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../main.dart';
import 'package:http/http.dart' as http;

Future updateProfileImage(BuildContext context ,String imagePath)async{
  String realPath = "https://afkarestithmar.com/userfiles/$imagePath";
  try {
  AppState myState = Provider.of<AppState>(context,listen: false);
  String id = myState.getid;
  String name = myState.getname;
  String phone = myState.getphone;
  String about = myState.getabout;
  String email = myState.getemail;
  var url = "https://afkarestithmar.com/api/api.php?type=updateAll&id=$id&name=$name&Mobile=$phone&img=$realPath&about=$about&Email=$email";
  var request = await http.get(url);
  print(request.body);
  var data = jsonDecode(request.body);
  if("${data['success']}"== "1"){
    print(data);
    var url1 = "https://afkarestithmar.com/api/api.php?type=loginID&id=$id";
        var request1 = await http.get(url1);
        var data1 = jsonDecode(request1.body);
        if("${data1['success']}"== "1"){
            myState.setData(
             img: (data1["img"] == "" || data1["img"] == null )? "":"${data1["img"]}",
             nam : "${data1["Name"]}",
             ph:data1["Mobile"],
             abou:data1["About"],
             em:data1["Email"],
             addr: data1["address"],
             prce: data1["price"]
             );
             print("${myState.getname}");
             print(data1);
  }
  }
  } catch (e) {
  }

}