

import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:afkar/models/thinker/thiker_model.dart';
import 'package:afkar/profile/profile.dart';
import 'package:http/http.dart' as http;
import 'package:afkar/AppBar1.dart/appBar2.dart';
import 'package:afkar/profile/viewPhoto.dart';
import 'package:material_dropdown_formfield/material_dropdown_formfield.dart';
import 'package:afkar/AppBar1.dart/bottomNavBar.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../main.dart';

class MostasmerList extends StatefulWidget {
  @override
  _MostasmerListState createState() => _MostasmerListState();
}

class _MostasmerListState extends State<MostasmerList> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xfff5f5f5),
        appBar: appBar3(context, "المستثمرين"),
        bottomNavigationBar: bottomNvBar(context, index: 3),
        body: _initialView()
    );
  }


  Widget _initialView(){
    return FutureBuilder<List<ThinkerModel>>(
        future: _getThinkersList(),
        builder: (context, snapshot) {
          if(snapshot.hasData) {
            return Container(
              margin: EdgeInsets.only(top: 5),
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              height: MediaQuery
                  .of(context)
                  .size
                  .height - 5,
              child: ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, i) {
                  return _thinkerCard(snapshot.data[i]);
                },
              ),
            );
          }else if(snapshot.hasError){
            return Text(snapshot.error);
          } else{
            return Center(child: CircularProgressIndicator());
          }
        }
    );
  }

  Widget _thinkerCard(ThinkerModel thinkerModel) {
    AppState appState = Provider.of<AppState>(context,listen: false);
    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => Profile(appState.id, thinkerModel.id))),
      child: Container(
        padding: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width,
        //height: 90,
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: Color(0xfff4f4f4),
            spreadRadius: 2,
          )
        ], color: Colors.white),
        child: Row(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Container(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PhotoView(thinkerModel.img ==
                                null ||
                                thinkerModel.img == ""
                                ? "http://matib.jaderplus.com/userfiles/5e6e6b8791988_profile.png"
                                : "https://afkarestithmar.com/" + thinkerModel.img)
                        )
                    );
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(200),
                    child: Container(
                      width: 65,
                      height: 65,
                      child: thinkerModel.img.isNotEmpty?CachedNetworkImage(
                        fit: BoxFit.cover,
                        imageUrl: "https://afkarestithmar.com/" + thinkerModel.img,
                        placeholder: (context, url) => Container(
                          padding: EdgeInsets.all(30),
                          child: CircularProgressIndicator(),
                        ),
                        errorWidget: (context, url, error) =>
                            Image(image: AssetImage("images/profile2.png")),

                      ):Image(image: AssetImage("images/profile2.png")),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(width: 10),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    thinkerModel.name,
                    style: TextStyle(color: Colors.black54, fontSize: 14),
                  ),
                  Text(
                    thinkerModel.about.length > 30?thinkerModel.about.substring(0,30) + " ...":thinkerModel.about,
                    style: TextStyle(color: Colors.black54, fontSize: 12),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }



  Future<List<ThinkerModel>> _getThinkersList() async {
    try {
      var url = "https://afkarestithmar.com/api/api.php?type=users&tt=1";

      http.Response response = await http.get(url);

      var data = jsonDecode(response.body);

      if (data['success'] == 1) {
        List thinkersData = data["users"];

        List<ThinkerModel> thinkers = List();

        thinkers.addAll(
            thinkersData.map(
                    (thinker) => ThinkerModel(
                  id: thinker["Id"],
                  name: thinker["Name"],
                  email: thinker["Email"],
                  mobile: thinker["Mobile"],
                  img: thinker["img"],
                  about: thinker["About"],
                  address: thinker["address"],
                  type: thinker["type"],
                  price: thinker["price"],
                  token: thinker["token"],
                  chatFriendID: thinker["chatfriendID"],
                )
            ).toList()
        );
        return thinkers;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }
}
