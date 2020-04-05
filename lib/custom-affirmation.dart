import 'package:fertile_affirmations/card-class.dart';

import 'nav-drawer.dart';
import 'package:flutter/material.dart';
import 'main.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
          child:
              Stack(alignment: AlignmentDirectional.center, children: <Widget>[
            Container(
              margin: EdgeInsets.all(10),
              child: Image.asset('assets/images/cardBlanknew.png'),
            ),
            Container(
                width: MediaQuery.of(context).size.width / 4 * 3,
                height: getHeight(),
                alignment: Alignment.center,
                child: Center(
                    child: TextField(
                  textAlign: TextAlign.center,
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.multiline,
                  textAlignVertical: TextAlignVertical.center,
                  controller: myController,
                  decoration: InputDecoration(
                    hintText:
                        'Enter text here and press submit to create your new card',
                    hintMaxLines: 5,
                    border: InputBorder.none,
                  ),
                  autocorrect: true,
                  expands: true,
                  maxLines: null,
                  minLines: null,
                  style: TextStyle(
                      fontFamily: "new",
                      color: Color(0xff41311F),
                      fontSize: (MediaQuery.of(context).size.height) / 20,
                      height: 1.5),
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
      save();
    }
  }

  getNextNumber() {
    int numcards = CardClass.getUserCards().length;
    return (100 + numcards + 1).toString();
  }

  getHeight() {
    double height = MediaQuery.of(context).size.height;
    if (height > 800) {
      return (MediaQuery.of(context).size.height / 6) * 2.8;
    } else {
      return (MediaQuery.of(context).size.height / 6) * 3.5;
    }
  }
}
