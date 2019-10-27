import 'package:fertile_affirmations/card-class.dart';

import 'nav-drawer.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'main.dart';
class CustomAffirmation extends StatelessWidget {

  final myController = TextEditingController();

  //Do not delete this code, IDK if we need it or not. 
  // @override
  // void dispose() {
  //   // Clean up the controller when the widget is disposed.
  //   myController.dispose();
  // }

  
 
  final textController = TextEditingController(text: 'Enter your custom affirmation here.');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset : false,

      
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text('Fertile Affirmations'),
        actions: <Widget>[
          IconButton(
            icon:Icon(Icons.check), 
            onPressed: (){createCard();},)
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
              child:Container(
                alignment: Alignment.center,
                  child: Center(
                  child:TextField(
                    textAlign: TextAlign.center,
                    textInputAction: TextInputAction.go,
                    keyboardType: TextInputType.multiline,
                    textAlignVertical: TextAlignVertical.center,
                    controller: myController,





                    decoration: InputDecoration(
                      
                      hintText: 'Enter text here and press submit to create your new card', 
                      hintMaxLines: 4,
                      
                      border: InputBorder.none,
                      // border: OutlineInputBorder(),
                      ),
                                      
                    //autofocus: true,
                    autocorrect: true,
                    maxLengthEnforced: true,
                    //+expands: true,
                    
                    maxLines: 8, minLines: 1,
                    style: TextStyle(fontFamily: "fancy", fontSize: 30, height: 1.5),
                    



                  )))
              )
        ]),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
createCard(){
  //How are we going to determine what number? Have the user choose? Can we have 2 of the same number?
  //Need to add favorite button so we can store if it is a favorite or not.
  new CardClass("57", myController.text, "false", "false");
  save();
  

  }
}
