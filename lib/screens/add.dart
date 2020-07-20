import 'package:afkar/AppBar1.dart/appBar2.dart';
import 'package:afkar/AppBar1.dart/bottomNavBar.dart';
import 'package:afkar/screens/dataSource.dart';
import 'package:flutter/material.dart';
import 'package:material_dropdown_formfield/material_dropdown_formfield.dart';


class AddOrder extends StatefulWidget{
  @override
  _AddOrderState createState() => _AddOrderState();
}

class _AddOrderState extends State<AddOrder> {
  String _myActivity;
  FocusNode focusNode = FocusNode();
  final formKey = new GlobalKey<FormState>();
  
  @override
  void initState() {
    super.initState();
    _myActivity = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: Color(0xfff5f5f5),
      appBar:appBar3(context , "اعداد طلب"),
      bottomNavigationBar: bottomNvBar(context, index : 1),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Form(
            key: formKey,
            child: SingleChildScrollView(
                        child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Flexible(
                          child: Container(
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
                            value: _myActivity,
                            onSaved: (value) {
                              setState(() {
                                _myActivity = value;
                              });
                            },
                            onChanged: (value) {
                              setState(() {
                                _myActivity = value;
                                print(_myActivity);
                              });
                            },
                            dataSource: dataSource,
                            textField: 'display',
                            valueField: 'value',
                          ),
                        ),
                      ),
                      SizedBox(width:5),

                      Flexible(
                            child: TextField(
                            keyboardType: TextInputType.text,
                            style: TextStyle(color: Colors.black54, fontSize: 15 ,),textAlign: TextAlign.center ,
                            maxLines: 1,
                            // maxLength: 160,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(17.0),
                              border: InputBorder.none,
                              filled: true,
                              fillColor: Color(0xffffffff),
                              hintText: "المبلغ المطروح للاستثمار",
                              hintStyle:
                                  TextStyle(color: Colors.black26, fontSize: 13),
                            ),
                          ),
                      ),
                    ],
                  ),
                  SizedBox(height:10),
                  Container(
                    alignment: Alignment.center,
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
                            hintText: '-- حالة الاستثمار --',
                            value: _myActivity,
                            onSaved: (value) {
                              setState(() {
                                _myActivity = value;
                              });
                            },
                            onChanged: (value) {
                              setState(() {
                                _myActivity = value;
                                print(_myActivity);
                              });
                            },
                            dataSource: state,
                            textField: 'display',
                            valueField: 'value',
                          ),
                        ),
                        SizedBox(height:15),
                  TextField(
                          keyboardType: TextInputType.text,
                          style: TextStyle(color: Colors.black54, fontSize: 15 ,) ,
                          maxLines: 8,
                          //maxLength: 160,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(10.0),
                            border: InputBorder.none,
                            filled: true,
                            fillColor: Color(0xffffffff),
                            hintText: "التفاصيل",
                            hintStyle:
                                TextStyle(color: Colors.black26, fontSize: 15),
                          ),
                        ),
                        SizedBox(height:10),
                        GestureDetector(
                          onTap: (){
                          },
                            child: Container(
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width,
                            height: 45,
                            color: Theme.of(context).primaryColor,
                            child: Text("تم" ,style:TextStyle(fontSize:17 , color: Colors.white)),
                          ),
                        ),
                        // GestureDetector(
                        //   onTap: (){
                        //     Navigator.push(context, MaterialPageRoute(builder: (context)=>AddMofaker()));
                        //   },
                        //     child: Container(
                        //     alignment: Alignment.center,
                        //     width: MediaQuery.of(context).size.width*0.4,
                        //     height: 45,
                        //     color: Theme.of(context).primaryColor,
                        //     child: Text("mofaker" ,style:TextStyle(fontSize:17 , color: Colors.white)),
                        //   ),
                        // ),
                ],
              ),
            ),
          ),
      ),
    );
  }

}

