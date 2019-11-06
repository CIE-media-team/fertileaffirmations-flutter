


import 'nav-drawer.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'card-class.dart';

class MyCard extends StatefulWidget {
  MyCard({Key key, this.card, @required this.cards, @required this.position}) : super(key: key);
  final CardClass card;
  final int position;
  final List cards; 


  @override
  _MyCard createState() => _MyCard();
}

class _MyCard extends State<MyCard> {
  // List cards = CardClass.getCards();

  getFaveIcon(int position) {
    //debugPrint(widget.card.isFavorite.toString());
    // if (widget.card.isFavorite) {
          if (widget.cards[position].isFavorite) {

      return Icons.favorite;
    } else {
      return Icons.favorite_border;
    }
  }



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
            PageView.builder(
              // child: Stack(children: <Widget>[
              //   Container(
              //       height: (MediaQuery.of(context).size.height / 4) * 3,
              //       decoration: BoxDecoration(
              //           image: DecorationImage(
              //         image: AssetImage('assets/images/cardblank.png'),
              //       )),
              //       child: Center(
              //           child: Padding(
              //               padding: EdgeInsets.all(40),
              //               child: AutoSizeText(
              //                 widget.card.cardText,
              //                 minFontSize: 20,
              //                 maxFontSize: 40,
              //                 maxLines: 4,
              //                 style: TextStyle(
              //                     fontFamily: "fancy",
              //                     fontSize: 40,
              //                     height: 1.3),
              //                 textAlign: TextAlign.center,
              //               )))),
              // ])),
              controller: PageController(initialPage: widget.position, keepPage: true, viewportFraction: 1),
              itemBuilder: (context, position) {
                return Column(children: <Widget>[
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
                                  widget.cards[position].cardText,
                                  minFontSize: 20,
                                  maxFontSize: 40,
                                  maxLines: 4,
                                  style: TextStyle(
                                      fontFamily: "fancy",
                                      fontSize: 40,
                                      height: 1.3),
                                  textAlign: TextAlign.center,
                                )))),]),
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
                                getFaveIcon(position),
                                size: (MediaQuery.of(context).size.height / 4) /
                                    4,
                              ),
                              color: Colors.red,
                              onPressed: () {
                                // Function call to what happens when the favorite icon is pressed
                                favorite(position);
                              },
                            ),
                            SizedBox(
                                width: MediaQuery.of(context).size.width / 10),
                            Icon(
                              Icons.share,
                              size:
                                  (MediaQuery.of(context).size.height / 4) / 4,
                            ),
                          ],
                        ))
                  
                ]);
              },
              itemCount: widget.cards.length,
            ),
          ])), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  //need functionality here to write to the file to change the saved status/show the new icon!
  void favorite(int position) {
    debugPrint("Favorite clicked!");
// if (widget.card.isFavorite == false) {
      if (widget.cards[position].isFavorite == false) {
      widget.cards[position].setFavorite(true);
      // widget.card.setFavorite(true);
    } else {
      widget.cards[position].setFavorite(true);
      // widget.card.setFavorite(false);
    }
    setState(() {});
  }
}
