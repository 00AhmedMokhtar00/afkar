import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';



class Chat extends StatefulWidget{
  final String myId,userId,userchatId,name;
  Chat(this.myId,this.userId,this.userchatId,this.name);
  @override
  _ChatState createState() => _ChatState(this.myId,this.userId,this.userchatId,this.name);
}

class _ChatState extends State<Chat> {
  
  String mychatId;
  String myId,userId,userchatId,name;
  _ChatState(this.myId,this.userId,this.userchatId,this.name);
  TextEditingController textController = TextEditingController();

  List listdata = [];
  @override
  void initState() {
    readchatId();
    getonChatData(myId, userId);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("$name",style: TextStyle(
        fontWeight: FontWeight.w400
        ),),
        centerTitle: true,
        leading: IconButton(icon: Icon(Icons.arrow_back_ios),
        onPressed:(){
          Navigator.pop(context);
        },
        ),
      ),

      body:Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: <Widget>[
            Padding(
            padding: EdgeInsets.only(bottom:80),
            child: ListView.builder(
                reverse: true,
                itemCount: listdata.length,
                itemBuilder: (context , index){
                  return massege(context , listdata[listdata.length-(1+index)]);
                },
                  
                ),
            ),

            Positioned(
              bottom: 0,
              left: ((MediaQuery.of(context).size.width*0.1 - 20) /2),
              child: Container(
                padding: EdgeInsets.all(10),
                              child: Container(
                  width: MediaQuery.of(context).size.width*0.9,
                  height: 50,
                decoration:BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(color: Colors.black12 , blurRadius: 2 , spreadRadius: 2)
                  ],
                  borderRadius: BorderRadius.circular(40)
                  ),
                  child: Stack(
                    alignment: const Alignment(1.0, 1.0),
                    children: <Widget>[
                      ClipRRect(
                              borderRadius: BorderRadius.circular(30),
                              child: TextFormField(
                                controller: textController,
                                style: TextStyle(color: Colors.black54, fontSize: 13),
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(right: 20.0 , left:MediaQuery.of(context).size.width*0.23,),
                                  border: InputBorder.none,
                                  filled: true,
                                  fillColor: Colors.white,
                                  hintText: "اكتب رسالك",
                                  hintStyle:
                                      TextStyle(color: Colors.black26, fontSize: 12),
                                ),
                              ),
                            ),
                      Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(right:MediaQuery.of(context).size.width*0.55),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            // Padding(
                            //   padding: const EdgeInsets.only(left:3.0),
                            //   child: Icon(Icons.camera_alt, color:Colors.black26, size: 25),
                            // ),
                            // Padding(
                            //   padding: const EdgeInsets.only(left:3.0),
                            //   child: Icon(Icons.mic, color:Colors.black26, size: 25),
                            // ),
                            Container(width:1,height:35,color:Colors.black12),
                            GestureDetector(
                              onTap: (){
                                if(textController.text != "" && textController.text != null){
                                sendmessage(textController.text);
                                textController.text="";
                                }
                              },
                                child: Container(
                                alignment: Alignment.center,
                                height: 55,
                                width: MediaQuery.of(context).size.width*0.19,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(topLeft:Radius.circular(25) ,bottomLeft:Radius.circular(25) , ),
                                ),
                                child: Text("إرسال",style: TextStyle(color: Colors.black26, fontSize: 12),),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      )
    );
  }

  Widget massege(BuildContext context, var listofMessage){
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('dd').format(now);
    
    // true = user .. false me
    String msg = listofMessage["msg"];
    String sender = listofMessage['sender'];
    String seen = listofMessage["seen"];
    String time = listofMessage["time"];
    String date = listofMessage["date"];
    String megId = listofMessage["messageID"];
    String messageDate ;
    if("$seen" == "0" && myId != sender){
      setseen(megId);
    }
    if(formattedDate == "${date[8]}${date[9]}"){
      messageDate = time;
    }else{
      messageDate = date;
    }
    return Container(
              alignment: sender == userId?Alignment.topRight:Alignment.topLeft,
                          child: Container(
                margin: EdgeInsets.only(top:20, left: 15 , right: 15),
                width: MediaQuery.of(context).size.width*0.6,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color:sender == userId?Theme.of(context).primaryColor:Color(0xfff2f2f2)
                ),
                child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:<Widget>[
        Container(
          padding: EdgeInsets.only(top:12, right: 10 , left: 10),
          child: Text("$msg",textAlign: TextAlign.end ,style: TextStyle(color:sender == userId? Colors.white:Colors.black54 , fontSize:13),)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(padding: EdgeInsets.only(bottom:5, right: 10 , left: 10),child: Text("$messageDate",textAlign: TextAlign.end ,style: TextStyle(color:sender == userId? Colors.white:Colors.black54  , fontSize:11),)),
              Container(padding: EdgeInsets.only(bottom:5, right: 10 , left: 10),child: Text("$seen" == "1"?"قرأت":"لم تقرأ بعد",textAlign: TextAlign.end ,style: TextStyle(color:sender == userId? Colors.white:Colors.black54  , fontSize:11),)),
            ],
          ),
      ]
    ),
              ),
            );
  }

  readchatId() async {
    final prefs = await SharedPreferences.getInstance();
    final keych = 'chatid';
    final v = prefs.get(keych) ?? "";
    print("read chatID : $v");
    setState(() {
      mychatId = v;
    });
    }

  getonChatData(String myid , String userId) async{
    try{var url = "https://afkarestithmar.com/chat2/servicesapis.php?ApiType=getChat&username=$myid&%20to_username=$userId";
        var request = await http.get(url);
        //print(request.body);
        var data = jsonDecode(utf8.decode(request.bodyBytes));
        setState(() {
          listdata = data["items"];
        });
      }catch(e){
      print(e);
    }
  }

  setseen(String msgId)async{
    try{var url = "https://afkarestithmar.com/chat2/servicesapis.php?ApiType=seenmsgID&msgID=$msgId";
        await http.get(url);
        //print(request.body);
      }catch(e){
      print(e);
    }
  }

  sendmessage(String message)async{
    try{var url = "https://afkarestithmar.com/chat2/servicesapis.php?ApiType=sendChat&userID=$mychatId&username=$myId&to_username=$userId&toUserID=$userchatId&message=$message&mtype=2";
        var request = await http.get(url);
        //print(request.body);
        var data = jsonDecode(request.body);
        if(data[0]=="success"){
          getonChatData(myId , userId);
        }
        else{
          _asyncChangesDialog("حدث خطآ ما");
        }
        
      }catch(e){
      _asyncChangesDialog("خطأ في الاتصال تآكد من اتصالك بالانترنت");
    }
  }
  Future<String> _asyncChangesDialog(String message) async {
    var size = MediaQuery.of(context).size;
    final double height = size.height;
    double fontsmll = height/36;
     return showDialog<String>(
    context: context,
    builder: (BuildContext context) {
      return 
    AlertDialog(
        backgroundColor: Colors.white,
        title: Text('$message' ,
        textAlign: TextAlign.start,
         style: TextStyle(
           fontSize: fontsmll ,
           fontWeight: FontWeight.normal)),
        actions: <Widget>[
          FlatButton(
            
            child: Text('حسنا' ,
            textAlign: TextAlign.start,
            style: TextStyle(fontSize: fontsmll*0.85  , fontWeight: FontWeight.normal, color:Colors.black )),
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/main');
            },
          ),
        ],
);
    },
  );
}
}