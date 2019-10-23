//Kinsley Sigmund and Dylan Woodworth 
//Peanuts
import 'package:fertile_affirmations/nav-drawer.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fertile Affirmations',
      theme: ThemeData(
          
          primaryColor: Color(0xff4F694C),
          primaryColorDark: Color(0xff3B4429),
          fontFamily: 'primary'),
      home: MyHomePage(title: "Fertile Affirmations"),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  final String text = 'I love myself ';
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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

        return Scaffold(
          appBar: AppBar(
            // Here we take the value from the MyHomePage object that was created by
            // the App.build method, and use it to set our appbar title.
            title: Text('Fertile Affirmations'),
          ),
          drawer: MyNavigationDrawer(),
          body: Center(
            // Center is a layout widget. It takes a single child and positions it
            // in the middle of the parent.
            child: Stack(
              
              alignment: AlignmentDirectional.center,
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: FittedBox(
                    fit: BoxFit.cover,
                    child: Image.asset('assets/images/noleaves2.png'),
                  ),
                ),
                Image.asset('assets/images/cardblank.png'),
                Padding(padding: EdgeInsets.all(20),
      
                
                      child: AutoSizeText(
                          
                            
                      widget.text,
                  minFontSize: 20,
                  maxFontSize: 50,
                  
                  style: TextStyle(fontFamily: "fancy", fontSize: 60),
                  textAlign: TextAlign.center,
                ))
          ]
              
            
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
