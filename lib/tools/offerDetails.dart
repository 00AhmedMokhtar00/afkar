import 'package:flutter/material.dart';

class OfferDetails extends StatelessWidget{
  final String details;
  OfferDetails(this.details);
  @override
  Widget build(BuildContext context) {
    return Material(
          color: Color(0x00000000),
          child: GestureDetector(
          onTap: (){
            Navigator.pop(context);
          },
          child:Container(
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width,
        height:MediaQuery.of(context).size.height,
        color:Color(0xaa000000),
        child:GestureDetector(
          onTap: (){
            
          },
                  child: Container(
            padding: EdgeInsets.all(10),
            color: Colors.white,
            width: MediaQuery.of(context).size.width*0.9,
            height: 280,
            child: Column(
              children:<Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Container(
                  width: 40,
                  height: 40,
                  child: IconButton(icon: Icon(Icons.cancel), onPressed: (){
                    Navigator.pop(context);
                  },iconSize: 35,color: Colors.black45,)),

                  Container(
                    width: 110,
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(bottom:0),
                    decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(bottom: BorderSide(color: Colors.black26 , width: 2))
                    ),
                    child: Text("تفاصيل الافادة",style: TextStyle(fontSize:18,color:Colors.black54 ),),
                  ),

                  Container(width:40)
                ],
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  height: 220,
                child: Text("$details",style: TextStyle(fontSize:16,color:Colors.black54 ),)),

                // Row(
                //       mainAxisAlignment:MainAxisAlignment.spaceEvenly,
                //       children:<Widget>[
                //       GestureDetector(
                //         onTap: (){
                //           Navigator.push(context, MaterialPageRoute(builder: (context)=>Pay()));
                //         },
                //                               child: Container(
                //           alignment: Alignment.center,
                //           width: MediaQuery.of(context).size.width*0.4,
                //           height: 40,
                //           color: Theme.of(context).primaryColor,
                //           child: Text("قبول" ,style:TextStyle(fontSize:16 , color: Colors.white)),
                //         ),
                //       ),
                //       GestureDetector(
                //         onTap: (){
                //           Navigator.pop(context);
                //         },
                //           child: Container(
                //           alignment: Alignment.center,
                //           width: MediaQuery.of(context).size.width*0.4,
                //           height: 40,
                //           color: Color(0xfff0f0f0),
                //           child: Text("رفض" ,style:TextStyle(fontSize:16, color: Colors.black54)),
                //         ),
                //       ),
                //       ]
                //     )
              ]
            ),
          ),
        ),
        )
      ),
    );
  }
}