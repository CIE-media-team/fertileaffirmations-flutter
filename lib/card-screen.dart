import 'package:fluttertoast/fluttertoast.dart';
import 'package:share/share.dart';

import 'nav-drawer.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'card-class.dart';
import 'package:flip_card/flip_card.dart';
import 'main.dart';

GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();

class MyCard extends StatefulWidget {
  MyCard({
    Key key,
    this.card,
    @required this.cards,
    @required this.position,
  }) : super(key: key);
  final CardClass card;
  final int position;
  final List cards;

  @override
  _MyCard createState() => _MyCard();
}

void main(List<String> args) {
  //cardKey.currentState.toggleCard();
}

class _MyCard extends State<MyCard> {
  // List cards = CardClass.getCards();
  bool _isVisible;
  IconData _icon;

  getFaveIcon(int position) {
    //debugPrint(widget.card.isFavorite.toString());
    // if (widget.card.isFavorite) {
    IconData icon;
    if (widget.cards[position].isFavorite) {
      icon = Icons.favorite;
    } else {
      icon = Icons.favorite_border;
    }
    setState(() {
      _icon = icon;
    });
  }

  getInitialIcon(int p) {
    if (widget.cards[p].isFavorite) {
      return Icons.favorite;
    } else {
      return Icons.favorite_border;
    }
  }

  @override
  void initState() {
    _isVisible = getVisibility();
    _icon = getInitialIcon(widget.position);
    super.initState();
  }

  Future<void> _ackAlert(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Card?'),
          content:
              const Text('Pressing "ok" will delete this card. Are you sure?'),
          actions: <Widget>[
            FlatButton(
              child: Text('Cancel'),
              onPressed: () {
                // Navigator.of(context, rootNavigator: true).pop();
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text('Ok'),
              onPressed: () {
                CardClass.cards.remove(widget.cards[widget.position]);
                save();
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
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
          title: Text('My Card', style: TextStyle(fontSize: 30)),
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
            Visibility(
                visible: _isVisible,
                child: IconButton(
                  icon: Icon(Icons.delete, color: Colors.black),
                  onPressed: () async {
                    await _ackAlert(context);
                  },
                ))
          ],
        ),
        drawer: MyNavigationDrawer(),
        backgroundColor: Colors.transparent,
        body: Center(
            // Center is a layout widget. It takes a single child and positions it
            // in the middle of the parent.
            child: Stack(
                // alignment: AlignmentDirectional.centerStart,
                children: <Widget>[
              PageView.builder(
                onPageChanged: _pageChange,
                controller: PageController(
                    initialPage: widget.position,
                    keepPage: true,
                    viewportFraction: 1),
                itemBuilder: (context, position) {
                  return Column(children: <Widget>[
                    Stack(children: <Widget>[
                      FlipCard(
                        //key: cardKey,

                        direction: FlipDirection.HORIZONTAL,
                        front: Center(
                            child: Container(
                                margin: EdgeInsets.all(
                                    MediaQuery.of(context).size.height / 50),
                          height: (MediaQuery.of(context).size.height / 4) * 3,
                                // width: MediaQuery.of(context).size.width/6 * 5,
                                decoration: BoxDecoration(
                                    // border: Border.all(),
                                    image: DecorationImage(
                                      //image: AssetImage('assets/images/cardBlanknew.png'),
                                      image: AssetImage(
                                          widget.cards[position].getImage()),
                                      fit: BoxFit.contain,
                                    )),
                                // width: (((MediaQuery.of(context).size.height *
                                //     .4875))
                                //     ),
/////////////////////////

                                child: Center(
                                    child: Visibility(
                                        visible: !widget.cards[position]
                                            .getIsDefault(),
                                        child: Stack(children: <Widget>[
                                          Container(
                                              // padding: EdgeInsets.only(top: 1),
                                              alignment: Alignment.center,
                                              child: Image.asset(
                                                'assets/images/cardBlanknew.png',
                                                fit: BoxFit.fitHeight,
                                                // height: (MediaQuery.of(context)
                                                //             .size
                                                //             .height /
                                                //         4) *
                                                //     3,
                                                // width: ((MediaQuery.of(context)
                                                //                 .size
                                                //                 .height /
                                                //             4) *
                                                //         3),
                                              )),
                                          Center(
                                              child: Container(
                                                  width: ((MediaQuery.of(context)
                                                          .size
                                                          .height *.35)),
                                                  height: ((MediaQuery.of(context).size.height * .75) /
                                                      3 *
                                                      1.75),
                                                  // decoration: BoxDecoration(
                                                  //     border: Border.all()),
                                                  child: Align(
                                                      alignment:
                                                          Alignment.center,
                                                      child: SingleChildScrollView(
                                                        controller: ScrollController(),
                                                          child:Text(widget.cards[position].cardText,
                                                          style: TextStyle(
                                                              fontFamily: "new",
                                                              fontSize: (MediaQuery.of(context)
                                                                      .size
                                                                      .height) /
                                                                  25,
                                                              height: 1.6,
                                                              color: Color(0xff41311F)),
                                                          textAlign: TextAlign.center))))),

                                          Padding(
                                              padding:
                                                  EdgeInsets.only(bottom: 20),
                                              child: Align(
                                                alignment:
                                                    Alignment.bottomCenter,
                                                child: Text(
                                                  widget.cards[position].cardID,
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontFamily: "new",
                                                      color: Color(0xff41311F),
                                                      fontSize: (MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .height) /
                                                          22),
                                                ),
                                              ))
                                          // ),
                                        ]))

                                    /////////////////////////////////////////////////
                                    ))),


                        back: Container(
                            margin: EdgeInsets.all(
                                 MediaQuery.of(context).size.height / 50),
height: (MediaQuery.of(context).size.height / 4) * 3,
                            // width: MediaQuery.of(context).size.width/6*5,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.contain,
                                  image: AssetImage(
                                      CardClass.getPreferenceImagePath())),
                            )),
                      )
                    ]),
                    Align(
                      alignment: Alignment.bottomCenter,
                    child: Container(
                        // height: MediaQuery.of(context).size.height / 6,
                        padding: EdgeInsets.only(bottom: 10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            IconButton(
                              padding: EdgeInsets.all(0),
                              icon: Icon(
                                _icon,
                                size: (MediaQuery.of(context).size.height / 4) /
                                    4,
                              ),
                              color: Colors.red,
                              onPressed: () {
                                var msg;
                                // Function call to what happens when the favorite icon is pressed
                                var b = favorite(position);
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
                            SizedBox(
                                width: MediaQuery.of(context).size.width / 10),
                            IconButton(
                              padding: EdgeInsets.all(0),
                              icon: Icon(
                                Icons.share,
                                size: (MediaQuery.of(context).size.height / 4) /
                                    4,
                              ),
                              //color: Colors.red,
                              onPressed: () {
                                // Function call to what happens when the favorite icon is pressed
                                Share.share(
                                    "Fertile Affirmations is a mindfullness based tool created to help motivate and support you during your family building journey. Check it out at:\nhttp://fertileaffirmations.com/");
                              },
                            ),
                          ],
                        ))
                  )]);
                },
                itemCount: widget.cards.length,
              ),
            ])), // This trailing comma makes auto-formatting nicer for build methods.
      )
    ]);
  }

  //need functionality here to write to the file to change the saved status/show the new icon!
  bool favorite(int position) {
    debugPrint("Favorite clicked!");
    var b;
// if (widget.card.isFavorite == false) {
    if (widget.cards[position].isFavorite == false) {
      widget.cards[position].setFavorite(true);
      // widget.card.setFavorite(true);
      b = true;
    } else {
      widget.cards[position].setFavorite(false);
      // widget.card.setFavorite(false);
      b = false;
    }
    getFaveIcon(position);
    return b;
  }

  getVisibility() {
    return !widget.cards[widget.position].getIsDefault();
  }

  getPageVisibility(page) {
    return !widget.cards[page].getIsDefault();
  }

  _pageChange(page) {
    getFaveIcon(page);
    setState(() {
      _isVisible = getPageVisibility(page);
    });
  }

  getHeight() {
    // debugPrint(MediaQuery.of(context).size.height.toString());
    if (MediaQuery.of(context).size.height >= 812) {
      return ((MediaQuery.of(context).size.height / 4) * 3) - 35;
    } else {
      return ((MediaQuery.of(context).size.height / 4) * 3) - 10;
    }
  }

  double getWidth() {
    double height = ((MediaQuery.of(context).size.height / 4) * 3) - 10;
    // debugPrint(MediaQuery.of(context).size.width.toString());
    if (MediaQuery.of(context).size.height >= 812) {
      height = ((MediaQuery.of(context).size.height / 4) * 3) - 35;
    }

    return height;
  }

  // double getFontSize(){
  //   if(MediaQuery.of(context).size.height>1000){
  //     return ((MediaQuery.of(context).size.height)/24);
  //   }
  //   return 28;
  // }
}
