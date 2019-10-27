//Kinsley Sigmund and Dylan Woodworth 
import 'dart:async' show Future;

import 'dart:math';
import 'package:fertile_affirmations/card-class.dart';
import 'package:fertile_affirmations/nav-drawer.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';


//This app will have 4 text files.
//permanentcardsfile.txt -> This is stored in the resources folder. This contains the default cards. This file can be edited BUT it MUST retain its format. If you add a card, it will be seen upon
//  next launch.
//usercards.txt -> this is initially a blank file. This stores the user's created cards.
//permanentpreferencesfile.txt -> this will store the permanent card's changeable values that the user has chosen.
//allCards.txt -> This is refered to in the code as the "combined" file. It will consist of the permanentpreferencesfile + all user cards.



void main(){

  firstLaunch();
  
  

  
  runApp(MyApp());

  //resetApp();


}


//This method determines if the app has been opened before. If it hasn't, it creates a permanent backup file stored in the memory of the phone. This contains all 
//default cards. It also creates a user file. The user file is loaded with all of the default cards. firstLaunch() is called everytime the app is opened, but its code
//only executes once.
void firstLaunch() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var first = (prefs.getBool('firstLaunch') ?? true);
    prefs.setBool('firstLaunch', false);
    var permcards = await rootBundle.loadString('assets/textfiles/permanentcardsfile.txt');
    //first=true;
    if(first){
      //debugPrint(permcards.toString()); //uncomment this to verify that the permanentcards are copying over correctly.
      writeFile("permanent",permcards.toString());
      writeFile("permanentpreferences",permcards.toString());

      writeFile("user","");
    }
    else{

      
      
    }
    var permprefcontents = await readContent("permanentpreferences");
    var usercontents = await readContent("user");
    var combinedcontents = permprefcontents + usercontents;
    
    //debugPrint(combinedcontents.toString());
    readCards(combinedcontents);
    // writeFile("combined", combinedcontents);
    // readContent("combined");
    

}

Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();
  return directory.path;
}

Future<File> get _userFile async {
  final path = await _localPath;
  return File('$path/usercards.txt');
}
Future<File> get _permFile async {
  final path = await _localPath;
  return File('$path/permcards.txt');
}
Future<File> get _combinedFile async {
  final path = await _localPath;
  return File('$path/allCards.txt');
}
Future<File> get _permPreferencesFile async {
  final path = await _localPath;
  return File('$path/permPreferences.txt');
}

//If you want to read the userfile, set b as true. if you want to read the permanent file, set it as false. Returns all contents
Future<String> readContent(String type) async {
  try {
    var file;
    if(type.toLowerCase() == "user"){
      file = await _userFile;
    }
    else if(type.toLowerCase() == "permanent"){
      file = await _permFile;
    }
    else if(type.toLowerCase() == "combined"){
      file = await _combinedFile;
    }
    else if(type.toLowerCase() == "permanentpreferences"){
      file = await _permPreferencesFile;
    }
    // Read the file
    var contents = await file.readAsString();
    debugPrint(type + "@@@" + contents.toString() + " ^^^ end" + type);
    return contents;
      
      
    // Returning the contents of the file
  } catch (e) {
    // If encountering an error, return
    return 'Error trying to read the file.';
  }
}
 

Future<File> writeFile(String type,var text) async {
  var file;
  if(type.toLowerCase() == "user"){
    file = await _userFile;
  }
  else if(type.toLowerCase() == "permanent"){
    file = await _permFile;
  }
  else if (type.toLowerCase() == "permanentpreferences"){
    file = await _permPreferencesFile;
  }
  // Write the file
  return file.writeAsString(text.toString());
}



void resetApp() async{

  var permcards = await rootBundle.loadString('assets/textfiles/permanentcardsfile.txt');

  writeFile("user","");
  writeFile("permanentpreferences",permcards);
  CardClass.resetCards();
  readCards(permcards.toString());





}

void save() async{
  List l = CardClass.getPermPrefAndUserCards();

  writeFile("permanentpreferences",l[0].toString());
  writeFile("user",l[1].toString());
  debugPrint("Saved the file!");

  var permprefcontents = await readContent("permanentpreferences");
  var usercontents = await readContent("user");
  debugPrint("Perm pref contents: " + permprefcontents);
  debugPrint("User contents: "+ usercontents);

}






void readCards(String stringCards) async {
  String s = stringCards;
  s = s.trim();
  s = s.replaceAll("\n", "");
  s = s.replaceAll("\r", "");

  List<String> strings = s.split("&");
  
  List<CardClass> cards = new List((strings.length/4).ceil());
  var i = 0;
  var index = 0;
  while(i <= strings.length-4){
    //Verify file is being read correctly.    
    cards[index] = new CardClass(strings[i], strings[i+1], strings[i+2], strings[i+3]);
    //debugPrint(cards[index].toString());
    i+=4;
    index+=1;




  }



}


  

enum Preference{ 
  warm, 
  porclain 
}

class MyApp extends StatelessWidget {

    

  MyApp(){
  }




  
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fertile Affirmations',
      theme: ThemeData(
          
          primaryColor: Color(0xff4F694C),
          primaryColorDark: Color(0xff3B4429),
          fontFamily: 'primary'),
      home: MyHomePage(title: "Fertile Affirmations", preference: true,),
    );
  }
}

// class MyHomePage extends StatefulWidget {
class MyHomePage extends StatelessWidget { 

  MyHomePage({Key key, this.title, @required this.preference}) : super(key: key);
  final String title;
  final bool preference;  
  

//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
  // bool preference; 
  // int _counter = 0;

  // void _incrementCounter() {
  //   setState(() {
  //     // This call to setState tells the Flutter framework that something has
  //     // changed in this State, which causes it to rerun the build method below
  //     // so that the display can reflect the updated values. If we changed
  //     // _counter without calling setState(), then the build method would not be
  //     // called again, and so nothing would appear to happen.
  //     _counter++;
  //   });
  // }

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
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset('assets/images/fertilelogo.png'),
                    SizedBox(height: 5),
                    Image.asset(getPreference()),
                  ],

                ),
                
               
        
      
        Scaffold(
          drawer: MyNavigationDrawer(),
          backgroundColor: Colors.transparent,
          appBar: new AppBar(
            iconTheme: IconThemeData(color: Theme.of(context).primaryColorDark),
            backgroundColor: Colors.transparent,
            elevation: 0.0,
          ),
          body: new Container(
            color: Colors.transparent,
          ),
        ),
      ],
    );
  }

        // return Scaffold(
        //   appBar: AppBar(
        //     // Here we take the value from the MyHomePage object that was created by
        //     // the App.build method, and use it to set our appbar title.
        //     backgroundColor: Colors.transparent ,
        //     toolbarOpacity: 0,
        //   ),
        //   drawer: MyNavigationDrawer(),
        //   body: Center(
        //     // Center is a layout widget. It takes a single child and positions it
        //     // in the middle of the parent.
        //     child: Stack(
              
        //       alignment: AlignmentDirectional.center,
        //       children: <Widget>[
        //         Container(
        //           width: MediaQuery.of(context).size.width,
        //           height: MediaQuery.of(context).size.height,
        //           child: FittedBox(
        //             fit: BoxFit.cover,
        //             child: Image.asset('assets/images/noleaves2.png'),
        //           ),
        //         ),
        //         Column(
        //           mainAxisAlignment: MainAxisAlignment.center,
        //           children: <Widget>[
        //             Image.asset('assets/images/fertilelogo.png'),
        //             SizedBox(height: 5),
        //             Image.asset(getPreference()),
        //           ],

        //         )
                
               
        //   ]
              
            
        // ),
  //     ), // This trailing comma makes auto-formatting nicer for build methods.
  //   );
  // }
  String getPreference (){ 
    if (preference == true){ 
      return 'assets/images/porcelainfirst.png';
    }
    else{
      return 'assets/images/warmfirst.png';
    }
  }
}
