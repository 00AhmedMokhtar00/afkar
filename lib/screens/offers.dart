import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:afkar/AppBar1.dart/appBar2.dart';
import 'package:afkar/tools/offerDetails.dart';
import 'package:flutter/material.dart';

class Offers extends StatefulWidget{
  final String id;
  Offers(this.id);

  @override
  _OffersState createState() => _OffersState();
}

class _OffersState extends State<Offers> {
  @override

  List<String> imges = [];

  List<String> names = [];

  List<String> answers = [];
  List<String> ids = [];

  void initState() {
    getOffers(context);
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff4f4f4),
      appBar:appBar3(context , "العروض"),
      body:Container(
        margin: EdgeInsets.only(top:5),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height-5,
        child: ListView.builder(
          itemCount: names.length,
          itemBuilder: (context, i){
            return offersCard(context,imges[i] , names[i] , answers[i] ,ids[i]);
          },
        ),
      )
    );
  }

  Widget offersCard(BuildContext context , String img , String name  , String answer , String reqId){
    print(img);
    return GestureDetector(
        onTap: (){
          Navigator.push(context, PageRouteBuilder(
    opaque: false,
    pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
        return OfferDetails(answer);
    },
    transitionsBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
    return SlideTransition(
      position: new Tween<Offset>(
        begin: const Offset(-1.0, 0.0),
        end: Offset.zero,
      ).animate(animation),
      child: new SlideTransition(
        position: new Tween<Offset>(
          begin: Offset.zero,
          end: const Offset(-1.0, 0.0),
        ).animate(secondaryAnimation),
        child: child,
      ),
    );
  },
));
        },
          child: Container(
        padding: EdgeInsets.only(left:20,right: 20 , top: 10 , bottom: 10),
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
                Container(
                  decoration: BoxDecoration(
                    shape:BoxShape.circle,
                  ),
                  child: ClipRRect(
                                borderRadius: BorderRadius.circular(500),
                                child: FadeInImage.assetNetwork(
                                      image: img.trim() == null || img.trim() == "" ? "https://afkarestithmar.com/userfiles/5ec6c63caf6b8_profile.png":img,
                                      placeholder:  'images/profile.png',
                                      width: 70,
                                      height: 70,
                                      fit: BoxFit.cover,
                                    ), 
                                  ),
                ),
                SizedBox(width:10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("$name" , style: TextStyle(color:Colors.black54, fontSize: 14),),
                    //Text("@muhammed4323" , style: TextStyle(color:Colors.black54, fontSize: 14),),
                  ],
                ),
              ],
            ),
            Text("#$reqId" , style: TextStyle(color:Colors.black54, fontSize: 15),),
          ],
        ),
      ),
    );
  }

  Future getOffers(BuildContext context )async{
    try{var url = "https://afkarestithmar.com/api/api.php?type=feedbackinvestByR_id&request_id=${widget.id}";
        var request = await http.get(url);
        var data = jsonDecode(request.body);

        if("${data['success']}"== "1"){
          print(data);
          for (var i = 0; i < data["ques"].length; i++) {
             imges.add(data["ques"][i]["invest_img"]);
             names.add("${data["ques"][i]["invest_name"]}");
             answers.add(data["ques"][i]["answer"]);
             ids.add(data["ques"][i]["id"]);
          }
          setState(() {
            
          });
        } 
    }catch(e){
      print(e);
    }
}
}