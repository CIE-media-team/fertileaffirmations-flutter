
import 'package:fertile_affirmations/nav-drawer.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

void main() => runApp(MyApp());

enum Preference{ 
  warm, 
  porclain 
}

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
