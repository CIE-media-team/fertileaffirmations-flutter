
import 'dart:math';
import 'main.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
class CardClass {
  String cardText; 
  String cardID; 
  bool isFavorite = false; 
  bool isDefault = true;
  static List cards = [];
  static bool preference;
  static bool fave = false;
  static bool firstLaunch = true;
  static List instructions =[];
  static bool creations = false;
  static BuildContext context = null;
  static String versionNumber;

  

  CardClass(String number, String text, String b, String isDefault)
  
  {

    this.cardID = number;
    this.cardText = text.replaceAll("*", "\n");

    if(b.toLowerCase() == "false"){
      this.isFavorite = false;
    }
    else{
      this.isFavorite = true;
    }
    if(isDefault.toLowerCase() == "true"){
      this.isDefault = true;
    }
    else{
      this.isDefault = false;
      this.cardID = "";
    }
    cards.add(this);




  }
  static bool getFirstLaunch(){
    return firstLaunch;
  }
  static void setFirstLaunch(){
    firstLaunch = false;

  }
  

  void setFavorite(bool b){
    this.isFavorite = b;
    save();
  }
  String getImage(){
    var cardstr = "card" + cardID;
    String s = "assets/images/$cardstr.png";
    debugPrint(s);

    if (this.isDefault == false){
      return "assets/images/filledBlank.png";
    }

    return s;
  }
  
 
  //Needs to replicate EXACTLY how the cards are stored.
  String toString(){
    return(cardID+"&"+cardText.replaceAll("\n", "*")+"&"+isFavorite.toString()+"&"+isDefault.toString() + "&");
  }

  static String getAllStrings(){
    var s = "";

    for(CardClass c in cards){
      s += c.toString();

    }
    return s;
  }

  static List getPermPrefAndUserCards(){
    var permpref = "";
    var usercards = "";
    var list = [];
    
    for(CardClass c in cards){
      if(c.isDefault == true){
        permpref += c.toString();
      }
      else{
        usercards += c.toString();
      }
    }
    // debugPrint("User cards: " + usercards);
    list = [permpref,usercards];
    return list;
  }
  


//returns a random card stored in the text file
//Once we have the favorite/share button, we can just do a setState and update the boolean value for isFavorited.



static CardClass getRandomCard(){  
  final rng = new Random();
  CardClass c= cards[rng.nextInt(cards.length-1)];
  // debugPrint(c.toString());
  //return c;
  return cards[56];


  }

  //resets cards list
  static void resetCards(){
    cards.clear();
  }

  static List getCards(){
    return cards;
  }
  static List getFavorites(){
    var l = [];
    for(CardClass c in cards){
      if(c.isFavorite){
        l.add(c);
      }
    }
    return l;
  }
  static List getUserCards(){
    var l = [];
    for(CardClass c in cards){
      if(!c.isDefault){
        l.add(c);
      }
    }
    return l;
  }

    static List getFaveCreations(){
    var l = [];
    for(CardClass c in cards){
      if(c.isFavorite && !c.isDefault){
        l.add(c);
      }
    }
    return l;
  }

  static bool getPreference(){
    acquirePreference();
    return preference;



  }

  static acquirePreference() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    preference = (prefs.getBool('pref') ?? true);

  }
  static setPreference(bool b) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("pref", b);
    preference = b;

  }

    static String getPreferenceImagePath (){ 
    if (CardClass.getPreference() == true){ 
      return 'assets/images/porcelainround.png';
    }
    else{
      return 'assets/images/warmround.png';
    }
  }

     static String getFirstPreferenceImagePath (){ 
    if (CardClass.getPreference() == true){ 
      return 'assets/images/porcelainfirst.png';
    }
    else{
      return 'assets/images/warmfirst.png';
    }
  }

  static void setFave(bool b){
    fave = b;
  }
  static bool getFave(){
    return fave;
  }

  bool getIsDefault(){
    return isDefault;
  }


}



  
  

