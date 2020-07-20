import 'dart:convert';
import 'dart:io';
import 'package:afkar/backEnd/updateImage.dart';
import 'package:afkar/profile/updateProfile.dart';
import 'package:afkar/screens/offers.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'package:provider/provider.dart';
import '../main.dart';


class UploadImageProfile extends StatefulWidget{
  final File image;
  final bool pro;
  UploadImageProfile({this.image, this.pro});
  @override
  _UploadImageProfileState createState() => _UploadImageProfileState(this.image,this.pro);
}

class _UploadImageProfileState extends State<UploadImageProfile> {
  bool pro;
  var premisionState ;
  File image;
  _UploadImageProfileState(this.image,this.pro);
  bool isPlaying = false;
  bool starter = false;
  String message = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){
        registerCompany(image);
        setState(() {
        starter = true;
        });
      },
      child: Icon(Icons.send),
      ),
      body:SingleChildScrollView(
        child:Column(
          crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                width:MediaQuery.of(context).size.width,
                height:MediaQuery.of(context).size.height,
                alignment: Alignment.center,
                color:Colors.black,
              ),
              Positioned(
              top: 25,
              right: 10,
              child: IconButton(icon: Icon(Icons.arrow_back_ios) , color: Colors.white,iconSize: 30 , onPressed: (){
                Navigator.pop(context);
              })),
              Container(
                    padding: EdgeInsets.all(15),
                    //color: Colors.black,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    alignment: Alignment.center,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[                       
                   if(image != null) 
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Image.file(image, fit: BoxFit.fitWidth,),
                      
                    ),                
                    SizedBox(height:10),
                    Center(child: Text("$message" , style: TextStyle(color: Colors.red, fontWeight: FontWeight.w500, fontSize: 15),)),
                      
                      ])),
                  starter ? Container(
                  color: Colors.white54,
                  width: MediaQuery.of(context).size.width,
                  height:MediaQuery.of(context).size.height,
                  child: Center(child: CircularProgressIndicator())) : Container(),
            ],
          )
        ],)
      )
    );
  }
 registerCompany(File profileImage) async {
   AppState appState = Provider.of<AppState>(context,listen: false);
  try{
    var profileMediaType = {
    lookupMimeType(profileImage.path).split('/')[0]:
        lookupMimeType(profileImage.path).split('/')[1]
  };
  String url = 'https://afkarestithmar.com/api/uploadapi.php';
  Map<String, String> headers = {'Content-Type': 'multipart/form-data'};


  var formData = dio.FormData.fromMap({

    "logo": await dio.MultipartFile.fromFile(profileImage.path,
        contentType: MediaType(profileMediaType.keys.elementAt(0),
            profileMediaType.values.elementAt(0))),
  });
 // print('FormData:${formData.fields}');
  dio.Response response = await dio.Dio()
      .post(url, data: formData, options: dio.Options(headers: headers));
//  print('Status:${response.statusCode}');
    var data = jsonDecode(response.data);
    print(data[""]);
    if("${data["success"]}"== "1"){
      print("success");
      print(data);
      updateProfileImage(context, "${data["fileName"]}");
      Navigator.pop(context);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>UpdateProfile(appState.getid, "https://afkarestithmar.com/userfiles/${data["fileName"]}" , appState.getname, appState.getphone, appState.getabout, appState.getemail)));
    }

//  print('Response:${response.data.toString()}');
  }catch(e){
    print(e);
    setState(() {
      starter = false;
      message = "خطأ في رفع الصورة";
    });
  }
}
}
