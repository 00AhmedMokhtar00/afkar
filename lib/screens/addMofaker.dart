import 'dart:convert';
import 'package:afkar/backEnd/uploadAnyPhoto.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:afkar/alerts/alerts.dart';
import 'package:afkar/main.dart';
import 'package:afkar/screens/dataSource.dart';
import 'package:image_picker/image_picker.dart';
import 'package:afkar/AppBar1.dart/appBar2.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:material_dropdown_formfield/material_dropdown_formfield.dart';

class AddMofaker extends StatefulWidget {
  @override
  _AddMofakerState createState() => _AddMofakerState();
}

class _AddMofakerState extends State<AddMofaker> {
  String data;
  String statu ;
  FocusNode focusNode = FocusNode();

  TextEditingController conTitle = TextEditingController();
  TextEditingController conPrice = TextEditingController();
  TextEditingController conPer = TextEditingController();
  TextEditingController conAbout = TextEditingController();
  TextEditingController conCode = TextEditingController();
  @override
  void initState() {
    super.initState();
    data = '';
    statu = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff5f5f5),
      appBar: appBar3(context, "اضافة طلب"),

      //bottomNavigationBar: bottomNvBar(context, index : 1),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Form(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                TextField(
                  controller: conTitle,
                  keyboardType: TextInputType.text,
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 15,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  // maxLength: 160,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(12.0),
                    border: InputBorder.none,
                    filled: true,
                    fillColor: Color(0xffffffff),
                    hintText: "عنوان الاستثمار",
                    hintStyle: TextStyle(color: Colors.black26, fontSize: 13),
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  children: <Widget>[
                    Flexible(
                        child: TextField(
                        controller: conPrice,
                        keyboardType: TextInputType.number,
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 15,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        // maxLength: 160,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(12.0),
                          border: InputBorder.none,
                          filled: true,
                          fillColor: Color(0xffffffff),
                          hintText: "المبلغ المطلوب",
                          hintStyle: TextStyle(color: Colors.black26, fontSize: 13),
                        ),
                      ),
                    ),
                    SizedBox(width:10),
                    Flexible(
                        child: TextField(
                        controller: conPer,
                        keyboardType: TextInputType.number,
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 15,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        // maxLength: 160,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(12.0),
                          border: InputBorder.none,
                          filled: true,
                          fillColor: Color(0xffffffff),
                          hintText: "حصة المستثمر ٪",
                          hintStyle: TextStyle(color: Colors.black26, fontSize: 13),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                TextField(
                        controller: conCode,
                        keyboardType: TextInputType.number,
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 15,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        // maxLength: 160,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(12.0),
                          border: InputBorder.none,
                          filled: true,
                          fillColor: Color(0xffffffff),
                          hintText: "كود الخصم ان وجد",
                          hintStyle: TextStyle(color: Colors.black26, fontSize: 13),
                        ),
                      ),
                      SizedBox(height: 10),
                Container(
                color: Colors.white,
                child: DropDownFormField(
                 innerBackgroundColor: Colors.white,
                  wedgeIcon: Icon(Icons.keyboard_arrow_down),
                  wedgeColor: Colors.black54,
                  innerTextStyle: TextStyle(color: Colors.black54 , fontSize: 14),
                  focusNode: focusNode,
                  inputDecoration: OutlinedDropDownDecoration(
                      borderWidth: 0,
                      labelStyle: TextStyle(color: Colors.white),
                      labelText: "",
                      borderColor: Colors.white),
                  hintText: '-- المجال المفضل --',
                  value: data,
                  onSaved: (value) {
                    setState(() {
                      data = value;
                    });
                  },
                  onChanged: (value) {
                    setState(() {
                      data = value;
                      print(data);
                    });
                  },
                  dataSource: dataSource,
                  textField: 'display',
                  valueField: 'value',
                ),
                        ),
                  SizedBox(height: 10),
                      Container(
                      color: Colors.white,
                      child: DropDownFormField(
                       innerBackgroundColor: Colors.white,
                        wedgeIcon: Icon(Icons.keyboard_arrow_down),
                        wedgeColor: Colors.black54,
                        innerTextStyle: TextStyle(color: Colors.black54 , fontSize: 14),
                        focusNode: focusNode,
                        inputDecoration: OutlinedDropDownDecoration(
                            borderWidth: 0,
                            labelStyle: TextStyle(color: Colors.white),
                            labelText: "",
                            borderColor: Colors.white),
                        hintText: '-- حالة الإستثمار --',
                        value: statu,
                        onSaved: (value) {
                          setState(() {
                            statu = value;
                          });
                        },
                        onChanged: (value) {
                          setState(() {
                            statu = value;
                            print("this : $statu");
                          });
                        },
                        dataSource: state,
                        textField: 'display',
                        valueField: 'value',
                      ),
                        ),



                SizedBox(height: 10),
                TextField(
                  controller: conAbout,
                  keyboardType: TextInputType.text,
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 15,
                  ),
                  maxLines: 8,
                  //maxLength: 160,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(10.0),
                    border: InputBorder.none,
                    filled: true,
                    fillColor: Color(0xffffffff),
                    hintText: "نبذة عن المشروع او الفكرة",
                    hintStyle: TextStyle(color: Colors.black26, fontSize: 15),
                  ),
                ),
                SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    if(conTitle.text.trim() == "" || conPrice.text.trim() == "" 
                    ||  conPer.text.trim() == "" ||  conAbout.text.trim() == ""
                    || statu == "" || data == ""){
                      alertTost("يرجي ملئ جميع الحقول");
                    }else{
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Cont1AddMofaker(conTitle.text,
                                conPrice.text,conPer.text , data ,statu, conAbout.text , conCode.text)));
                    }
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    height: 45,
                    color: Theme.of(context).primaryColor,
                    child: Text("التالي",
                        style: TextStyle(fontSize: 17, color: Colors.white)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Cont1AddMofaker extends StatefulWidget {
  final String title;
  final String price;
  final String per;
  final String state;
  final String data;
  final String about;
  final String code;

  Cont1AddMofaker(this.title, this.price,this.per ,this.data ,this.state, this.about , this.code);

  @override
  _Cont1AddMofakerState createState() => _Cont1AddMofakerState();
}

class _Cont1AddMofakerState extends State<Cont1AddMofaker> {
  @override
  File _image;

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff5f5f5),
      appBar: appBar3(context, "اضافة طلب"),
      //bottomNavigationBar: bottomNvBar(context, index : 1),
      body: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(15),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // Padding(
                //   padding: const EdgeInsets.only(right: 8.0),
                //   child: Text(
                //     "هل لديك دراسة جدوي ؟",
                //     style: TextStyle(fontSize: 16, color: Colors.black),
                //     textAlign: TextAlign.right,
                //   ),
                // ),
                // RadioButtonGroup(
                //     orientation: GroupedButtonsOrientation.VERTICAL,
                //     labels: <String>[
                //       "نعم",
                //       "لا",
                //     ],
                //     onSelected: (String selected) => print(selected)),
                // SizedBox(height: 10),
                // Padding(
                //   padding: const EdgeInsets.only(right: 8.0),
                //   child: Text(
                //     "هل لديك خطة عمل ؟",
                //     style: TextStyle(fontSize: 16, color: Colors.black),
                //     textAlign: TextAlign.right,
                //   ),
                // ),
                // RadioButtonGroup(
                //     orientation: GroupedButtonsOrientation.VERTICAL,
                //     labels: <String>[
                //       "نعم",
                //       "لا",
                //     ],
                //     onSelected: (String selected) => print(selected)),
                // Padding(
                //   padding: const EdgeInsets.only(right: 8.0),
                //   child: Text(
                //     "هل لديك عرض استثماري ؟",
                //     style: TextStyle(fontSize: 16, color: Colors.black),
                //     textAlign: TextAlign.right,
                //   ),
                // ),
                // RadioButtonGroup(
                //     orientation: GroupedButtonsOrientation.VERTICAL,
                //     labels: <String>[
                //       "نعم",
                //       "لا",
                //     ],
                //     onSelected: (String selected) => print(selected)),
                GestureDetector(
                  onTap: () {
                    _pickImageFromGallery();
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: 20),
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    color: Colors.white,
                    child: _image == null
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Image(
                                image: AssetImage("images/upload.png"),
                                width: 32,
                                height: 32,
                              ),
                              SizedBox(width: 5),
                              Text(
                                "اضافة مرفق جديد",
                                style: TextStyle(
                                    fontSize: 15, color: Colors.black),
                                textAlign: TextAlign.right,
                              ),
                            ],
                          )
                        : Text(
                            "تم اضافة المرفق بنجاح",
                            style: TextStyle(fontSize: 15, color: Colors.green),
                            textAlign: TextAlign.right,
                          ),
                  ),
                ),
                SizedBox(height: 20),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          alignment: Alignment.center,
                          width: 120,
                          height: 50,
                          color: Theme.of(context).primaryColor,
                          child: Text("الخلف",
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white)),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Cont2AddMofaker(
                                      widget.title,
                                      widget.price,
                                      widget.per,
                                      widget.data,
                                      widget.state,
                                      widget.about,
                                      widget.code,
                                      _image)));
                        },
                        child: Container(
                          alignment: Alignment.center,
                          width: 120,
                          height: 50,
                          color: Theme.of(context).primaryColor,
                          child: Text("التالي",
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white)),
                        ),
                      )
                    ])
              ],
            ),
          )),
    );
  }

  _pickImageFromGallery() async {
    File file = await FilePicker.getFile();

    setState(() {
      _image = file;
    });
  }
}

class Cont2AddMofaker extends StatefulWidget {
  final String title;
  final String price;
  final String per;
  final String state;
  final String data;
  final String about;
  final String code;
  final File _image;
  Cont2AddMofaker(this.title, this.price,this.per ,this.data , this.state, this.about, this.code , this._image);

  @override
  _Cont2AddMofakerState createState() => _Cont2AddMofakerState();
}

class _Cont2AddMofakerState extends State<Cont2AddMofaker> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff5f5f5),
      appBar: appBar3(context, "اضافة طلب"),
      body: Container(
        padding: EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Column(children: <Widget>[
            Container(
              padding: EdgeInsets.all(15),
              width: MediaQuery.of(context).size.width,
              height: 300,
              alignment: Alignment.center,
              color: Colors.white,
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Text("${widget.title}",
                        style: TextStyle(fontSize: 18, color: Colors.black)),
                    Text("${widget.price}",
                        style: TextStyle(fontSize: 18, color: Colors.black)),
                    Text("${widget.per} %",
                        style: TextStyle(fontSize: 18, color: Colors.black)),
                    Text("${widget.about}",
                        style: TextStyle(fontSize: 18, color: Colors.black)),
                    widget._image != null?Image(
                        image: FileImage(widget._image),
                        fit: BoxFit.contain,
                        width: 80,
                        height: 80):Container()
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            isLoading?Center(child: CircularProgressIndicator()):Container(),
            GestureDetector(
              onTap: () async{
                setState(() => isLoading = true);
                if(widget._image != null){
                  await uploadAnyPhoto(widget._image).then((ur){
                    getTalabaty(context , "userfiles/$ur");
                  });
                
                }else{
                  await getTalabaty(context , "");
                }

                setState(() => isLoading = false);
              },
              child: Container(
                alignment: Alignment.center,
                width: 120,
                height: 50,
                color: Theme.of(context).primaryColor,
                child: Text("ارسال",
                    style: TextStyle(fontSize: 18, color: Colors.white)),
              ),
            )
          ]),
        ),
      ),
    );
  }
  // TODO
  Future getTalabaty(BuildContext context , String ur)async{
    AppState appState = Provider.of<AppState>(context,listen: false);
    try{
      var url = "https://afkarestithmar.com/api/api.php?type=addrequest&domain_id=${widget.data}&proposed_price=${widget.price}&status=${widget.state}&details=${widget.about}&title=${widget.title}&user_id=${appState.getid}&promocode=${widget.code}&attach=$ur&invest_per=${widget.per}";
      var request = await http.get(url);
        var data = jsonDecode(request.body);
        if("${data['success']}"== "1"){
          print(data);
          Navigator.pop(context);
          Navigator.pop(context);
          Navigator.pop(context);
          alertTost("${data["message"]}");
        } 
    }catch(e){
      print(e);
      alertTost(e);
    }
}
}

class Cont3AddMofaker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xfff5f5f5),
        appBar: appBar3(context, "اضافة طلب"),
        body: Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(15),
            child: SingleChildScrollView(
                child: Column(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 320,
                  color: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image(
                        image: AssetImage("images/wallet.png"),
                        width: 140,
                        height: 140,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text(
                          "تكلفة ارسال فكرة المشروع للمستثمر هي 200 ريال تدفع لمرة واحدة ستصلك العروض الاستثمارية علي بريدك الالكتروني وحسابك داخل التطبيق",
                          style: TextStyle(
                              color: Colors.black54,
                              fontSize: 15,
                              fontWeight: FontWeight.w500),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {},
                        child:Container(
                        alignment: Alignment.center,
                        width: 120,
                        height: 50,
                        color: Theme.of(context).primaryColor,
                        child: Text("دفع وارسال",
                            style:
                                TextStyle(fontSize: 18, color: Colors.white)),
                      ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.pop(context);
                          Navigator.pop(context);
                        },
                        child: Container(
                          alignment: Alignment.center,
                          width: 120,
                          height: 50,
                          color: Theme.of(context).primaryColor,
                          child: Text("الغاء",
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white)),
                        ),
                      )
                    ])
              ],
            ))));
  }
}
