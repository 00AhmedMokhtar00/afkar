import 'package:flutter/material.dart';

class PhotoView extends StatelessWidget{
  final String img;
  PhotoView(this.img);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
        onTap: (){
          Navigator.pop(context);
        },
        child: Container(
          alignment: Alignment.center,
        color:Color(0xaa000000),
        width:size.width,
        height: size.height,
        child: SingleChildScrollView(child:
         Column(
           children: <Widget>[
             Image(fit: BoxFit.fitWidth, image: NetworkImage(img)),
           ],
         )),
      ),
    );
  }
}