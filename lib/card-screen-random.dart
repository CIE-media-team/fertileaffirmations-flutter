import 'package:fluttertoast/fluttertoast.dart';

import 'nav-drawer.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'card-class.dart';
import 'package:share/share.dart';
import 'package:flip_card/flip_card.dart';

class MyCardRandom extends StatefulWidget {
  MyCardRandom({Key key}) : super(key: key);

  @override
  _MyCard createState() => _MyCard();
}

class _MyCard extends State<MyCardRandom> {
  CardClass c;
  int counter = 0;

  CardClass getCard() {
    if (counter == 0) {
      counter++;
      c = CardClass.getRandomCard();
    }
    return c;
  }

  GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();

  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => flip());
  }

  void flip() {
    Future.delayed(const Duration(milliseconds: 700), () {
      cardKey.currentState.toggleCard();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      Image(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        fit: BoxFit.cover,
        image: AssetImage('assets/images/noleaves2.png'),
      ),
      Scaffold(
        appBar: AppBar(
            // Here we take the value from the MyHomePage object that was created by
            // the App.build method, and use it to set our appbar title.
            title: Text('My Affirmation'),
            automaticallyImplyLeading: true,
            //`true` if you want Flutter to automatically add Back Button when needed,
            //or `false` if you want to force your own back button every where
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context, false),
            )),
        drawer: MyNavigationDrawer(),
        backgroundColor: Colors.transparent,
        body: Center(
            // Center is a layout widget. It takes a single child and positions it
            // in the middle of the parent.
            child: Stack(
                // alignment: AlignmentDirectional.centerStart,
                children: <Widget>[
              Column(children: <Widget>[
                Stack(children: <Widget>[
                  FlipCard(
                      key: cardKey,
                      back: Container(
                          height: (MediaQuery.of(context).size.height / 4) * 3,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                            image: AssetImage('assets/images/cardblank.png'),
                          )),
                          child: Stack(children: <Widget>[
                            Center(
                              child: Container(
                                  width: ((MediaQuery.of(context).size.height /
                                              4) *
                                          3) *
                                      0.60,
                                  child: AutoSizeText(getCard().cardText,
                                      minFontSize: 20,
                                      maxFontSize: 40,
                                      maxLines: 4,
                                      style: TextStyle(
                                          fontFamily: "new",
                                          fontSize: 40,
                                          height: 1.3),
                                      textAlign: TextAlign.center)),

                              // Positioned(
                              //           left: (((MediaQuery.of(context).size.height / 4) * 3) * 0.60) /2 + 5,
                              //           bottom: 30.0,
                              //           child: AutoSizeText(widget.cards[position].cardID,
                              //           minFontSize: 20,
                              //         maxFontSize: 40,
                              //           style: TextStyle(fontFamily: "new"),),
                              //         ),
                            ),
                             Positioned(
                              // left: (((MediaQuery.of(context).size.height / 4) * 3) * 0.60) /2,
                              bottom: 10.0,

                              child: Align(
                                                              alignment: Alignment.center, 
                                child: AutoSizeText(
                                getCard().cardID,
                                minFontSize: 20,
                                maxFontSize: 40,
                                style: TextStyle(fontFamily: "new"),
                              ),
                            ),
                      )])),
                      front: Container(
                          height: (MediaQuery.of(context).size.height / 4) * 3,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.fitHeight,
                                image: AssetImage(
                                    CardClass.getPreferenceImagePath())),
                          )))
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
                            getCard().isFavorite
                                ? Icons.favorite
                                : Icons.favorite_border,
                            size: (MediaQuery.of(context).size.height / 4) / 4,
                          ),
                          color: Colors.red,
                          onPressed: () {
                            // Function call to what happens when the favorite icon is pressed
                            var msg;
                            // Function call to what happens when the favorite icon is pressed
                            var b = favorite();
                            if (b) {
                              msg = "Card added to your favorites";
                            } else {
                              msg = "Card removed from your favorites";
                            }
                            Fluttertoast.showToast(
                                msg: msg,
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.TOP,
                                timeInSecForIos: 1,
                                backgroundColor: Colors.black38,
                                textColor: Colors.white,
                                fontSize: 14.0);
                          },
                        ),
                        SizedBox(width: MediaQuery.of(context).size.width / 10),
                        IconButton(
                          padding: EdgeInsets.all(0),
                          icon: Icon(
                            Icons.share,
                            size: (MediaQuery.of(context).size.height / 4) / 4,
                          ),
                          //color: Colors.red,
                          onPressed: () {
                            // Function call to what happens when the favorite icon is pressed
                            Share.share(
                                "I just received my Fertile Affirmation. You can too at fertileaffirmations.com!");
                          },
                        ),
                      ],
                    ))
              ]),
            ])), // This trailing comma makes auto-formatting nicer for build methods.
      )
    ]);
  }

  //need functionality here to write to the file to change the saved status/show the new icon!
  bool favorite() {
    var b;
    debugPrint("Favorite clicked!");
    if (getCard().isFavorite == false) {
      getCard().setFavorite(true);
      b = true;
    } else {
      getCard().setFavorite(false);
      b = false;
    }
    setState(() {});
    return b;
  }
}
