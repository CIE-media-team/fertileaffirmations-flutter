import 'dart:async' show Future;
import 'package:fertile_affirmations/card-screen-random.dart';
import 'package:fertile_affirmations/nav-drawer.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:auto_size_text/auto_size_text.dart';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  List<String> hours = new List<String>();
  List<String> minutes  = new List<String>();
  List<String> tod = ['AM', 'PM'];
  String _selectedHour, _selectedMinute, _selectedTOD;
  SharedPreferences prefs;


  getValues() async{
    
    prefs = await SharedPreferences.getInstance();
    var prefSelectedHour = (prefs.getString('sharedPrefHours') ?? null); 
    var prefSelectedMinute = (prefs.getString('sharedPrefMinutes') ?? null); 
    var prefSelectedTOD = (prefs.getString('sharedPrefTod') ?? null); 

    if(prefSelectedHour != null && prefSelectedMinute != null && prefSelectedTOD!=null){
      setState(() {
        
      _selectedHour = prefSelectedHour; 
      _selectedMinute = prefSelectedMinute;
      _selectedTOD = prefSelectedTOD;
            });

    }

      
    

  }

  @override
  initState() {

    

    _populateLists(); 
    getValues();

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
          backgroundColor: Theme.of(context).primaryColor,
          title: Text("Remind Me", style: TextStyle(fontSize: 30)),
          elevation: 0.0,
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context, false),
            )
        ),
        body: 
        Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: AutoSizeText("Please ensure notifications are enabled and select a time you would like to be reminded to receive your daily Fertile Affirmation!", 
                maxFontSize: 40,
                minFontSize: 20,
                style: TextStyle(), textAlign: TextAlign.center,), 
              ),
              SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              DropdownButton(
                hint: Text("Hour", style: TextStyle(fontSize: 20)),
                items: hours.map((String value) {
                  return new DropdownMenuItem<String>(
                    value: value,
                    child: new Text(value, style: TextStyle(fontSize: 20)),
                  );
                }).toList(),
                value: _selectedHour,

                onChanged: (newValue) {
                  setState(() {
                    _selectedHour = newValue;
                  });
                },
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Text(":", style: TextStyle(fontSize: 20)),
              ),
              DropdownButton(
                hint: Text("Minute", style: TextStyle(fontSize: 20)),
                value: _selectedMinute,
                items: minutes.map((String value) {
                  return new DropdownMenuItem<String>(
                    value: value,
                    child: new Text(value, style: TextStyle(fontSize: 20)),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    _selectedMinute = newValue;
                  });
                },
              ),
              DropdownButton(
                hint: Text("AM/PM", style: TextStyle(fontSize: 20)),
                value: _selectedTOD,
                items: tod.map((String value) {
                  return new DropdownMenuItem<String>(
                    value: value,
                    child: new Text(value, style: TextStyle(fontSize: 20),),
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
            color: Theme.of(context).primaryColor,
            onPressed: () {
              _showDialog();
              _dailyNotification(int.parse(_selectedHour),
                  int.parse(_selectedMinute), _selectedTOD);
            },
            child: new Text('Set Daily Notification Time', style: TextStyle(color: Colors.white, fontSize: 18),)
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
  }



  String _toTwoDigitString(int value) {
    return value.toString().padLeft(2, '0');
  }

  _dailyNotification(int hour, int minute, String tod) async {
    prefs.setString('sharedPrefHours', hour.toString()); 
    prefs.setString('sharedPrefMinutes', _toTwoDigitString(minute)); 
    prefs.setString('sharedPrefTod', tod); 

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
        'My Fertile Affirmations',
        'Time To Pause And Pull A Card!',
        time,
        platformChannelSpecifics);
  }

  _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Daily Notification", style: TextStyle(fontSize: 24),),
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

  _populateLists(){
    for(int i=1; i<=12; i++){
      hours.add(i.toString());
    } 
    
    for(int i=0; i<=60; i++){
      if(i<10){
      minutes.add("0"+i.toString());
      }
      else{minutes.add(i.toString());}
      } 
    }
  }

