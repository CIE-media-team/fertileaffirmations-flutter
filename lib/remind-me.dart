import 'dart:async' show Future;
import 'package:fertile_affirmations/card-screen-random.dart';
import 'package:fertile_affirmations/nav-drawer.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class RemindMe extends StatefulWidget {
// class MyHomePage extends StatelessWidget {

  RemindMe({
    Key key,
    this.title,
  }) : super(key: key);
  final String title;

  @override
  _RemindMeState createState() => _RemindMeState();
}

class _RemindMeState extends State<RemindMe> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  List<String> hours = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10',
    '11',
    '12'
  ];
  List<String> minutes = [
    '00',
    '05',
    '10',
    '15',
    '20',
    '25',
    '30',
    '35',
    '40',
    '45',
    '54',
    '55'
  ];
  List<String> tod = ['AM', 'PM'];
  String _selectedHour, _selectedMinute, _selectedTOD;

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
    return Stack(children: <Widget>[
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
        body: Center(
            child: Column(children: <Widget>[
          RaisedButton(
            onPressed: _showNotification,
            child: new Text('Show Notification'),
          ),
          RaisedButton(
            onPressed: _scheduledNotification,
            child: new Text('Show Scheduled Notification'),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              DropdownButton(
                hint: Text("Hour"),
                value: _selectedHour,
                items: hours.map((String value) {
                  return new DropdownMenuItem<String>(
                    value: value,
                    child: new Text(value),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    _selectedHour = newValue;
                  });
                },
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Text(":"),
              ),
              DropdownButton(
                hint: Text("Minute"),
                value: _selectedMinute,
                items: minutes.map((String value) {
                  return new DropdownMenuItem<String>(
                    value: value,
                    child: new Text(value),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    _selectedMinute = newValue;
                  });
                },
              ),
              DropdownButton(
                hint: Text("AM/PM"),
                value: _selectedTOD,
                items: tod.map((String value) {
                  return new DropdownMenuItem<String>(
                    value: value,
                    child: new Text(value),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    _selectedTOD = newValue;
                  });
                },
              ),
            ],
          ),
          RaisedButton(
            onPressed: () {
              _showDialog();
              _dailyNotification(int.parse(_selectedHour),
                  int.parse(_selectedMinute), _selectedTOD);
            },
            child: new Text('Show Daily Notification'),
          ),
        ])),
      )
    ]);
  }

  Future onSelectNotification(String payload) async {
    Navigator.of(context).pop();

    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MyCardRandom(),
        ));

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
        0,
        'Hey there!',
        'Open the Fertile Affirmations app to recieve your daily affirmation!',
        platform);
  }
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

  String _toTwoDigitString(int value) {
    return value.toString().padLeft(2, '0');
  }

  _scheduledNotification() async {
    var scheduledNotificationDateTime =
        new DateTime.now().add(new Duration(seconds: 5));
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
        'your other channel id',
        'your other channel name',
        'your other channel description');
    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
    NotificationDetails platformChannelSpecifics = new NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.schedule(
        0,
        'scheduled title',
        'scheduled body',
        scheduledNotificationDateTime,
        platformChannelSpecifics);
  }

  _dailyNotification(int hour, int minute, String tod) async {
    if (tod == "PM") {
      hour = hour + 12;
    }
    var time = new Time(hour, minute, 0);
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
        'repeatDailyAtTime channel id',
        'repeatDailyAtTime channel name',
        'repeatDailyAtTime description');
    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
    var platformChannelSpecifics = new NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.showDailyAtTime(
        0,
        'show daily title',
        'Daily notification shown at approximately ${_toTwoDigitString(time.hour)}:${_toTwoDigitString(time.minute)}:${_toTwoDigitString(time.second)}',
        time,
        platformChannelSpecifics);
  }

  _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Daily Notification"),
          content: new Text(
              "You have chosen to recieve your daily affirmation reminder at $_selectedHour : $_selectedMinute $_selectedTOD"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
