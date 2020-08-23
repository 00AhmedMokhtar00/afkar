import 'dart:convert';
import 'package:afkar/models/thinker/thiker_model.dart';
import 'package:afkar/profile/chat.dart';
import 'package:http/http.dart' as http;
import 'package:afkar/profile/viewPhoto.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  final String myId, userId;
  Profile(this.myId, this.userId);
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String get myId => widget.myId;
  String get userId => widget.userId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _initialView()
    );
  }

  Widget _initialView(){
    return FutureBuilder<ThinkerModel>(
        future: _getUserData(),
        builder: (context, snapshot) {
          if(snapshot.hasData) {
            return SafeArea(
                child: Container(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    height: MediaQuery
                        .of(context)
                        .size
                        .height,
                    child: SingleChildScrollView(
                        child: Container(
                          color: Color(0xfff2f2f2),
                          width: MediaQuery
                              .of(context)
                              .size
                              .width,
                          height: 450,
                          child: Container(
                            width: MediaQuery
                                .of(context)
                                .size
                                .width,
                            color: Colors.white,
                            child: Stack(
                              children: <Widget>[
                                Positioned(
                                  top: 0,
                                  child: Container(
                                    padding: EdgeInsets.only(top: 5),
                                    alignment: Alignment.topRight,
                                    height: 200,
                                    width: MediaQuery
                                        .of(context)
                                        .size
                                        .width,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image:
                                            AssetImage(
                                                "images/cover.png"))),
                                    child: IconButton(
                                      icon: Icon(
                                        Icons.arrow_back_ios,
                                        size: 30,
                                        color: Colors.white,
                                      ),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ),
                                ),
                                Positioned(
                                    top: 140,
                                    left: (MediaQuery
                                        .of(context)
                                        .size
                                        .width -
                                        120) /
                                        2,
                                    child: GestureDetector(
                                      onTap: () {},
                                      child: Container(
                                        width: 120,
                                        height: 120,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius
                                              .circular(20),
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.white,
                                                spreadRadius: 5)
                                          ],
                                        ),
                                        child: GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        PhotoView(
                                                            snapshot.data.img == null ||
                                                                snapshot.data.img == ""
                                                                ? "https://afkarestithmar.com/userfiles/5ec6c63caf6b8_profile.png"
                                                                : "https://afkarestithmar.com/" + snapshot.data.img)
                                                )
                                            );
                                          },
                                          child: ClipRRect(
                                            borderRadius:
                                            BorderRadius.circular(20),
                                            child: FadeInImage.assetNetwork(
                                              image: snapshot.data.img == null ||
                                                  snapshot.data.img == ""
                                                  ? "https://afkarestithmar.com/userfiles/5ec6c63caf6b8_profile.png"
                                                  : "https://afkarestithmar.com/" + snapshot.data.img,
                                              placeholder: 'images/profile.png',
                                              width: 60,
                                              height: 80,
                                              fit: BoxFit.cover,
                                            ),
                                            //               child: CachedNetworkImage(
                                            //                 width: 100,
                                            //                 height: 100,
                                            //                 fit: BoxFit.fill,
                                            //          imageUrl: "$imgurl",
                                            //  placeholder: (context, url) => Container(
                                            //    padding: EdgeInsets.all(30),
                                            //    child:CircularProgressIndicator(),),
                                            // errorWidget: (context, url, error) => Image(image: AssetImage("images/profile.png")),
                                            //  ),
                                          ),
                                        ),
                                      ),
                                    )),
                                Positioned(
                                  top: 260,
                                  width: MediaQuery
                                      .of(context)
                                      .size
                                      .width,
                                  child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                      children: <Widget>[
                                        SizedBox(height: 5.0),
                                        Text(
                                          snapshot.data.name == null ? "" : snapshot.data.name,
                                          style: TextStyle(
                                              color: Colors.black54,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        SizedBox(height: 5.0),
                                        Text(
                                          snapshot.data.type == null ? "" : snapshot.data.type == "think"? "مُفكر" : "مستثمر",
                                          style: TextStyle(
                                              color: Colors.black54,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        SizedBox(height: 5.0),
                                        Text(snapshot.data.mobile == null ? "":snapshot.data.mobile,style: TextStyle(color: Colors.black54, fontSize: 16 , fontWeight: FontWeight.w500),),
                                        SizedBox(height: 5.0),
                                        Text(snapshot.data.email == null ? "":snapshot.data.email,style: TextStyle(color: Colors.black54, fontSize: 16 , fontWeight: FontWeight.w500),),
                                        SizedBox(height: 20.0),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 20.0, right: 20),
                                          child: Text(
                                            snapshot.data.about == null ? "" : snapshot.data.about,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Colors.black54,
                                                fontSize: 15,
                                                fontWeight: FontWeight
                                                    .w500),
                                          ),
                                        ),
                                          myId == userId ?Container():GestureDetector(
                                            onTap: (){
                                              Navigator.push(context, MaterialPageRoute(builder: (context)=>Chat(myId , userId , snapshot.data.chatFriendID , snapshot.data.name)));
                                            },
                                                               child: Container(
                                              margin: EdgeInsets.only(top:10),
                                              alignment: Alignment.center,
                                              width: 80,
                                                 height: 35,

                                                 decoration: BoxDecoration(
                                                   borderRadius: BorderRadius.circular(20),
                                                   color: Color(0xfff0f0f0)
                                                   ),
                                                   child: Row(
                                                     mainAxisAlignment: MainAxisAlignment.center,
                                              children: <Widget>[
                                                  Image(image: AssetImage("images/message.png"), width: 18,height: 18,),
                                                  Text("مراسلة",style: TextStyle(color: Colors.black54, fontSize: 11 , fontWeight: FontWeight.w500),),
                                              ],
                                            ),
                                            ),
                                          )
                                      ]),
                                ),
                              ],
                            ),
                          ),
                        ))));
          }else if(snapshot.hasError){
            return Text(snapshot.error);
          } else{
            return Center(child: CircularProgressIndicator());
          }
        });
  }

  Future<ThinkerModel> _getUserData() async {
    try {
      var url =
          "https://afkarestithmar.com/api/api.php?type=loginID&id=$userId";
      http.Response response = await http.get(url);

      var userData = jsonDecode(response.body);

      if (userData['success'] == 1) {
        ThinkerModel user = ThinkerModel(
          id: userData["Id"],
          name: userData["Name"],
          email: userData["Email"],
          mobile: userData["Mobile"],
          img: userData["img"],
          about: userData["About"],
          address: userData["address"],
          type: userData["type"],
          price: userData["price"],
          token: userData["token"],
          chatFriendID: userData["chatfriendID"],
        );
        return user;
      }
    } catch (e) {
      print(e);
    }
    return null;
  }
}
