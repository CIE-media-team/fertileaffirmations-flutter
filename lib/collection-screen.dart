import 'dart:io';

import 'package:flutter/foundation.dart';
import "package:flutter/material.dart";
import "card-class.dart";
import 'main.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'card-screen.dart';
import 'custom-affirmation.dart';

class Collection extends StatefulWidget {
  Collection({Key key}) : super(key: key);
  final List cards = CardClass.getCards();

  @override
  _Collection createState() => _Collection();
}

class _Collection extends State<Collection> {

  Size size(){
    return (MediaQuery.of(context).size); 
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Collection"),
      ),
      body: Center(
        child: Column(children: <Widget>[
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 5,
                  childAspectRatio: 50 / 75),
              scrollDirection: Axis.vertical,
              itemBuilder: (context, position) {
                return Container(
                    height: 100,
                    width: 50,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/images/noleaves2.png'),
                            fit: BoxFit.fill),
                        // border: Border.all(color: Colors.black, width: 1),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: FlatButton(
                        padding: EdgeInsets.all(0),
                        onPressed: () {
                          debugPrint(widget.cards[position].cardText);
                          Navigator.of(context).pop();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      MyCard(card: widget.cards[position])));
                        },
                        child: Stack(
                          alignment: Alignment.center,
                          children: <Widget>[
                            // Image.asset('assets/images/noleaves2.png'),
                            Image.asset(
                              'assets/images/cardblank.png',
                              fit: BoxFit.cover,
                            ),
                            AutoSizeText(
                              widget.cards[position].cardText,
                              // maxFontSize: 10,
                              minFontSize: 10,
                              maxLines: 4,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Theme.of(context).primaryColorDark,
                                  fontFamily: "fancy",
                                  fontSize: 4,
                                  height: 1),
                            )
                          ],
                        )));
              },
              itemCount: widget.cards.length,
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
                    onPressed: () {},
                    child: Text("My Creations",
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
                      Icons.favorite_border,
                      color: Colors.red,
                      size: 30,
                    ),
                    onPressed: () {},
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
}
