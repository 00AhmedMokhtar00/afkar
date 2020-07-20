import 'package:afkar/AppBar1.dart/appBar2.dart';
import 'package:afkar/backEnd/uploadImage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class OfferVerefied extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:appBar3(context,"العروض"),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        alignment: Alignment.topCenter,
        child:SingleChildScrollView(
          child:Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children:<Widget>[
              Container(
                margin: EdgeInsets.only(top:30),
              width: MediaQuery.of(context).size.width*0.65,  
              child: Text("لا يمكن رؤية العروض قبل التأكد من هويتك عبر ارسال صورة الهوية" , style: TextStyle(color:Colors.black54, fontSize: 18),textAlign: TextAlign.center,),),
              GestureDetector(
                onTap: ()async{
                  await ImagePicker.pickImage(source: ImageSource.gallery).then((file){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> UploadImageProfile(image:file) ));
                  });
                },
                              child: Container(
                margin: EdgeInsets.only(top:40),
                 width: 200,
                color: Colors.white,
                height: 160,
                child:Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image(image: AssetImage("images/uploadphoto.png"),width: 70,height: 70,),
                    Text("إرفاق صورة شخصية" , style: TextStyle(color:Colors.black54, fontSize: 14),),
                  ],
                ) ,),
              ),

              // GestureDetector(
              //   onTap: (){
              //     Navigator.push(context, MaterialPageRoute(builder: (context)=>Offers()));
              //   },
              //          child: Container(
              //             margin: EdgeInsets.only(top:20),
              //             alignment: Alignment.center,
              //             width: 200,
              //             height: 60,
              //             color: Theme.of(context).primaryColor,
              //             child: Text("ارسال" ,style:TextStyle(fontSize:16 , color: Colors.white)),
              //           ),
              // ),

            ]
          )
        )
      ),
    );
  }
}