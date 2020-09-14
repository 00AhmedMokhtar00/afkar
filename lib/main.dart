import 'package:afkar/HomePage.dart';
import 'package:afkar/firebase/push_notifications.dart';
import 'package:afkar/screens/articles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

import 'package:flutter_downloader/flutter_downloader.dart';

import 'notifications/notify_manager.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterDownloader.initialize();
  await NotifyManager.initializeLocalNotification();

  runApp(
      ChangeNotifierProvider<AppState>(
          create: (_) => AppState(), child: MyApp()
      )
  );
}

class AppState with ChangeNotifier {
  AppState();
  //logIn.......................States
  String id;
  String chatId;
  String type;
  String name, email, phone, image, about, address, price, token;

  void setid(String vid) {
    id = vid;
    notifyListeners();
  }

  void setImage(String img) {
    image = img;
    notifyListeners();
  }

  void setchatId(String vchatId) {
    chatId = vchatId;
    notifyListeners();
  }

  void settyper(String vtyper) {
    type = vtyper;
    notifyListeners();
  }

  get getid => id;
  get getchatId => chatId;
  get gettyper => type;

  dynamic hh;
  List<String> cat = [];
  void setData(
      {String nam,
      String em,
      String ph,
      String img,
      String abou,
      String addr,
      String prce,
      String ty,

      List<String> vall,
      dynamic hj}) {
    name = nam;
    email = em;
    phone = ph;
    image = img;
    about = abou;
    address = addr;
    price = prce;
    cat = vall;
    type = ty;
    hh = hj;
    notifyListeners();
  }

  void signOut() {
    PushNotificationsManager pushNotificationsManager = PushNotificationsManager();
    pushNotificationsManager.unSubscripe(type == "think"?"thinkers":"investors");
    print(type);
    type = "";
    name = "";
    email = "";
    phone = "";
    image = "";
    about = "";
    address = "";
    price = "";
    hh = "";
    notifyListeners();
  }

  get getname => name;
  get getemail => email;
  get getphone => phone;
  get getimage => image;
  get getabout => about;
  get getaddress => address;
  get getprice => price;
  get getcat => cat;
  get gethh => hh;
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {


  @override
  Widget build(BuildContext context) {

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: [
          Locale("ar"),
          Locale("en") // OR Locale('ar', 'AE') OR Other RTL locales
        ],
        locale: Locale('ar'),
        title: 'فكر وإستثمار',
        theme: ThemeData(
          platform: TargetPlatform.android,
          fontFamily: 'Cairo',
          primaryColor: Color(0xffffc627),
          accentColor: Color(0xffffc627),
        ),
        home: (FutureBuilder<bool>(
          future: getData(),
          builder: (buildContext, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data) {
                // Return your login here
                return HomePage();
              }
              // Return your home here
              return Articles();
            } else {
              // Return loading screen while reading preferences
              return Center(child: CircularProgressIndicator());
            }
          },
        )));
  }

  Future<bool> getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    AppState appState = Provider.of<AppState>(context, listen: false);
    String id = prefs.getString('id');
    String chatId = prefs.getString('chatid');
    String typer = prefs.getString('type');
    if (id != null) {
      appState.setid(id);
      appState.setchatId(chatId);
      appState.settyper(typer);
    }
    return id == null;
  }
}
