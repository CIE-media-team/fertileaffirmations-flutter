import 'dart:math';

import 'package:fertile_affirmations/card-class.dart';
import 'package:fertile_affirmations/card-screen.dart';
import 'package:fertile_affirmations/custom-affirmation.dart';
import 'package:flutter/material.dart';
import 'package:fertile_affirmations/main.dart';
import 'select-goddess.dart';
import 'collection-screen.dart';

class MyNavigationDrawer extends StatelessWidget {
  
  //Later, cards will be all cards in the database, not hardcoded.
   final List<String> cards = ["I have a body that is healthy, strong and ready to embrace my child.","I have a mind that is healthy, strong and ready to embrace my child."
  "I am healing all that emerges as I walk through my journey toward parenthood.","I am living my life fully and completely.","I am fertile in all areas of my life.", "My mind, body and soul are filled with all the abundant energy I need to care for my child."];

  int getCard(){  

    var rng = new Random();
    return rng.nextInt(cards.length);
    


  }


  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        // color: Theme.of(context).primaryColor, 
        decoration: BoxDecoration(
          // color:Theme.of(context).primaryColor ,
          image: DecorationImage(image: AssetImage('assets/images/noleaves2.png'), fit: BoxFit.fill),
          border: null,
        ),
        child: ListView(
          
          children: <Widget>[
            menuItem("Instructions", Icons.info, SelectGoddess(), context), 
            menuItem("Affirmation", Icons.photo_library, MyCard(card: new CardClass(cardText: cards[getCard()]),), context),
            menuItem("Collection", Icons.apps, Collection(), context), 
            menuItem("Custom Affirmation", Icons.add, CustomAffirmation(), context), 
            menuItem("Favorites", Icons.favorite, MyHomePage(preference: false,), context), 
            menuItem("Remind Me", Icons.alarm, MyHomePage(preference: true,), context), 
            menuItem("Reset", Icons.restore, MyHomePage(preference: true,), context), 
            menuItem("Select Your Goddess", Icons.people, MyHomePage(preference: true,), context), 
            Divider(), 
            menuItem("Share", Icons.share, MyHomePage(preference: false,), context), 
            menuItem("Learn More", Icons.mail, MyHomePage(preference: false,), context), 
            menuItem("Purchase Deck", Icons.shopping_cart, MyHomePage(preference: false,), context)
          ],
        ),
      ),
    );
  }
    Widget menuItem (String title, IconData icon, Widget routeTo, BuildContext context) { 
    return ListTile(
      dense: true,
              title: new Text(title, style: TextStyle(color: Theme.of(context).primaryColorDark,
                  fontWeight: FontWeight.bold,
                  fontSize: 18)),
              trailing: Icon(Icons.chevron_right),
              leading: Icon(icon),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => routeTo,)
                );
              },
            );
}
}