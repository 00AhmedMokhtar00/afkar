import 'dart:convert';
import 'package:afkar/AppBar1.dart/appBar2.dart';
import 'package:afkar/models/message_model.dart';
import 'package:afkar/profile/profile.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'chat.dart';

class Massegs extends StatefulWidget {
  final String id;
  Massegs(this.id);

  @override
  _MassegsState createState() => _MassegsState();
}

class _MassegsState extends State<Massegs> {
  String get id => widget.id;
  Future messages;

  @override
  void initState() {
    //messages = getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar3(context, "الرسائل"),
      body: FutureBuilder<List<MessageModel>>(
          future: getData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          return customCard(snapshot.data[index]);
                        },
                      ),
                    ],
                  ),
                ),
              );
            } else if (snapshot.hasError) {
              return Center(child: Text("حدث خطأ اثناء إحضار البيانات!"));
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else {
              return Center(child: Text("لا يوجد رسائل!"));
            }
          }),
    );
  }

  Widget customCard(MessageModel messageModel) {
    return GestureDetector(
      onTap: () async{
        await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Chat(id, messageModel.userId,
                    messageModel.userChatId, messageModel.name)));
        setState(() {});
      },
      child: Container(
        margin: EdgeInsets.all(5),
        padding: EdgeInsets.only(left: 20, right: 20),
        decoration: BoxDecoration(
            boxShadow: [BoxShadow(color: Color(0xfff6f6f6), spreadRadius: 2)]),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: 10, bottom: 10),
                child: Row(
                  children: <Widget>[
                    Container(
                        margin: EdgeInsets.only(left: 15),
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(color: Colors.black12, spreadRadius: 2)
                          ],
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        Profile(id, messageModel.userId)));
                          },
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: messageModel.image != null || messageModel.image.isNotEmpty?
                              CachedNetworkImage(
                                fit: BoxFit.fill,
                                imageUrl: "https://afkarestithmar.com/" + messageModel.image,
                                placeholder: (context, url) => Container(
                                  padding: EdgeInsets.all(30),
                                  child: CircularProgressIndicator(),
                                ),
                                errorWidget: (context, url, error) => Image(
                                    image: AssetImage("images/profile.png")),
                              ): Image(image: AssetImage("images/profile.png"))
                          ),
                        )),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            messageModel.name,
                            style: TextStyle(
                                color: Colors.black54,
                                fontSize: 14,
                                fontWeight: FontWeight.w500),
                          ),
                          Container(
                              width: 200,
                              child: Text(
                                messageModel.lastMessage,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    color: Colors.black54, fontSize: 12),
                              )),
                        ])
                  ],
                ),
              ),
              Column(
                children: <Widget>[
                  messageModel.unreadMessagesCount > 0
                      ? Container(
                          alignment: Alignment.center,
                          width:
                              messageModel.unreadMessagesCount > 999 ? 35 : 25,
                          height: 25,
                          margin: EdgeInsets.only(bottom: 20),
                          decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(15)),
                          child: Text(
                            messageModel.unreadMessagesCount.toString(),
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          ),
                        )
                      : Container(),
                ],
              )
            ]),
      ),
    );
  }

  Future<List<MessageModel>> getData() async {
    List<MessageModel> messageModel = List();
    try {
      var url =
          "https://afkarestithmar.com/chat2/servicesapis.php?ApiType=getUsers&userID=$id";
      http.Response request = await http.get(url);
      var decodedData = jsonDecode(request.body);
      if (decodedData[0] == "success") {
        List data = decodedData[1];
        messageModel = data
            .map((message) => MessageModel(
                  userId: message["username"],
                  name: message["fullname"],
                  image: message["image"],
                  userChatId: message["userID"],
                  unreadMessagesCount: message["unread_messages_count"],
                ))
            .toList();
        for (int i = 0; i < messageModel.length; i++) {
          messageModel[i].lastMessage =
              await getLastMessage(id, messageModel[i].userId);
        }
        return messageModel;
      }
      return null;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<String> getLastMessage(String myId, String userId) async {
    try {
      var url =
          "https://afkarestithmar.com/chat2/servicesapis.php?ApiType=getChat&username=$myId&%20to_username=$userId";
      var request = await http.get(url);
      var data = json.decode(utf8.decode(request.bodyBytes));
      List listData = data["items"];
      if (listData.length > 0) {
        return listData[listData.length - 1]["msg"];
      }
      return "";
    } catch (e) {
      print(e);
      return "";
    }
  }
}
