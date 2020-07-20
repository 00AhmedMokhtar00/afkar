import 'dart:convert';
import 'package:http/http.dart'as http;
import 'package:afkar/profile/viewPhoto.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget{
  
  final String myId , userId ;
  Profile(this.myId,this.userId);
  @override
  _ProfileState createState() => _ProfileState(this.myId, this.userId);
}

class _ProfileState extends State<Profile> {
  String myId , userId ;
  _ProfileState(this.myId , this.userId);
  String img , name , typer , phone , about , email;
  @override
  void initState() {
    getData(userId);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
   // AppState myState = Provider.of<AppState>(context,listen: false);
    return Scaffold(
      body: SafeArea(
              child: Container(
                 width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: SingleChildScrollView(
                                child: Column(
                    children: <Widget>[
                      Container(
                        color: Color(0xfff2f2f2),
                        width: MediaQuery.of(context).size.width,
                        height: 450,
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          color: Colors.white,
                          child: Stack(
          children: <Widget>[
            Positioned(
                          top:0,
                            child: Container(
                              padding: EdgeInsets.only(top:5),
                              alignment: Alignment.topRight,
                            height: 200,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              image:DecorationImage(fit: BoxFit.cover,image: AssetImage("images/cover.png"))
                            ),
                            child: IconButton(icon:Icon(Icons.arrow_back_ios , size: 30,color: Colors.white,),
                            onPressed: (){Navigator.pop(context);},
                            ),
                          ),
            ),
            Positioned(
                          top: 140,
                          left: (MediaQuery.of(context).size.width-120)/2,
            child: GestureDetector(
                onTap: (){
                  
                },
                            child: Container(
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(color: Colors.white, spreadRadius: 5)
                                ],
                              ),
                              child: GestureDetector(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>PhotoView(img == null || img == "" ? "https://afkarestithmar.com/userfiles/5ec6c63caf6b8_profile.png":img)));
                                },
                                child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: FadeInImage.assetNetwork(
                                      image: img == null || img == "" ? "https://afkarestithmar.com/userfiles/5ec6c63caf6b8_profile.png":img,
                                      placeholder:  'images/profile.png',
                                      width: 60,
                                      height: 80,
                                      fit: BoxFit.cover,
                                    ), 
                    //               child: CachedNetworkImage(
                    //                 width: 100,
                    //                 height: 100,
                    //                 fit: BoxFit.fill,
                    //          imageUrl: "$imgurl",
                    //  placeholder: (context, url) => Container(
                    //    padding: EdgeInsets.all(30),
                    //    child:CircularProgressIndicator(),),
                    // errorWidget: (context, url, error) => Image(image: AssetImage("images/profile.png")),
                    //  ),
                                  ),
                              ),
                ),
            )),
            Positioned(
                top:260,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children:<Widget>[
                     Text(name == null ? "":"$name",style: TextStyle(color: Colors.black54, fontSize: 16 , fontWeight: FontWeight.w500),),
                     Text(typer == null ? "":"$typer",style: TextStyle(color: Colors.black54, fontSize: 16 , fontWeight: FontWeight.w500),),
                    //  Text(phone == null ? "":"$phone",style: TextStyle(color: Colors.black54, fontSize: 16 , fontWeight: FontWeight.w500),),
                    //  Text(email == null ? "":"$email",style: TextStyle(color: Colors.black54, fontSize: 16 , fontWeight: FontWeight.w500),),
                     Padding(
                       padding: const EdgeInsets.only(left:20.0 , right: 20),
                       child: Text(about == null ? "":"$about",textAlign: TextAlign.center,style: TextStyle(color: Colors.black54, fontSize: 15 , fontWeight: FontWeight.w500),),
                     ),
                    //  myId == userId ?Container():GestureDetector(
                    //    onTap: (){
                    //      Navigator.push(context, MaterialPageRoute(builder: (context)=>Chat(myId , userId , userChatId , name)));
                    //    },
                    //                       child: Container(
                    //      margin: EdgeInsets.only(top:10),
                    //      alignment: Alignment.center,
                    //      width: 80,
                    //         height: 35,
                            
                    //         decoration: BoxDecoration(
                    //           borderRadius: BorderRadius.circular(20),
                    //           color: Color(0xfff0f0f0)
                    //           ),
                    //           child: Row(
                    //             mainAxisAlignment: MainAxisAlignment.center,
                    //      children: <Widget>[
                    //          Image(image: AssetImage("images/envelope.png"), width: 18,height: 18,),
                    //          Text("مراسلة",style: TextStyle(color: Colors.black54, fontSize: 11 , fontWeight: FontWeight.w500),),
                    //      ],
                    //    ),
                    //    ),
                    //  )
                    ]
                   ),),

                  
          ],
          
        ),
                        ),
                      ),
                      
      
                    ]))))
    );
  }
  Future getData(String id)async{
    try{var url = "https://afkarestithmar.com/api/api.php?type=loginID&id=$id";
        var request = await http.get(url);
        var data = jsonDecode(request.body);
        if("${data['success']}"== "1"){
          print(data);
             img = data["img"];
             name = "${data["Name"]}";
             phone=data["Mobile"];
             about=data["About"];
             email = data["Email"];
             setState(() {
               
             });
        } 
    }catch(e){
      print(e);
    }
}
}