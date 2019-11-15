import 'dart:async' show Future;

import 'package:fertile_affirmations/card-class.dart';
import 'package:fertile_affirmations/card-screen-random.dart';
import 'package:fertile_affirmations/nav-drawer.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';


class RemindMe extends StatefulWidget {
// class MyHomePage extends StatelessWidget {

  RemindMe({Key key, this.title, })
      : super(key: key);
  final String title;

  @override
  _RemindMeState createState() => _RemindMeState();
}

class _RemindMeState extends State<RemindMe> {

    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;


    @override
  initState() {
    super.initState();
    // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
    // If you have skipped STEP 3 then change app_icon to @mipmap/ic_launcher
    var initializationSettingsAndroid =
        new AndroidInitializationSettings('app_icon');
    var initializationSettingsIOS = new IOSInitializationSettings();
    var initializationSettings = new InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);
    // initializationSettings, selectNotification: onSelectNotification);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: FittedBox(
            fit: BoxFit.cover,
            child: Image.asset('assets/images/noleaves2.png'),
          ),
        ),

        
        Scaffold(
          drawer: MyNavigationDrawer(),
          backgroundColor: Colors.transparent,
          appBar: new AppBar(
            iconTheme: IconThemeData(color: Theme.of(context).primaryColorDark),
            backgroundColor: Colors.transparent,
            elevation: 0.0,
          ),
          body: Center( child:
        RaisedButton(
              onPressed: _showNotification,
              child: new Text('Show Notification'),
            )
          ),
    )]);
  }

  Future onSelectNotification(String payload) async {
    Navigator.of(context).pop();
                  
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MyCardRandom(),)
                  );
              
    // showDialog(
    //   context: context,
    //   builder: (_) {
    //     return new AlertDialog(
    //       title: Text("Its time!"),
    //       content: Text("Select 'Affirmation' from the menu to get your daily affirmation!"),
    //     );
    //   },
    // );
  }

  _showNotification() async {
    var android = new AndroidNotificationDetails(
        'channel id', 'channel NAME', 'CHANNEL DESCRIPTION');
    var iOS = new IOSNotificationDetails();
    var platform = new NotificationDetails(android, iOS);
    await flutterLocalNotificationsPlugin.show(
        0, 'Hey there!', 'Open the Fertile Affirmations app to recieve your daily affirmation!', platform);
    // var scheduledNotificationDateTime =
    //     DateTime.now().add(Duration(seconds: 5));

    // var androidPlatformChannelSpecifics = AndroidNotificationDetails(
    //     'your other channel id',
    //     'your other channel name',
    //     'your other channel description',
    //     icon: 'secondary_icon',
    //     sound: 'slow_spring_board',
    //     largeIcon: 'sample_large_icon',
    //     largeIconBitmapSource: BitmapSource.Drawable,
    //     enableLights: true,
    //     color: const Color.fromARGB(255, 255, 0, 0),
    //     ledColor: const Color.fromARGB(255, 255, 0, 0),
    //     ledOnMs: 1000,
    //     ledOffMs: 500);
    // var iOSPlatformChannelSpecifics =
    //     IOSNotificationDetails(sound: "slow_spring_board.aiff");
    // var platformChannelSpecifics = NotificationDetails(
    //     androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    // await flutterLocalNotificationsPlugin.schedule(
    //     0,
    //     'scheduled title',
    //     'scheduled body',
    //     scheduledNotificationDateTime,
    //     platformChannelSpecifics);
  }
}

