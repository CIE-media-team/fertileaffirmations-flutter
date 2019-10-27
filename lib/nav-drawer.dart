import 'dart:io';
import 'dart:math';

import 'package:fertile_affirmations/card-class.dart';
import 'package:fertile_affirmations/card-screen.dart';
import 'package:fertile_affirmations/custom-affirmation.dart';
import 'package:flutter/material.dart';
import 'package:fertile_affirmations/main.dart';
import 'select-goddess.dart';
import 'collection-screen.dart';
import 'package:flutter/foundation.dart';
import 'card-class.dart';
import 'main.dart';



class MyNavigationDrawer extends StatelessWidget {

  Future<void> _ackAlert(BuildContext context) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Reset Application?'),
        content: const Text('Pressing "ok" will clear all favorites and created cards. Are you sure?')
        ,
        actions: <Widget>[
            FlatButton(
            child: Text('Cancel'),
            onPressed: () {
            Navigator.of(context, rootNavigator: true).pop();
            },
          ),
          FlatButton(
            child: Text('Ok'),
            onPressed: () {
              
            
            Navigator.of(context, rootNavigator: true).pop();
            },
          ),
        
        ],
      );
    },
  );
}

  
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage('assets/images/noleaves2.png'), fit: BoxFit.cover),
          border: Border(top: BorderSide.none, bottom: BorderSide.none)
        ),
        child: ListView(
          
          children: <Widget>[
            Divider(),
            menuItem("Instructions", Icons.info, SelectGoddess(), context), 
            menuItem("Affirmation", Icons.photo_library, MyCard(), context),
            menuItem("Collection", Icons.apps, Collection(), context), 
            menuItem("Custom Affirmation", Icons.add, CustomAffirmation(), context), 
            menuItem("Favorites", Icons.favorite, MyHomePage(preference: false,), context), 
            menuItem("Remind Me", Icons.alarm, MyHomePage(preference: true,), context), 
            menuItem("Reset", Icons.restore, MyHomePage(preference: true,), context), 
            menuItem("Select Your Goddess", Icons.people, SelectGoddess(), context), 
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
              onTap: () async {
                if(title == "Reset"){
                  await _ackAlert(context);

                  resetApp();
                }
                Navigator.of(context).pop();
                
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => routeTo,)
                );
              },
            );
}
}