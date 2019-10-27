import 'nav-drawer.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'card-class.dart';

class MyCard extends StatefulWidget {
  MyCard({Key key, @required this.card}) : super(key: key);
  final CardClass card;

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
        title: Text('My Affirmation'),
      ),
      drawer: MyNavigationDrawer(),
      body: Center(
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          child: Stack(
              // alignment: AlignmentDirectional.centerStart,
              children: <Widget>[
            Image(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
              image: AssetImage('assets/images/noleaves2.png'),
            ),
            Column(children: <Widget>[
              Stack(children: <Widget>[
                Container(
                    height: (MediaQuery.of(context).size.height / 4) * 3,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                      image: AssetImage('assets/images/cardblank.png'),
                    )),
                    child: Center(
                        child: Padding(
                            padding: EdgeInsets.all(40),
                            child: AutoSizeText(
                              widget.card.cardText,
                              minFontSize: 20,
                              maxFontSize: 40,
                              maxLines: 4,
                              style: TextStyle(
                                  fontFamily: "fancy",
                                  fontSize: 40,
                                  height: 1.3),
                              textAlign: TextAlign.center,
                            )))),
              ]),
              Container(
                  height: (MediaQuery.of(context).size.height / 8),
                  padding: EdgeInsets.all(0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      IconButton(
                        padding: EdgeInsets.all(0),
                        icon: Icon(
                          widget.card.isFavorite
                              ? Icons.favorite
                              : Icons.favorite_border,
                          size: (MediaQuery.of(context).size.height / 4) / 4,
                        ),
                        color: Colors.red,
                        onPressed: () {
                          
                          // Function call to what happens when the favorite icon is pressed
                          favorite();
                        },
                      ),
                      SizedBox(width: MediaQuery.of(context).size.width / 10),
                      Icon(
                        Icons.share,
                        size: (MediaQuery.of(context).size.height / 4) / 4,
                      ),
                    ],
                  ))
            ]),
          ])), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  //need functionality here to write to the file to change the saved status/show the new icon!
  void favorite() {
    debugPrint("Favorite clicked!");
    if (widget.card.isFavorite = false) {
      widget.card.isFavorite = true;
    } else {
      widget.card.isFavorite = false;
    }
    setState(() {});
  }
}
