import 'nav-drawer.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class MyCard extends StatefulWidget {
  MyCard({Key key}) : super(key: key);

  @override
  _MyCard createState() => _MyCard();
}

class _MyCard extends State<MyCard> {
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
        child: Stack(alignment: AlignmentDirectional.center, children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: FittedBox(
              fit: BoxFit.cover,
              child: Image.asset('assets/images/noleaves2.png'),
            ),
          ),
          Image.asset('assets/images/cardblank.png'),
          Padding(
              padding: EdgeInsets.all(20),
              child: AutoSizeText(
                "hi",
                minFontSize: 20,
                maxFontSize: 50,
                style: TextStyle(fontFamily: "fancy", fontSize: 60),
                textAlign: TextAlign.center,
              ))
        ]),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
