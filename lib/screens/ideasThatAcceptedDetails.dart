
import 'package:afkar/AppBar1.dart/appBar2.dart';
import 'package:flutter/material.dart';

class IdeasThatAcceptedDetails extends StatefulWidget{
  final String name;
  final String domain;
  final String proposel;
  final String pre;
  final String details;
  final String id;
  IdeasThatAcceptedDetails(this.id , this.name , this.details , this.domain , this.pre , this.proposel);
  @override
  _IdeasThatAcceptedDetailsState createState() => _IdeasThatAcceptedDetailsState();
}

class _IdeasThatAcceptedDetailsState extends State<IdeasThatAcceptedDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar3(context, "تفاصيل الفكرة"),
      body: Container(
        alignment: Alignment.center,
              child: Container(
            width: MediaQuery.of(context).size.width*0.9,
            height: MediaQuery.of(context).size.height,
          child:SingleChildScrollView(
              child: Column(
              children:<Widget>[
                SizedBox(height:20),
                Text("إسم المفكر : ${widget.name}" , style: TextStyle(color:Colors.black54, fontSize: 16),),
                SizedBox(height:10),
                Text("مجال الفكره : ${widget.domain}" , style: TextStyle(color:Colors.black54, fontSize: 16),),
                SizedBox(height:10),
                Text("رأس المال : ${widget.proposel}" , style: TextStyle(color:Colors.black54, fontSize: 16),),
                SizedBox(height:10),
                Text("مقابل : ${widget.pre}" , style: TextStyle(color:Colors.black54, fontSize: 16),),
                SizedBox(height:10),
                Text("النص : ${widget.details}" , style: TextStyle(color:Colors.black54, fontSize: 16),),
              ]
            ),
          )
        ),
      ),
    );
  }
  
}
