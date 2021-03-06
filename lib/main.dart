//Kinsley Sigmund and Dylan Woodworth
import 'dart:async' show Future;
// import 'dart:ffi';

// import 'dart:math';
import 'package:fertile_affirmations/card-class.dart';
import 'package:fertile_affirmations/nav-drawer.dart';
import 'package:flutter/material.dart';
// import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:async';
import 'package:flutter/services.dart';
// import 'package:flutter/material.dart';
// import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'card-screen-random.dart';

import 'select-goddess.dart';

// import 'package:url_launcher/url_launcher.dart';
// ximport 'package:flutter_local_notifications/flutter_local_notifications.dart';

//This app will have 3 text files. 2 internal, and one in the resources folder.
//permanentcardsfile.txt -> This is stored in the resources folder. This contains the default cards. This file can be edited BUT it MUST retain its format. If you add a card, it will be seen upon
//  next launch.
//usercards.txt -> this is initially a blank file. This stores the user's created cards.
//permanentpreferencesfile.txt -> this will store the permanent card's changeable values that the user has chosen. IE the user favorites card #13, so we have to store that here.

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await firstLaunch();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  //PackageInfo packageInfo = await PackageInfo.fromPlatform();
  // String versionName = packageInfo.version;
  // String versionCode = packageInfo.buildNumber;
  // CardClass.versionNumber = versionCode;

  runApp(MyApp());

  //resetApp();
}

//This method determines if the app has been opened before. If it hasn't, it creates a permanent backup file stored in the memory of the phone. This contains all
//default cards. It also creates a user file. The user file is loaded with all of the default cards. firstLaunch() is called everytime the app is opened, but its code
//only executes once.

Future firstLaunch() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var first = (prefs.getBool('firstLaunch') ??
      true); //If there is no value for 'firstLaunch' stored, that means (obviously) it is the first launch, so it is set to true.
  if (!first) {
    CardClass.setFirstLaunch();
  }
  prefs.setBool('firstLaunch', false); //set it to false after
  bool pref = (prefs.getBool('pref') ?? true);
  CardClass.setPreference(pref);
  var permcards = await rootBundle.loadString(
      'assets/textfiles/permanentcardsfile.txt'); //this reads in the permcardsfile as a giant string
  //first=true;
  if (first) {
    //if it is the first run of the app, instantiate the user file and create the permanent preferences file with all default cards.
    writeFile("permanentpreferences", permcards.toString());
    writeFile("user", "");
  } else {}
  var permprefcontents = await readContent("permanentpreferences");
  var usercontents = await readContent("user");
  var combinedcontents = permprefcontents + usercontents;

  readCards(combinedcontents);

  readInstructions();
}

Future readInstructions() async {
  var instructions =
      await rootBundle.loadString('assets/textfiles/instructions.txt');
  List<String> strings = instructions.split("\n");
  var i = 0;
  while (i < strings.length) {
    strings[i] = strings[i].replaceAll("*", "\n");
    i++;
  }
  CardClass.instructions = strings;
}

Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();
  return directory.path;
}

Future<File> get _userFile async {
  final path = await _localPath;
  return File('$path/usercards.txt');
}

Future<File> get _permPreferencesFile async {
  final path = await _localPath;
  return File('$path/permPreferences.txt');
}

//Will return the contents of either the user or permanentpreferences file.
Future<String> readContent(String type) async {
  try {
    var file;
    if (type.toLowerCase() == "user") {
      file = await _userFile;
    }
    // else if(type.toLowerCase() == "permanent"){
    //   file = await _permFile;
    // }

    else if (type.toLowerCase() == "permanentpreferences") {
      file = await _permPreferencesFile;
    }
    var contents = await file.readAsString();
    return contents;
  } catch (e) {
    return 'Error trying to read the file.';
  }
}

Future<File> writeFile(String type, var text) async {
  var file;

  if (type.toLowerCase() == "user") {
    file = await _userFile;
  } else if (type.toLowerCase() == "permanentpreferences") {
    file = await _permPreferencesFile;
  }
  // Write the file
  return file.writeAsString(text.toString());
}

void resetApp() async {
  //read in the permcards file
  var permcards =
      await rootBundle.loadString('assets/textfiles/permanentcardsfile.txt');

  //overwrite the user file, clearing the contents
  writeFile("user", "");
  //write all default values to the permanentpreferences file
  writeFile("permanentpreferences", permcards);
  //clear the 'cards' list inside the CardClass class.
  CardClass.resetCards();
  CardClass.firstLaunch = true;
  //Initialize all cards again.
  readCards(permcards.toString());
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.clear();
}

void save() async {
  //getPermPrefAndUserCards returns a list with 2 values. String values of permanent cards and string values of user cards.
  List l = CardClass.getPermPrefAndUserCards();

  //Overwrite the permanentpreferences file with the updated cards
  writeFile("permanentpreferences", l[0].toString());
  //Overwrite the user file with the updated cards
  writeFile("user", l[1].toString());
}

void readCards(String stringCards) async {
  String s = stringCards;
  s = s.trim();
  s = s.replaceAll("\n", "");
  s = s.replaceAll("\r", "");

  List<String> strings = s.split("&");

  List<CardClass> cards = new List((strings.length / 4).ceil());
  var i = 0;
  var index = 0;
  while (i <= strings.length - 4) {
    //Verify file is being read correctly.
    cards[index] = new CardClass(
        strings[i], strings[i + 1], strings[i + 2], strings[i + 3]);

    i += 4;
    index += 1;
  }
}

enum Preference { warm, porclain }

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  Widget _home;
  @override
  void initState() {
    // TODO: implement initState
    getHome();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Fertile Affirmations',
        theme: ThemeData(
          primaryColor: Color(0xff4F694C),
          primaryColorDark: Color(0xff3B4429),
          primaryColorLight: Color(0xffD5E7CD),
          fontFamily: 'primary',
        ),
        home: _home);
  }

  getHome() {
    bool first = CardClass.getFirstLaunch();

    if (first) {
      _home = SelectGoddess();
    } else {
      _home = MyHomePage(
        title: "Fertile Affirmations",
        preference: CardClass.getPreference(),
      );
    }
  }
}

class MyHomePage extends StatefulWidget {

  MyHomePage({Key key, this.title, @required this.preference})
      : super(key: key);
  final String title;
  final bool preference;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          return null;
        },
        child: Stack(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: FittedBox(
                fit: BoxFit.cover,
                child: Image.asset('assets/images/noleaves2.png'),
              ),
            ),
            Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  'assets/images/fertilelogo.png',
                  width: MediaQuery.of(context).size.width / 12 * 11,
                ),
                SizedBox(height: 5),
                Image.asset(CardClass.getFirstPreferenceImagePath()),
              ],
            )),
            Scaffold(
              key: _scaffoldKey,
                drawer: MyNavigationDrawer(),
                backgroundColor: Colors.transparent,
                appBar: new AppBar(
                  leading: IconButton(
                    icon: Icon(Icons.view_list),
                    onPressed: () => _scaffoldKey.currentState.openDrawer()                    
                  ),
                  iconTheme:
                      IconThemeData(color: Theme.of(context).primaryColorDark),
                  backgroundColor: Colors.transparent,
                  elevation: 0.0,
                ),
                body: new Container(
                    color: Colors.transparent,
                    child: GestureDetector(onTap: () {    // added functionality to get random affirmation if user just taps front screen
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MyCardRandom(),
                          ));
                    })))
          ],
        ));
  }
}
