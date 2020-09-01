import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:afkar/notifications/notify_manager.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:afkar/alerts/alerts.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationsManager {
  
  PushNotificationsManager._();

  factory PushNotificationsManager() => _instance;

  static final PushNotificationsManager _instance = PushNotificationsManager._();

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  bool _initialized = false;

  void iOS_Permission() {
    _firebaseMessaging.requestNotificationPermissions(
        IosNotificationSettings(sound: true, badge: true, alert: true)
    );
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings)
    {
      print("Settings registered: $settings");
    });
  }

  Future<void> init(BuildContext context) async {
    if (!_initialized) {
      if (Platform.isIOS) iOS_Permission();

      _firebaseMessaging.configure(
        //onBackgroundMessage: Platform.isAndroid ?myBackgroundMessageHandler:null,
        onMessage: (Map<String, dynamic> message) async {
          print("onMessage: $message");
          NotifyManager.show(title: message['notification']['title'], body: message['notification']['body']);
//          showDialog(
//            context: context,
//            builder: (context) => AlertDialog(
//              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0), side: BorderSide(color: Theme.of(context).primaryColor)),
//              content: ListTile(
//                title: Text(message['notification']['title']),
//                subtitle: Text(message['notification']['body']),
//              ),
//              actions: <Widget>[
//                FlatButton(
//                  child: Text('حسناً', style: TextStyle(color: Colors.white),),
//                  color: Theme.of(context).primaryColor,
//                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
//                  onPressed: () => Navigator.of(context).pop(),
//                ),
//              ],
//            ),
//          );
        },
        onLaunch: (Map<String, dynamic> message) async {
          print("onLaunch: $message");
          NotifyManager.show(title: message['notification']['title'], body: message['notification']['body']);
        },
        onResume: (Map<String, dynamic> message) async {
          print("onResume: $message");
          NotifyManager.show(title: message['notification']['title'], body: message['notification']['body']);
        },
      );



      // For testing purposes print the Firebase Messaging token
      String token = await _firebaseMessaging.getToken();
      print("FirebaseMessaging token: $token");
      
      _initialized = true;
    }
  }

  static Future<dynamic> myBackgroundMessageHandler(Map<String, dynamic> message) async {
    if (message.containsKey('data')) {
      final dynamic data = message['data'];
      print("Background!");
    }

    if (message.containsKey('notification')) {
      print("Background2!");
      // Handle notification message
      final dynamic notification = message['notification'];
    }

    // Or do other work.
  }



  // Replace with server token from firebase console settings.
  final String serverToken = 'AAAAJ1bQ5cI:APA91bGnSHrdaiK8FUhCKiI6MTd7xhezQBVEJHXErIAD4Id3cjJSlprxn8z6S9TtTCzRLEgR86ZT2J0qaUDTcRQsqBA6yJDZSUZmhJJ-CXOH9ffmxQJtwJM8ZcLykMIQHqhyOLxq7Bzx';

  Future<void> sendNotification(String firebaseToken, {String body, String title}) async {
    print("NOTIFICATION SENT!");
    await http.post(
      'https://fcm.googleapis.com/fcm/send',
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'key=$serverToken',
      },
      body: jsonEncode(
        <String, dynamic>{
          'notification': <String, dynamic>{
            'body': body,
            'title': title
          },
          'priority': 'high',
          'data': <String, dynamic>{
            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
            'id': '1',
            'status': 'done'
          },
          'to': firebaseToken,
        },
      ),
    );

  }

  Future<void> sendNotificationToInvestors()async{
    print("INVESTORS NOTIFIED");
    await http.post(
      'https://fcm.googleapis.com/fcm/send',
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'key=$serverToken',
      },
      body: jsonEncode(
        <String, dynamic>{
          'notification': <String, dynamic>{
            'body': "هناك أفكار جديدة يمكنك معاينتها!",
            'title': "أفكار"
          },
          'priority': 'high',
          'data': <String, dynamic>{
            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
            'id': '1',
            'status': 'done'
          },
          'to': "/topics/investors",
        },
      ),
    );
  }

  Future<void> thinkerSubscription()async{
    print("thinker subscriped!");
    await _firebaseMessaging.subscribeToTopic("thinkers");
  }

  Future<void> investorSubscription()async{
    print("investor subscriped!");
    await _firebaseMessaging.subscribeToTopic("investors");
  }

  Future<void> unSubscripe(String topic)async{
    await _firebaseMessaging.unsubscribeFromTopic(topic);
  }
}