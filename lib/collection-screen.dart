import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import "package:flutter/material.dart";
import "card-class.dart";
import 'package:auto_size_text/auto_size_text.dart';
import 'card-screen.dart';
import 'custom-affirmation.dart';

class Collection extends StatefulWidget {
  Collection({Key key, @required this.fave}) : super(key: key);
  final bool fave;

  @override
  _Collection createState() => _Collection();
}

class _Collection extends State<Collection> {
  bool fave = false;
  bool creations = false;
  bool firstrun = true;
  bool _front = false;
  String cardImage = 'assets/images/cardBlanknew.png';
  String creationsText = "My Creations";
  IconData ic = Icons.flip_to_back;
  bool visible = true;
  List cards = CardClass.getCards();
  var counter = 0;

  var faveCards = CardClass.getFavorites();

  Size size() {
    return (MediaQuery.of(context).size);
  }

  // getCards() {
  //   if (widget.fave && firstrun) {
  //     this.fave = true;
  //     firstrun = false;
  //     cards = faveCards;
  //     return faveCards;
  //   }

  //   return cards;
  // }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setCardList();
    if (CardClass.creations) {
      creationsText = "Back to Collection";
    } else {
      creationsText = "My Creations";
    }
  }

  void toggleFlip() {
    _front = !_front;
    if (_front) {
      cardImage = 'assets/images/cardBlanknew.png';
      ic = Icons.flip_to_front;
    } else {
      bool pref = CardClass.getPreference();
      if (!pref) {
        cardImage = 'assets/images/warmround.png';
      } else {
        cardImage = 'assets/images/porcelainroundsmall.png';
      }
      ic = Icons.flip_to_back;
    }
    setState(() {});
  }

  String getImage(int position) {
    var cardImage;
    if (!_front) {
      bool pref = CardClass.getPreference();
      if (!pref) {
        cardImage = 'assets/images/warmround.png';
      } else {
        cardImage = 'assets/images/porcelainroundsmall.png';
      }
    } else {
      cardImage = cards[position].getImage();


    }
    return cardImage;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text('My Collection', style: TextStyle(fontSize: 30)),
        automaticallyImplyLeading: true,
        //`true` if you want Flutter to automatically add Back Button when needed,
        //or `false` if you want to force your own back button every where
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              ic,
              color: Colors.white,
            ),
            onPressed: () {
              toggleFlip();
            },
          )
        ],
      ),
      backgroundColor: Theme.of(context).primaryColorLight,
      body: Center(
        child: Column(children: <Widget>[
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  mainAxisSpacing: MediaQuery.of(context).size.height / 100,
                  crossAxisSpacing: MediaQuery.of(context).size.height / 150,
                  childAspectRatio: 50 / 75),
              scrollDirection: Axis.vertical,
              itemBuilder: (context, position) {
                return 
                    Container(
                    // height: 100,
                    // width: 50,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                          //  image: AssetImage('assets/images/noleaves2.png'),
                          // image: AssetImage(cards[position].getImage()),

                          //   fit: BoxFit.fitHeight),),
                            // //  image: AssetImage('assets/images/noleaves2.png'),
                            image: AssetImage('assets/images/noleaves2.png'),
                            fit: BoxFit.fitHeight)),
                    child: Container(
                    // height: 100,
                    // width: 50,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                          //  image: AssetImage('assets/images/noleaves2.png'),
                          // image: AssetImage(cards[position].getImage()),

                          //   fit: BoxFit.fitHeight),),
                            // //  image: AssetImage('assets/images/noleaves2.png'),
                            image: AssetImage(getImage(position)),
                            fit: BoxFit.contain)),
                    child: FlatButton(
                        padding: EdgeInsets.all(0),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MyCard(
                                        position: position,
                                        cards: cards,
                                        firstFlip : true
                                      )));
                        },
                        child: Visibility(
                            visible: !cards[position].getIsDefault(),
                            child: Stack(
                              alignment: Alignment.center,
                              children: <Widget>[
                                Visibility(
                                    visible: _front,
                                    child:
                                Image.asset(
                                  cardImage,
                                  fit: BoxFit.cover,
                                )),
                                Visibility(
                                    visible: _front,
                                    child: Container(
                                        height: (MediaQuery.of(context)
                                                .size
                                                .height) / 8,
                                        width: (MediaQuery.of(context)
                                                .size
                                                .width) / 6,
                                        child: Align(
                                            alignment: Alignment.center,
                                            child:
                                                Text(
                                              cards[position].cardText,
                                              textAlign: TextAlign.center,

                                              style: TextStyle(
                                                  fontFamily: "new",
                                                  
                                                  fontSize: getFontSize(),
                                                  color: Color(0xff41311F),
                                                  height: 1.4),
                                            )))),
                              ],
                            )))));
              },
              itemCount: cards.length,
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height / 16,
            width: MediaQuery.of(context).size.width,
            color: Theme.of(context).primaryColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  alignment: Alignment.centerRight,
                  width: (MediaQuery.of(context).size.width / 2 - 30),
                  child: FlatButton(
                    onPressed: () {
                      myCreationsButton();
                      if (CardClass.creations) {
                        creationsText = "Back to Collection";
                      } else {
                        creationsText = "My Creations";
                      }
                    },
                    child: Text(creationsText,
                        style: TextStyle(color: Colors.white, fontSize: 20)),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  width: (60),
                  child: IconButton(
                    icon: Icon(
                      getIcon(),
                      color: Colors.red,
                      size: 30,
                    ),
                    onPressed: () {
                      favoritesButton(); //this line HAS to be behind setIcon().
                      setState(() {});
                    },
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  width: (size().width / 2 - 30),
                  child: FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CustomAffirmation(),
                          ));
                    },
                    child: Text(
                      "Create Card",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                )
              ],
            ),
          )
        ]),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  myCreationsButton() {
    CardClass.creations = !CardClass.creations;
    setCardList();
    setState(() {});
  }

  setCardList() {
    if (!CardClass.creations && CardClass.fave) {
      cards = CardClass.getFavorites();
    } else if (CardClass.creations && !CardClass.fave) {
      cards = CardClass.getUserCards();
    } else if (CardClass.fave && CardClass.creations) {
      cards = CardClass.getFaveCreations();
    } else {
      cards = CardClass.getCards();
    }
  }

  favoritesButton() {
    // if(widget.fave && fave){
    //   fave = false;
    // }
    CardClass.fave = !CardClass.fave;

    setCardList();
    setState(() {});
  }

  getIcon() {
    if (CardClass.fave) {
      return Icons.favorite;
    } else {
      return Icons.favorite_border;
    }
  }

  double getHeight() {
    double height = (MediaQuery.of(context).size.height / 7);
    if (MediaQuery.of(context).size.height > 700) {
      height = ((MediaQuery.of(context).size.height / 6));
    }
    if (MediaQuery.of(context).size.height > 1000) {
      height = ((MediaQuery.of(context).size.height / 4));
    }
    return height;
  }

  double getFontSize() {
    double fontsize = (MediaQuery.of(context).size.height) / 75;
    if (MediaQuery.of(context).size.height >= 812) {
      fontsize = ((MediaQuery.of(context).size.height) / 90);
    }
    if (MediaQuery.of(context).size.height >= 896) {
      fontsize = ((MediaQuery.of(context).size.height) / 90);
    }
    if (MediaQuery.of(context).size.height >= 1000) {
      fontsize = ((MediaQuery.of(context).size.height) / 60);
    }
    if (MediaQuery.of(context).size.height > 1200) {
      fontsize = ((MediaQuery.of(context).size.height) / 54);
    }
    return fontsize;
  }
}
