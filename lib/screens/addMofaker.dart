import 'dart:convert';
import 'package:afkar/backEnd/uploadAnyPhoto.dart';
import 'package:afkar/firebase/push_notifications.dart';
import 'package:afkar/screens/articles.dart';
import 'package:afkar/screens/verify_idea.dart';
import 'package:flutter/services.dart';
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

import 'orders/orders.dart';

class AddMofaker extends StatefulWidget {
  @override
  _AddMofakerState createState() => _AddMofakerState();
}

class _AddMofakerState extends State<AddMofaker> {
  String domainID;
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
    domainID = '';
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
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(9),
                        ],
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
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(2),
                          ],
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
                  value: domainID,
                  onSaved: (value) {
                    setState(() {
                      domainID = value;
                    });
                  },
                  onChanged: (value) {
                    setState(() {
                      domainID = value;
                      print(domainID);
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
                    || statu == "" || domainID == ""){
                      alertTost("يرجي ملئ جميع الحقول");
                    }else{
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Cont1AddMofaker(conTitle.text,
                                conPrice.text,conPer.text , domainID ,statu, conAbout.text , conCode.text)
                        )
                    );
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
  File _file1, _file2;

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
                  onTap: () async{
                    _file1 = await _pickImageFromGallery();
                    setState(() {});
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: 20),
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    color: Colors.white,
                    child: _file1 == null
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
                                "اضافة دراسة جدوى",
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
                GestureDetector(
                  onTap: () async{
                    _file2 = await _pickImageFromGallery();
                    setState(() {});
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: 20),
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    color: Colors.white,
                    child: _file2 == null
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
                          "اضافة تقرير حساب النسب",
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
                                      _file1,
                                      _file2
                                  )
                              )
                          );
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
                      ),
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
                    ])
              ],
            ),
          )),
    );
  }

  Future<File>_pickImageFromGallery() async {
    return await FilePicker.getFile(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
  }
}

class Cont2AddMofaker extends StatefulWidget {
  final String title;
  final String price;
  final String per;
  final String state;
  final String domainID;
  final String about;
  final String code;
  final File _file1, _file2;
  Cont2AddMofaker(this.title, this.price,this.per ,this.domainID , this.state, this.about, this.code , this._file1, this._file2);

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

                    Text(widget._file1 == null? "" : widget._file1.path,
                        style: TextStyle(fontSize: 18, color: Colors.black)),
                    Text(widget._file2 == null? "" : widget._file2.path,
                        style: TextStyle(fontSize: 18, color: Colors.black)),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            isLoading?Center(child: CircularProgressIndicator()):Container(),
            GestureDetector(
              onTap: () async{
                setState(() => isLoading = true);
                if(widget._file1 != null || widget._file2 != null){
                  if(widget._file1 != null){
                    final String path1 = await uploadAnyPhoto(widget._file1);
                    if(widget._file2 != null){
                      final String path2 = await uploadAnyPhoto(widget._file2);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => Cont3AddMofaker(
                                domainID: widget.domainID,
                                title: widget.title,
                                price: widget.price,
                                about: widget.about,
                                code: widget.code,
                                per: widget.per,
                                state: widget.state,
                                ur2: "userfiles/$path2",
                                ur: "userfiles/$path1",
                              )
                          )

                      );
                      //await getTalabaty(context , "userfiles/$path1", "userfiles/$path2");
                    }else{
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => Cont3AddMofaker(
                                domainID: widget.domainID,
                                title: widget.title,
                                price: widget.price,
                                about: widget.about,
                                code: widget.code,
                                per: widget.per,
                                state: widget.state,
                                ur2: "",
                                ur: "userfiles/$path1",
                              )
                          )

                      );
                      //await getTalabaty(context , "userfiles/$path1", "");
                    }
                  }else {
                    final String path2 = await uploadAnyPhoto(widget._file2);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => Cont3AddMofaker(
                              domainID: widget.domainID,
                              title: widget.title,
                              price: widget.price,
                              about: widget.about,
                              code: widget.code,
                              per: widget.per,
                              state: widget.state,
                              ur2: "userfiles/$path2",
                              ur: "",
                            )
                        )

                    );
                    //await getTalabaty(context , "", "userfiles/$path2");

                  }
                }else{

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => Cont3AddMofaker(
                          domainID: widget.domainID,
                          title: widget.title,
                          price: widget.price,
                          about: widget.about,
                          code: widget.code,
                          per: widget.per,
                          state: widget.state,
                          ur2: "",
                          ur: "",
                        )
                    )

                  );
                   //await getTalabaty(context , "", "");
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
}

class Cont3AddMofaker extends StatefulWidget {
  String domainID, price, state, about, title, code, ur, ur2, per;
  Cont3AddMofaker({
    this.domainID,
    this.price,
    this.state,
    this.about,
    this.title,
    this.code,
    this.ur,
    this.ur2,
    this.per
  });
  @override
  _Cont3AddMofakerState createState() => _Cont3AddMofakerState();
}

class _Cont3AddMofakerState extends State<Cont3AddMofaker> {
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
                          "يجب دفع تكلفة ارسال فكرة المشروع للمستثمر، وتدفع لمرة واحدة، ستصلك العروض الاستثمارية علي بريدك الالكتروني وحسابك داخل التطبيق",
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
                Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () async{
                          await getTalabaty(pay: true);
                        },
                        child:Container(
                        alignment: Alignment.center,
                        //width: 120,
                        height: 50,
                        color: Theme.of(context).primaryColor,
                        child: Text("الإنتقال إلى صفحة الدفع",
                            style:
                                TextStyle(fontSize: 16, color: Colors.white)),
                      ),
                      ),
                      SizedBox(height: 20.0),
                      GestureDetector(
                        onTap: () async{
                          await getTalabaty();
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => Orders()
                              )
                          );
                        },
                        child:Container(
                          alignment: Alignment.center,
                          //width: 120,
                          height: 50,
                          color: Theme.of(context).primaryColor,
                          child: Text("إدفع لاحقاً",
                              style:
                              TextStyle(fontSize: 16, color: Colors.white)),
                        ),
                      ),
                      SizedBox(height: 20.0),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context, 
                              MaterialPageRoute(builder: (_) => Articles())
                          );
                        },
                        child: Container(
                          alignment: Alignment.center,
                          //width: 120,
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


  Future getTalabaty({bool pay = false})async{
    PushNotificationsManager pushNotificationsManager = PushNotificationsManager();
    AppState appState = Provider.of<AppState>(context,listen: false);
    try{
      var url = "https://afkarestithmar.com/api/api.php?type=addrequest&domain_id=${widget.domainID}&proposed_price=${widget.price}&status=${widget.state}&details=${widget.about}&title=${widget.title}&user_id=${appState.getid}&promocode=${widget.code}&attachs=\'${widget.ur}\',\'${widget.ur2}\'&invest_per=${widget.per}";
      print(url);
      var request = await http.get(url);
      var data = jsonDecode(request.body);
      if("${data['success']}"== "1"){
        print(data);
        alertTost("${data["message"]}");
        pushNotificationsManager.sendNotificationToInvestors();
        if(pay){
          Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => VerifyIdea(ideaID: data["request_id"].toString()))
          );
        }
      }
    }catch(e){
      print(e);
      alertTost(e.toString());
    }
  }
}


