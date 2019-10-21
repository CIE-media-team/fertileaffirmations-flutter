import 'package:flutter/material.dart';
import 'main.dart';

class MyNavigationDrawer extends StatelessWidget {


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
            menuItem("Instructions", Icons.info, MyHomePage(), context), 
            menuItem("Affirmation", Icons.photo_library, MyHomePage(), context),
            menuItem("Collection", Icons.apps, MyHomePage(), context), 
            menuItem("Custom Affirmation", Icons.add, MyHomePage(), context), 
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