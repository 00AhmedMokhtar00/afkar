import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:afkar/AppBar1.dart/appBar2.dart';
import 'package:afkar/alerts/alerts.dart';
import 'package:afkar/main.dart';
import 'package:flutter/material.dart';

class SendFeedBack extends StatefulWidget{
  final String reqId;
  SendFeedBack(this.reqId);
  @override
  _SendFeedBackState createState() => _SendFeedBackState();
}

class _SendFeedBackState extends State<SendFeedBack> {
  TextEditingController conAbout = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:appBar3(context,"ارسال افادة"),
      body:Container(
        child:Column(
        children: <Widget>[
          SizedBox(height:20),
          TextField(
                  controller: conAbout,
                  keyboardType: TextInputType.number,
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 15,
                  ),
                  maxLines: 6,
                  //maxLength: 160,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(10.0),
                    border: InputBorder.none,
                    filled: true,
                    fillColor: Color(0xffffffff),
                    hintText: "نص الافادة",
                    hintStyle: TextStyle(color: Colors.black26, fontSize: 15),
                  ),
                ),
                SizedBox(height:20),
                 GestureDetector(
                        onTap: (){
                          if(conAbout.text.trim() != ""){
                           sendFeedback(context);
                         }else{
                           alertTost("من فضلك ادخل نص الافادة");
                         }
                        },
                          child: Container(
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width*0.4,
                          height: 40,
                          color: Theme.of(context).primaryColor,
                          child: Text("ارسال الافادة" ,style:TextStyle(fontSize:16, color: Colors.white)),
                        ),
                      ),
        ],)
      )
    );
  }
  Future sendFeedback(BuildContext context)async{
    AppState appState = Provider.of<AppState>(context,listen: false);
    try{var url = "https://afkarestithmar.com/api/api.php?type=feedbackinvest&invest_id=${appState.getid}&ques_id=1&request_id=${widget.reqId}&answer=${conAbout.text}";
        var request = await http.get(url);
        var data = jsonDecode(request.body);
        if("${data['success']}"== "1"){
          print(data);
          Navigator.pop(context);
          Navigator.pop(context);
          Navigator.pop(context);
          alertTost(data['message']);
        } 
    }catch(e){
      print(e);
    }
}
}