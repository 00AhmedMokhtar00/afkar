import 'package:afkar/AppBar1.dart/appBar2.dart';
import 'package:flutter/material.dart';

class Makalah extends StatefulWidget{
  final String title;
  final String img;
  final String detail;

  Makalah(this.title , this.img , this.detail);

  @override
  _MakalahState createState() => _MakalahState();
}

class _MakalahState extends State<Makalah> {
  double numSize = 14;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar3(context , "مقالة"),
      body: Padding(
        padding: EdgeInsets.all(10),
              child: SingleChildScrollView(
          child:Column(
            children:<Widget>[
              Container(
                      alignment: Alignment.center,
                      child:Text("${widget.title}" , style: TextStyle(color:Colors.black54, fontSize: 16))
                    ),
                    Container(
                    height: 330,
                    width: MediaQuery.of(context).size.width,  
                    child: Image(image: NetworkImage("https://afkarestithmar.com/${widget.img}"),fit: BoxFit.contain,)),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      alignment: Alignment.center,
                      child:Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: (){
                            setState(() {
                              if(numSize < 35){
                                numSize = numSize+1;
                              }
                            });
                          },
                          child: Container(
                            alignment: Alignment.topCenter,
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              shape:BoxShape.circle
                            ),
                            child: Text("+" , style: TextStyle(fontSize:24 , color:Colors.white),textAlign: TextAlign.center,),
                          ),
                        ),
                        SizedBox(width:8),
                        Container(
                          child: Text("${numSize.toInt()}" , style: TextStyle(fontSize:17 , color:Colors.black54),textAlign: TextAlign.center,),
                        ),
                        SizedBox(width:8),
                       GestureDetector(
                          onTap: (){
                            print("tqpppp");
                            setState(() {
                              if (numSize > 8) {
                                numSize = numSize-1;
                              }
                            });
                          },
                            child: Container(
                            alignment: Alignment.topCenter,
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              shape:BoxShape.circle
                            ),
                            child: Text("-" , style: TextStyle(fontSize:24 , color:Colors.white),textAlign: TextAlign.center,),
                          ),
                        ),
                      ],),
                    ),
                    SizedBox(height:10),
                    Container(
                          alignment: Alignment.center,
                          child: Text("${widget.detail}" ,style:TextStyle(fontSize:numSize , color: Colors.black54),textAlign: TextAlign.center,),
                        ),
            ]
          )
        ),
      ),
    );
  }
}