
import 'package:afkar/AppBar1.dart/appBar2.dart';
import 'package:flutter/material.dart';
import 'package:material_dropdown_formfield/material_dropdown_formfield.dart';


class Pay extends StatefulWidget{
  @override
  _PayState createState() => _PayState();
}

class _PayState extends State<Pay> {
  String _myActivity;
  FocusNode focusNode = FocusNode();
  final formKey = new GlobalKey<FormState>();
  List dataSource=[
    {
      "display": "فيزا",
      "value": "v",
    },
    {
      "display": "ماستر كارد",
      "value": "va",
    },
    {
      "display": "باي بال",
      "value": "vaa",
    },
  ];

  @override
  void initState() {
    super.initState();
    _myActivity = '';

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: Color(0xfff5f5f5),
      appBar:appBar3(context , "طريقة الدفع"),
      body: Container(
        alignment: Alignment.topRight,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(10),
        child: Form(
            key: formKey,
            child: SingleChildScrollView(
                        child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("طريقة الدفع :",style: TextStyle(fontSize:17,color:Colors.black54 ),textAlign: TextAlign.right,),
                      SizedBox(height:10),
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
                        hintText: '-- اختر طريقة الدفع --',
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
                    ],
                  ),
                  SizedBox(height:15),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("رقم البطاقة :",style: TextStyle(fontSize:17,color:Colors.black54 ),textAlign: TextAlign.right,),
                      SizedBox(height:10),
                      TextField(
                              keyboardType: TextInputType.text,
                              style: TextStyle(color: Colors.black54, fontSize: 15 ,) ,
                              //maxLength: 160,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(16.0),
                                border: InputBorder.none,
                                filled: true,
                                fillColor: Color(0xffffffff),
                                hintText: "ادخل رقم البطاقة المكون من ١٦ رقم",
                                hintStyle:
                                    TextStyle(color: Colors.black26, fontSize: 12),
                              ),
                            ),
                    ],
                  ),
                  SizedBox(height:15),
                  Row(children:<Widget>[
                    Flexible(
                                          child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("كود الامان :",style: TextStyle(fontSize:17,color:Colors.black54 ),textAlign: TextAlign.right,),
                        SizedBox(height:10),
                        TextField(
                                keyboardType: TextInputType.text,
                                style: TextStyle(color: Colors.black54, fontSize: 15 ,) ,
                                //maxLength: 160,
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.all(16.0),
                                  border: InputBorder.none,
                                  filled: true,
                                  fillColor: Color(0xffffffff),
                                  hintText: "ادخل كود الامان المكون من ٣ رقم",
                                  hintStyle:
                                      TextStyle(color: Colors.black26, fontSize: 12),
                                ),
                              ),
                      ],
                  ),
                    ),
                  SizedBox(width:10),
                  Flexible(
                                      child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("تاريخ الانتهاء :",style: TextStyle(fontSize:17,color:Colors.black54 ),textAlign: TextAlign.right,),
                        SizedBox(height:10),
                        TextField(
                                keyboardType: TextInputType.text,
                                style: TextStyle(color: Colors.black54, fontSize: 15 ,) ,
                                //maxLength: 160,
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.all(16.0),
                                  border: InputBorder.none,
                                  filled: true,
                                  fillColor: Color(0xffffffff),
                                  hintText:"ادخل تاريخ انتهاء البطاقة",
                                  hintStyle:
                                      TextStyle(color: Colors.black26, fontSize: 12),
                                ),
                              ),
                      ],
                    ),
                  ),
                  ]),
                  
                        SizedBox(height:20),
                        GestureDetector(
                          onTap: (){
                          },
                            child: Container(
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width,
                            height: 55,
                            color: Theme.of(context).primaryColor,
                            child: Text("دفع" ,style:TextStyle(fontSize:17 , color: Colors.white)),
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

