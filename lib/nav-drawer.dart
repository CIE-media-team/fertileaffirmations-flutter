import 'dart:io';
import 'dart:math';

import 'package:fertile_affirmations/card-class.dart';
import 'package:fertile_affirmations/card-screen.dart';
import 'package:fertile_affirmations/custom-affirmation.dart';
import 'package:flutter/material.dart';
import 'main.dart';
import 'select-goddess.dart';
import 'collection-screen.dart';
import 'package:flutter/foundation.dart';
import 'card-class.dart';


class MyNavigationDrawer extends StatelessWidget {
  
  //returns a random card stored in the text file
  //Once we have the favorite/share button, we can just do a setState and update the boolean value for isFavorited.
  CardClass getCard(){  
    var rng = new Random();
    var cards = CardClass.getCards();

    var num = rng.nextInt(cards.length);
    return cards[num];


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
            menuItem("Affirmation", Icons.photo_library, MyCard(card: getCard(),), context),
            menuItem("Collection", Icons.apps, Collection(), context), 
            menuItem("Custom Affirmation", Icons.add, CustomAffirmation(), context), 
            menuItem("Favorites", Icons.favorite, MyHomePage(), context), 
            menuItem("Remind Me", Icons.alarm, MyHomePage(), context), 
            menuItem("Reset", Icons.restore, MyHomePage(), context), 
            menuItem("Select Your Goddess", Icons.people, MyHomePage(), context), 
            Divider(), 
            menuItem("Share", Icons.share, MyHomePage(), context), 
            menuItem("Learn More", Icons.mail, MyHomePage(), context), 
            menuItem("Purchase Deck", Icons.shopping_cart, MyHomePage(), context)
          ],
        ),
      ),
    );
  }
    Widget menuItem (String title, IconData icon, Widget routeTo, BuildContext context) { 
    return ListTile(
              title: new Text(title, style: TextStyle(color: Theme.of(context).primaryColorDark,
                  // fontWeight: FontWeight.bold,
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