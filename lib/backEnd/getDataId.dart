

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../main.dart';
import 'package:http/http.dart' as http;

Future getDataId(BuildContext context , {String user_id})async{
AppState myState = Provider.of<AppState>(context,listen: false);
    String id;
    user_id == null ? id = myState.getid : id = user_id;
    try{var url = "https://afkarestithmar.com/api/api.php?type=loginID&id=$id";
        var request = await http.get(url);
        //print(request.body);
        var data = jsonDecode(request.body);
        if("${data['success']}"== "1"){
            AppState myState =Provider.of<AppState>(context,listen: false);
            String l = data["cat_id"];
            List<String> vll = [];
            String newl = "";
            dynamic lol;
             
            myState.setData(
             img: (data["img"] == "" || data["img"] == null )? "":data["img"],
             nam : "${data["Name"]}",
             ph:data["Mobile"],
             abou:data["About"],
             em:data["Email"],
             addr: data["address"],
             prce: data["price"],
             ty: data["type"],
             hj:lol,
             vall: vll ,
             );
             for (var i = 1; i < l.length-1; i++) {
               newl= "$newl${l[i]}";
             }
             for (var i = 0; i < newl.length; i+=6) {
               vll.add("${newl[i+1]}${newl[i+2]}");
               if(lol == null)
               lol = newl[i+1]+newl[i+2];
               else
               lol = lol + ", " + newl[i+1]+newl[i+2];
             }
          
        } 
    }catch(e){
      print(e);
    }
}