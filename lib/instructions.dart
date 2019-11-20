import 'package:fertile_affirmations/card-class.dart';
import 'package:fertile_affirmations/custom-affirmation.dart';
import 'package:flutter/material.dart';
import 'package:fertile_affirmations/main.dart';
import 'package:flutter/semantics.dart';
import 'card-screen-random.dart';
import 'select-goddess.dart';
import 'collection-screen.dart';
import 'card-class.dart';
import 'main.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share/share.dart';
import 'remind-me.dart';

class InstructionScreen extends StatelessWidget {
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
            title: Text('Instructions'),
            automaticallyImplyLeading: true,
            //`true` if you want Flutter to automatically add Back Button when needed,
            //or `false` if you want to force your own back button every where
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          backgroundColor: Colors.transparent,
          body: 

            ListView.builder(
        itemCount: CardClass.instructions.length,
        itemBuilder: (context, index) {
          return ListTile(
            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            title: Text(CardClass.instructions[index], style: TextStyle(fontSize: 20),),
          );
        },
      

      ))]);
          // Padding(
          //   padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          //   child:Center(
          //     child: SingleChildScrollView(
          //       child: Text(
          //   CardClass.instructions.toString(),
          //   style: TextStyle(fontSize: 24),
            
          // ))))

  }
}
