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

class _Collection extends State<Collection>  {
  bool fave = false;
  bool creations = false;
  bool firstrun = true;
  bool _front = true;
  String cardImage = 'assets/images/cardblank.png';
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
      ic = Icons.flip_to_back;
    } else {
      bool pref = CardClass.getPreference();
      if (!pref) {
        cardImage = 'assets/images/warmround.png';
      } else {
        cardImage = 'assets/images/porcelainroundsmall.png';
      }
      ic = Icons.flip_to_front;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text('My Collection'),
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
                  mainAxisSpacing: MediaQuery.of(context).size.height/100,
                  crossAxisSpacing: MediaQuery.of(context).size.height/150,
                  childAspectRatio: 50 / 75),
              scrollDirection: Axis.vertical,
              itemBuilder: (context, position) {
                return Container(
                    // height: 100,
                    // width: 50,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/images/noleaves2.png'),
                            fit: BoxFit.fill),
                        // border: Border.all(color: Colors.black, width: 1),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: FlatButton(
                        padding: EdgeInsets.all(0),
                        onPressed: () {
                          // debugPrint(cards[position].cardText);
                          //Navigator.of(context).pop();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MyCard(
                                        position: position,
                                        cards: cards,
                                      )));
                        },
                        child: Stack(
                          alignment: Alignment.center,
                          children: <Widget>[
                            // Image.asset('assets/images/noleaves2.png'),
                            Image.asset(
                              cardImage,
                              fit: BoxFit.cover,
                            ),
                            Visibility(
                                visible: _front,
                                child: Container(
                                  decoration: BoxDecoration(border: Border.all(color: Colors.black)),
                                  height: getHeight(),
                                  width: ((MediaQuery.of(context).size.width/5.5)),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: AutoSizeText(
                                  cards[position].cardText,
                                  // maxFontSize: 30,
                                  minFontSize: 5,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColorDark,
                                      fontFamily: "new",
                                      fontSize: getFontSize(),
                                      height: 1.2),
                                )))), 
                                Visibility(
                                  visible: _front,
                                child: Positioned(
                                                bottom: 8,
                                                child: Align(
                                                  alignment: Alignment.bottomCenter,
                                                  child: AutoSizeText(cards[position].cardID, 
                                                style: TextStyle(fontFamily: "new",
                                                fontSize: (MediaQuery.of(context).size.height)/75),),
                                              ),
                                ))],
                        )));
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
                  // decoration: BoxDecoration(
                  //     border: Border.all(color: Colors.black, width: 1)),
                  alignment: Alignment.centerRight,
                  width: (MediaQuery.of(context).size.width / 2 - 30),
                  child: FlatButton(
                    // padding: EdgeInsets.only(
                    //     left: 50, top: 20, bottom: 20, right: 20),
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
                  // decoration: BoxDecoration(
                  //     border: Border.all(color: Colors.black, width: 1)),
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
                  // decoration: BoxDecoration(
                  //     border: Border.all(color: Colors.black, width: 1)),
                  alignment: Alignment.centerLeft,
                  width: (size().width / 2 - 30),
                  child: FlatButton(
                    // padding: EdgeInsets.only(
                    //     left: 20, top: 20, bottom: 20, right: 50),
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

  double getHeight(){
    if(MediaQuery.of(context).size.height>1000){
      return ((MediaQuery.of(context).size.height /5));
    }
    return ((MediaQuery.of(context).size.height /7));
  }

  double getFontSize(){
    if(MediaQuery.of(context).size.height>1000){
      return ((MediaQuery.of(context).size.height)/54);
    }
    return (MediaQuery.of(context).size.height)/75;
  }

  
}
