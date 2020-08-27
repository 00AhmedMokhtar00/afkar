import 'dart:convert';
import 'package:afkar/backEnd/getDataId.dart';
import 'package:afkar/backEnd/updateImage.dart';
import 'package:afkar/backEnd/uploadImage.dart';
import 'package:afkar/main.dart';
import 'package:afkar/profile/profile.dart';
import 'package:afkar/profile/viewPhoto.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class UpdateProfile extends StatefulWidget {
  String uploadedImage;
  bool uploaded;

  UpdateProfile({this.uploadedImage, this.uploaded = false}){
    if(uploaded){
      uploadedImage = uploadedImage.split('../').last;
      print("IMAGE UPDATED!!!!! " + uploadedImage);

      AppState().setImage(uploadedImage);
    }
  }

  @override
  _UpdateProfileState createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  final _formKey = GlobalKey<FormState>();
  String messageGren = "";
  String messageRed = "";
  TextEditingController _controllerAbout;
  String name, img, details, email, phone, password;
  @override
  void initState() {
    super.initState();
    _controllerAbout = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Container(
              child: Text(
            "الملف الشخصي",
            style: TextStyle(
                fontWeight: FontWeight.w400, fontSize: 18, color: Colors.white),
          )),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),

        body: _initialView()
    );
  }

  _initialView(){
    AppState appState = Provider.of<AppState>(context);
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          _profilePhotoView(),
          _briefView(),
          _profileDataView(),
          _alertMessageView(),
          _errorAlertMessageView(),
          _saveChangesButton(),
        ],
      ),
    );
  }

  _profilePhotoView(){
    AppState appState = Provider.of<AppState>(context);
    return Container(
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.center,
      margin: EdgeInsets.only(top: 20),
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: 10),
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: Colors.black45,
              borderRadius: BorderRadius.circular(100),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: widget.uploadedImage != null || (appState.image != null && appState.image.isNotEmpty)? CachedNetworkImage(
                fit: BoxFit.fill,
                imageUrl: widget.uploadedImage == null? "https://afkarestithmar.com/" + appState.image:"https://afkarestithmar.com/${widget.uploadedImage}",
                placeholder: (context, url) => Container(
                  padding: EdgeInsets.all(30),
                  child: CircularProgressIndicator(),
                ),
                errorWidget: (context, url, error) =>
                    Image(image: AssetImage("images/profile2.png")),
              ):Image(image: AssetImage("images/profile2.png")),
            ),
          ),
          Text(
            appState.name,
            style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 15,
                color: Colors.black54),
          ),
//          Container(
//            margin: EdgeInsets.only(top: 5),
//            alignment: Alignment.center,
//            width: 180,
//            height: 55,
//            decoration: BoxDecoration(
//              color: Color(0xfff9f9f9),
//              borderRadius: BorderRadius.circular(30),
//            ),
//            child: GestureDetector(
//              onTap: () {
//                Navigator.push(
//                    context,
//                    MaterialPageRoute(
//                        builder: (context) =>
//                            Profile(appState.getid, appState.getid)));
//              },
//              child: Row(
//                  mainAxisAlignment: MainAxisAlignment.center,
//                  children: <Widget>[
//                    Text(
//                      "عرض كما يظهر للآخرين",
//                      style: TextStyle(
//                          color: Colors.black54,
//                          fontWeight: FontWeight.w500,
//                          fontSize: 13),
//                    ),
//                    SizedBox(width: 5),
//                    Icon(
//                      Icons.remove_red_eye,
//                      size: 25,
//                      color: Theme.of(context).primaryColor,
//                    )
//                  ]),
//            ),
//          ),
          Container(
            margin: EdgeInsets.only(top: 5),
            alignment: Alignment.center,
            width: 145,
            height: 55,
            decoration: BoxDecoration(
              color: Color(0xfff9f9f9),
              borderRadius: BorderRadius.circular(30),
            ),
            child: GestureDetector(
              onTap: () {
                _settingModalBottomSheet(context);
              },
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "رفع صورة",
                      style: TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.w500,
                          fontSize: 13),
                    ),
                    SizedBox(width: 5),
                    Image(
                        width: 35,
                        height: 35,
                        image: AssetImage("images/uploadphoto.png")),
                  ]),
            ),
          ),
        ],
      ),
    );
  }

  _briefView(){
    AppState appState = Provider.of<AppState>(context);
    return Container(
      padding: EdgeInsets.all(15),
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.topRight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 8.0, bottom: 2),
            child: Text(
              "نبذة عنك",
              textAlign: TextAlign.right,
              style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w500,
                  fontSize: 14),
            ),
          ),
          TextField(
            controller: _controllerAbout,
            keyboardType: TextInputType.text,
            style: TextStyle(color: Colors.black54, fontSize: 14),
            maxLines: 2,
            maxLength: 120,
            decoration: InputDecoration(
              helperText: appState.about,
              contentPadding: const EdgeInsets.all(10.0),
              border: InputBorder.none,
              filled: true,
              fillColor: Color(0xfff9f9f9),
              hintText: "اكتب هنا نبذة قصيرة عنك",
              hintStyle:
              TextStyle(color: Colors.black26, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }

  _profileDataView(){
    AppState appState = Provider.of<AppState>(context);
    return Column(children: <Widget>[
      GestureDetector(
          onTap: () {
            _asyncChangesDialog(context, "الاسم", "name");
          },
          child: customCard(Icons.person, "الاسم كاملاً", appState.name)
      ),
      GestureDetector(
          onTap: () {
            _asyncChangesDialog(
                context, "البريد الالكتروني", "email");
          },
          child: customCard(
              Icons.message, "البريد الالكتروني", appState.email)
      ),
      GestureDetector(
          onTap: () {
            _asyncChangesDialog(context, "رقم الهاتف", "phone");
          },
          child: customCard(Icons.phone, "رقم الجوال", appState.phone)),
      GestureDetector(
          onTap: () {
            _asyncPasswordDialog(context);
          },
          child: customCard(
              Icons.confirmation_number, "تحديث كلمة المرور", "")
      )
    ]);
  }

  _alertMessageView(){
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      alignment: Alignment.center,
      width: 200,
      child: Text(
        "$messageGren",
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.left,
        style: TextStyle(
            color: Colors.green,
            fontWeight: FontWeight.w500,
            fontSize: 14),
      ),
    );
  }

  _errorAlertMessageView(){
    return Container(
      alignment: Alignment.center,
      width: 200,
      child: Text(
        "$messageRed",
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.left,
        style: TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.w500,
            fontSize: 14),
      ),
    );
  }

  _saveChangesButton(){
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(top: 25, bottom: 40),
      alignment: Alignment.center,
      child: ButtonTheme(
        minWidth: 100,
        height: 50,
        child: RaisedButton(
          padding:
          EdgeInsets.only(top: 5, bottom: 5, right: 30, left: 30),
          onPressed: () {
            setData();
          },
          shape: new RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30)),
          child: Text(
            "حفظ جميع التغييرات",
            textAlign: TextAlign.right,
            style: TextStyle(color: Colors.white70, fontSize: 13),
          ),
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }


  Widget customCard(IconData icon, String title, String content) {
    return Card(
      elevation: 0.2,
      color: Color(0xfffefefe),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(children: <Widget>[
                // Image(image: AssetImage("$url"),width: 22,height: 22,),
                Icon(icon, size: 25, color: Theme.of(context).primaryColor),
                SizedBox(width: 5),
                Text(
                  "$title",
                  textAlign: TextAlign.right,
                  style: TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.w500,
                      fontSize: 14),
                ),
              ]),
              Row(children: <Widget>[
                Container(
                  alignment: Alignment.centerLeft,
                  width: 100,
                  child: Text(
                    "$content",
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.w500,
                        fontSize: 14),
                  ),
                ),
                SizedBox(width: 15),
                Icon(Icons.edit,
                    size: 22, color: Theme.of(context).primaryColor),
              ])
            ]),
      ),
    );
  }

  void _settingModalBottomSheet(context) {
    AppState appState = Provider.of<AppState>(context, listen: false);
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            height: 110, //(MediaQuery.of(context).size.height*0.18),
            child: ListView(
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.edit),
                  title: Text(
                    'رفع صورة جديدة',
                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 15),
                  ),
                  onTap: () async {
                    await ImagePicker.pickImage(source: ImageSource.gallery)
                        .then((file) {
                          print("File of the fucking path: " + file.path);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  UploadImageProfile(image: file, pro: true)
                          )
                      );

                    });
                  },
                ),
//                ListTile(
//                  leading: Icon(Icons.delete),
//                  title: Text(
//                    'حذف',
//                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 15),
//                  ),
//                  onTap: () {
//                    updateProfileImage(context, "5ec6c63caf6b8_profile.png")
//                        .then((c) {
//                      Navigator.pop(context);
//                      Navigator.pushReplacement(
//                          context,
//                          MaterialPageRoute(
//                              builder: (context) => UpdateProfile(
//                                  appState.getid,
//                                  "https://afkarestithmar.com/userfiles/5ec6c63caf6b8_profile.png",
//                                  appState.getname,
//                                  appState.getphone,
//                                  appState.getabout,
//                                  appState.getemail)));
//                    });
//                  },
//                ),
              ],
            ),
          );
        });
  }

  Future<String> _asyncChangesDialog(
      BuildContext context, String type, String object) async {
    var size = MediaQuery.of(context).size;
    final double height = size.height;
    double fontsmll = height / 36;
    TextEditingController _controller = TextEditingController();
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text(
            'تعديل $type',
            textAlign: TextAlign.start,
            style: TextStyle(fontSize: fontsmll, fontWeight: FontWeight.normal),
          ),
          content: Form(
            key: _formKey,
            child: TextFormField(
              style: TextStyle(
                fontSize: fontsmll * 0.9,
                fontFamily: 'cairo',
              ),
              decoration: InputDecoration(
                labelStyle: TextStyle(
                  fontSize: fontsmll * 0.9,
                  fontFamily: 'cairo',
                ),
                hintStyle: TextStyle(
                    fontSize: fontsmll * 0.9,
                    fontFamily: 'cairo',
                    color: Colors.black26),
                labelText: 'اكتب $type المراد استبداله',
                hintText: '',
              ),
              controller: _controller,
              validator: (input) =>
                  input.isEmpty ? 'برجاء ملئ هذا الحقل' : null,
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('الغاء',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontSize: fontsmll * 0.85,
                      fontWeight: FontWeight.normal,
                      color: Colors.black)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text('تأكيد',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontSize: fontsmll * 0.85,
                      fontWeight: FontWeight.normal,
                      color: Colors.black)),
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  setState(() {
                    object == "name"
                        ? this.name = _controller.text
                        : object == "phone"
                            ? this.phone = _controller.text
                            : this.email = _controller.text;
                  });
                  Navigator.pop(context);
                }
              },
            ),
          ],
        );
      },
    );
  }

  Future<String> _asyncPasswordDialog(BuildContext context) async {
    AppState appState = Provider.of<AppState>(context, listen: false);
    var size = MediaQuery.of(context).size;
    final double height = size.height;
    double fontsmll = height / 36;
    TextEditingController _controller = TextEditingController();
    TextEditingController _controller2 = TextEditingController();
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text(
            'تعديل كلمة المرور',
            textAlign: TextAlign.start,
            style: TextStyle(fontSize: fontsmll, fontWeight: FontWeight.normal),
          ),
          content: Form(
            key: _formKey,
            child: Wrap(
              children: <Widget>[
                TextFormField(
                  style: TextStyle(
                    fontSize: fontsmll * 0.9,
                    fontFamily: 'cairo',
                  ),
                  obscureText: true,
                  decoration: InputDecoration(
                    labelStyle: TextStyle(
                      fontSize: fontsmll * 0.9,
                      fontFamily: 'cairo',
                    ),
                    hintStyle: TextStyle(
                        fontSize: fontsmll * 0.9,
                        fontFamily: 'cairo',
                        color: Colors.black26),
                    labelText: 'كلمة المرور الجديدة',
                    hintText: '',
                  ),
                  controller: _controller,
                  validator: (input) =>
                      input.isEmpty ? 'برجاء ملئ هذا الحقل' : null,
                ),
                TextFormField(
                  obscureText: true,
                  style: TextStyle(
                    fontSize: fontsmll * 0.9,
                    fontFamily: 'cairo',
                  ),
                  decoration: InputDecoration(
                    labelStyle: TextStyle(
                      fontSize: fontsmll * 0.9,
                      fontFamily: 'cairo',
                    ),
                    hintStyle: TextStyle(
                        fontSize: fontsmll * 0.9,
                        fontFamily: 'cairo',
                        color: Colors.black26),
                    labelText: 'اعد كتابة كلمة المرور',
                    hintText: '',
                  ),
                  controller: _controller2,
                  validator: (input) =>
                      input.isEmpty ? 'برجاء ملئ هذا الحقل' : null,
                ),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('الغاء',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontSize: fontsmll * 0.85,
                      fontWeight: FontWeight.normal,
                      color: Colors.black)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text('تأكيد',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontSize: fontsmll * 0.85,
                      fontWeight: FontWeight.normal,
                      color: Colors.black)),
              onPressed: () {
                if (_formKey.currentState.validate() &&
                    _controller.text == _controller2.text) {
                  setState(() {
                    updatePass(appState.id, _controller.text.trim());
                  });
                  Navigator.pop(context);
                }
              },
            ),
          ],
        );
      },
    );
  }

  setData() async {
    AppState appState = Provider.of<AppState>(context, listen: false);
    setState(() {
      messageRed = "";
      messageGren = "";
    });
    try {
      var url =
          "https://afkarestithmar.com/api/api.php?type=updateAll&id=${appState.id}&name=${name??appState.name}&Mobile=${phone??appState.phone}&img=${widget.uploadedImage??appState.image}&about=${_controllerAbout.text.trim().isNotEmpty?_controllerAbout.text.trim():""}&Email=${email??appState.email}";
      print(url);
      var request = await http.post(url);
      var data = jsonDecode(request.body);
      if ("${data['success']}" == "1") {
        getDataId(context);
        setState(() {
          messageGren = data["message"];
        });
      } else {
        setState(() {
          messageRed = data['message'];
        });
      }
    } catch (e) {
      print(e.toString());
      setState(() {
        messageRed = "$e";
      });
    }
  }

  updatePass(String id, String password) async {
    setState(() {
      messageRed = "";
      messageGren = "";
    });
    try {
      var url =
          "https://afkarestithmar.com/api/api.php?type=updatepass&pass=$password&id=$id";
      var request = await http.get(url);
      print(request.body);
      var data = jsonDecode(request.body);
      if ("${data['success']}" == "1") {
        setState(() {
          messageGren = "تم تحديث كلمة المرور";
        });
      } else {
        setState(() {
          messageRed = data['message'];
        });
      }
    } catch (e) {
      print(e);
      setState(() {
        messageRed = "Error From Server or Network";
      });
    }
  }
}
