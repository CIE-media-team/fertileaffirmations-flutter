import 'package:auto_size_text/auto_size_text.dart';
import 'package:fertile_affirmations/card-class.dart';

import 'nav-drawer.dart';
import 'package:flutter/material.dart';
import 'main.dart';
import 'package:fluttertoast/fluttertoast.dart';

/*

Currently, when you hit done on the keyboard it launches a new custom affirmation screen and you 
lose the text you just spend time typing out. We need to solve this bug to make the keyboard disappear when 
when done is hit, then the check saves the card. 

Inputting emojis in custom affirmation messes up the formatting of all of the cards. We need to either fix
this or somehow not allow the users to save an emoji in their card. 
*/

class CustomAffirmation extends StatefulWidget {
  @override
  _CustomAffirmationState createState() => _CustomAffirmationState();
}

class _CustomAffirmationState extends State<CustomAffirmation> {
  final myController = TextEditingController();

  final textController =
      TextEditingController(text: 'Enter your custom affirmation here.');

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
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,

        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text('Custom Affirmation', style: TextStyle(fontSize: 30)),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.close,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            IconButton(
              icon: Icon(Icons.check),
              onPressed: () {
                if (myController.text != "") {
                  createCard();
                  Navigator.of(context).pop();
                  Fluttertoast.showToast(
                      msg: "Card added to your collection!",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.TOP,
                      timeInSecForIos: 1,
                      backgroundColor: Colors.black38,
                      textColor: Colors.white,
                      fontSize: 14.0);
                }
              },
            )
          ],
        ),
        drawer: MyNavigationDrawer(),
        body: Center(
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          child:
              Stack(alignment: AlignmentDirectional.center, children: <Widget>[
            Image.asset('assets/images/cardblank.png'),
            // Padding(
            //     padding: EdgeInsets.all(30),
            //     child:
            Container(
                // decoration:
                //     BoxDecoration(border: Border.all(color: Colors.black)),
                width: MediaQuery.of(context).size.width / 4 * 3,
                height: MediaQuery.of(context).size.height / 5 * 3,
                alignment: Alignment.center,
                child: Center(
                    child: TextField(
                  textAlign: TextAlign.center,
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.multiline,

                  textAlignVertical: TextAlignVertical.center,

                  controller: myController,
                  // onSubmitted: (term){
                  //   myController.clear();
                  // },

                  decoration: InputDecoration(
                    hintText: 
                        'Enter text here and press submit to create your new card',
                    hintMaxLines: 5,

                    border: InputBorder.none,
                    // border: OutlineInputBorder(),
                  ),

                  //autofocus: true,
                  autocorrect: true,

                  // maxLengthEnforced: true,
                  expands: true,

                  maxLines: null, minLines: null,
                  style: TextStyle(
                      fontFamily: "new",
                      color: Color(0xff41311F),
                      fontSize: (MediaQuery.of(context).size.height) / 20,
                      height: 1.5),
                  // )
                )))
          ]),
        ), // This trailing comma makes auto-formatting nicer for build methods.
      )
    ]);
  }

  createCard() {
    //How are we going to determine what number? Have the user choose? Can we have 2 of the same number?
    //Need to add favorite button so we can store if it is a favorite or not.
    if (myController.text != "") {
      new CardClass(getNextNumber(), myController.text, "false", "false");
      debugPrint(CardClass.getUserCards().toString());
      save();
    }
  }

  getNextNumber() {
    int numcards = CardClass.getUserCards().length;
    debugPrint("NextNumber: (100+numcards+1).toString()");
    return (100 + numcards + 1).toString();
  }
}
