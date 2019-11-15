import 'package:share/share.dart';

import 'collection-screen.dart';
import 'nav-drawer.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'card-class.dart';
import 'package:flip_card/flip_card.dart';
import 'main.dart';

GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();

class MyCard extends StatefulWidget {
  MyCard({Key key, this.card, @required this.cards, @required this.position})
      : super(key: key);
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
  void initState() {
    _isVisible = getVisibility();
    super.initState();
  }

  Future<void> _ackAlert(BuildContext context) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Delete Card?'),
        content: const Text('Pressing "ok" will delete this card. Are you sure?')
        ,
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
            
              Navigator.of(context, rootNavigator: true).pop();
              Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Collection(fave: false),)
                  );
            },
          ),
        
        ],
      );
    },
  );
}



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text('My Affirmation'),
          automaticallyImplyLeading: true,
          //`true` if you want Flutter to automatically add Back Button when needed,
          //or `false` if you want to force your own back button every where
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);

              return Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Collection(fave: false)));
            },
          ),
          actions: <Widget>[
            Visibility(
            visible: _isVisible,
            child:
          IconButton(
            icon: Icon(Icons.delete,color:Colors.black),
            onPressed: () async {
            await _ackAlert(context);
            


            },
          )
            )],
          
          
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
              onPageChanged: _pageChange,
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
                      front: Container(
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
                                      textAlign: TextAlign.center)))),

                      back: Container(
                          height: (MediaQuery.of(context).size.height / 4) * 3,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(
                                    CardClass.getPreferenceImagePath())),
                          )),
                      
                    )
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
                              getFaveIcon(position),
                              size:
                                  (MediaQuery.of(context).size.height / 4) / 4,
                            ),
                            color: Colors.red,
                            onPressed: () {
                              // Function call to what happens when the favorite icon is pressed
                              favorite(position);
                            },
                          ),
                          SizedBox(
                              width: MediaQuery.of(context).size.width / 10),
                          IconButton(
                            padding: EdgeInsets.all(0),
                            icon: Icon(
                              Icons.share,
                              size:
                                  (MediaQuery.of(context).size.height / 4) / 4,
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
      widget.cards[position].setFavorite(false);
      // widget.card.setFavorite(false);
    }
  }
  


  getVisibility(){
    return !CardClass.getCards()[widget.position].getIsDefault();
  }
  getPageVisibility(page){
    return !CardClass.getCards()[page].getIsDefault();
  }
  _pageChange(page){
    setState(() {
      _isVisible = getPageVisibility(page);
    });

  }
    

}
