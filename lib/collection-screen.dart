import "package:flutter/material.dart";
import "card-class.dart";
import 'main.dart';

class Collection extends StatefulWidget {
  Collection({Key key}) : super(key: key);
  final List cards = CardClass.getCards(); 

  @override
  _Collection createState() => _Collection();
}

class _Collection extends State<Collection> {

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Collection"),
      ),
      body: Center(
        child: Stack(alignment: AlignmentDirectional.center, children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: FittedBox(
              fit: BoxFit.cover,
              child: Image.asset('assets/images/noleaves2.png'),
            ),
          ),
            ListView.builder(
  itemBuilder: (context, position) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding:
                      const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 6.0),
                  child: Text(
                    widget.cards[position].cardText,
                    style: TextStyle(
                        fontSize: 22.0, fontWeight: FontWeight.bold),
                  ),
                ),
                // Padding(
                //   padding:
                //       const EdgeInsets.fromLTRB(12.0, 6.0, 12.0, 12.0),
                //   child: Text(
                //     cards[position],
                //     style: TextStyle(fontSize: 18.0),
                //   ),
                // ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(
                    "5m",
                    style: TextStyle(color: Colors.grey),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.star_border,
                      size: 35.0,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Divider(
          height: 2.0,
          color: Colors.grey,
        )
      ],
    );
  },
  itemCount: widget.cards.length,
),
          
        ]),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
