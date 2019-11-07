import 'package:fertile_affirmations/card-class.dart';

import 'nav-drawer.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'main.dart';

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
    return Scaffold(
      resizeToAvoidBottomInset: false,

      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text('Fertile Affirmations'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.check),
            onPressed: () {
              if(myController.text != null){
              createCard();
              Navigator.of(context).pop();
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyHomePage(
                      preference: true,
                    ),
                  ));
            }
            else{
              Navigator.of(context).pop();
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyHomePage(
                      preference: false,
                    ),
                  ));
              
            }
            },
          )
        ],
      ),
      drawer: MyNavigationDrawer(),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Stack(alignment: AlignmentDirectional.center, children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: FittedBox(
              fit: BoxFit.cover,
              child: Image.asset('assets/images/noleaves2.png'),
            ),
          ),
          Image.asset('assets/images/cardblank.png'),
          Padding(
              padding: EdgeInsets.all(30),
              child: Container(
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
                      hintMaxLines: 4,

                      border: InputBorder.none,
                      // border: OutlineInputBorder(),
                    ),

                    //autofocus: true,
                    autocorrect: true,
                    maxLengthEnforced: true,
                    //+expands: true,

                    maxLines: 8, minLines: 1,
                    style: TextStyle(
                        fontFamily: "fancy", fontSize: 30, height: 1.5),
                  ))))
        ]),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  createCard() {
    //How are we going to determine what number? Have the user choose? Can we have 2 of the same number?
    //Need to add favorite button so we can store if it is a favorite or not.
    if(myController.text != ""){
      new CardClass("57", myController.text, "false", "false");
      save();
    }

  }
}
