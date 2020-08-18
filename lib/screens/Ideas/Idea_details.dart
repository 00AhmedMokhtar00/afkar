import 'package:afkar/AppBar1.dart/appBar2.dart';
import 'package:flutter/material.dart';

class IdeaDetails extends StatefulWidget{
  @override
  _IdeaDetailsState createState() => _IdeaDetailsState();
}

class _IdeaDetailsState extends State<IdeaDetails> {

    void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
     return Scaffold(
      backgroundColor: Color(0xfff4f4f4),
      appBar:appBar3(context , "العروض"),
      body: Container(),
     );
  }

}