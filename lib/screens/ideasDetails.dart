import 'dart:convert';
import 'package:afkar/alerts/alerts.dart';
import 'package:afkar/screens/sendFeedback.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:afkar/AppBar1.dart/appBar2.dart';
import 'package:afkar/main.dart';
import 'package:flutter/material.dart';

class IdeasDetails extends StatefulWidget{
  final String name;
  final String domain;
  final String proposel;
  final String pre;
  final String details;
  final String id;
  IdeasDetails(this.id , this.name , this.details , this.domain , this.pre , this.proposel);
  @override
  _IdeasDetailsState createState() => _IdeasDetailsState();
}

class _IdeasDetailsState extends State<IdeasDetails> {
  TextEditingController conMoney = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar3(context, "تفاصيل الفكرة"),
      body: Container(
        alignment: Alignment.center,
              child: Container(
            width: MediaQuery.of(context).size.width*0.9,
            height: MediaQuery.of(context).size.height,
          child:SingleChildScrollView(
              child: Column(
              children:<Widget>[
                SizedBox(height:20),
                Text("إسم المفكر : ${widget.name}" , style: TextStyle(color:Colors.black54, fontSize: 16),),
                SizedBox(height:10),
                Text("مجال الفكره : ${widget.domain}" , style: TextStyle(color:Colors.black54, fontSize: 16),),
                SizedBox(height:10),
                Text("رأس المال : ${widget.proposel}" , style: TextStyle(color:Colors.black54, fontSize: 16),),
                SizedBox(height:10),
                Text("مقابل : ${widget.pre}" , style: TextStyle(color:Colors.black54, fontSize: 16),),
                SizedBox(height:10),
                Text("النص : ${widget.details}" , style: TextStyle(color:Colors.black54, fontSize: 16),),
                SizedBox(height:20),
                TextField(
                  controller: conMoney,
                  keyboardType: TextInputType.number,
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 15,
                  ),
                  maxLines: 1,
                  //maxLength: 160,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(10.0),
                    border: InputBorder.none,
                    filled: true,
                    fillColor: Color(0xffffffff),
                    hintText: "القيمة المشارك بها",
                    hintStyle: TextStyle(color: Colors.black26, fontSize: 15),
                  ),
                ),
                SizedBox(height:10),
                Row(
                      mainAxisAlignment:MainAxisAlignment.spaceEvenly,
                      children:<Widget>[
                      GestureDetector(
                        onTap: (){
                         if(conMoney.text.trim() != ""){
                           acceptRequest(context);
                         }else{
                           alertTost("من فضلك ادخل قيمة للقبول");
                         }
                        },
                                              child: Container(
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width*0.4,
                          height: 40,
                          color: Theme.of(context).primaryColor,
                          child: Text("قبول" ,style:TextStyle(fontSize:16 , color: Colors.white)),
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>SendFeedBack(widget.id)));
                        },
                          child: Container(
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width*0.4,
                          height: 40,
                          color: Color(0xfff0f0f0),
                          child: Text("رفض مع افادة" ,style:TextStyle(fontSize:16, color: Colors.black54)),
                        ),
                      ),
                      ]
                    )
              ]
            ),
          )
        ),
      ),
    );
  }
  Future acceptRequest(BuildContext context)async{
    AppState appState = Provider.of<AppState>(context,listen: false);
    try{var url = "https://afkarestithmar.com/api/api.php?type=accept_req&req_id=${widget.id}&price=${conMoney.text}&invest_id=${appState.getid}";
        var request = await http.get(url);
        var data = jsonDecode(request.body);
        if("${data['success']}"== "1"){
          print(data);
          Navigator.pop(context);
          Navigator.pop(context);
          alertTost(data['message']);
        } 
    }catch(e){
      print(e);
    }
}
}