import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

void main() => runApp( MaterialApp(home:  MyApp()));

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;


  @override
  void initState() {
    super.initState();
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    var android =  AndroidInitializationSettings('@mipmap/ic_launcher');
    var iOS =  IOSInitializationSettings();
    var initSetttings =  InitializationSettings(android, iOS);
    flutterLocalNotificationsPlugin.initialize(initSetttings,
        onSelectNotification: onSelectNotification,);
  }

  Future onSelectNotification(String payload) async {
    debugPrint("payload : $payload");
    showDialog(
      context: context,
      builder: (_) =>  AlertDialog(
        title:  Text('Notification'),
        content:  Text('$payload'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Local Notification'),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: showNotification,
          child: Text(
            'Demo',
            style: Theme.of(context).textTheme.headline,
          ),
        ),
      ),
    );
  }

  showNotification() async {
    var android =  AndroidNotificationDetails(
        'channel id', 'channel NAME', 'CHANNEL DESCRIPTION',
        priority: Priority.High,importance: Importance.Max
    );
    var iOS =  IOSNotificationDetails();
    var platform =  NotificationDetails(android, iOS);
    await flutterLocalNotificationsPlugin.show(
        0, 'Success', 'Flutter Local Notification', platform,
        payload: 'Flutter Local Notification is Success!!');
  }


}
