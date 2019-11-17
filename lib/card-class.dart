
import 'dart:math';

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
    }
    cards.add(this);




  }
  
  static List getCards(){
    return cards;
  }
  void setFavorite(bool b){
    this.isFavorite = b;
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
    debugPrint("User cards: " + usercards);
    list = [permpref,usercards];
    return list;
  }
  


//returns a random card stored in the text file
//Once we have the favorite/share button, we can just do a setState and update the boolean value for isFavorited.



static CardClass getRandomCard(){  
  final rng = new Random();
  CardClass c= cards[rng.nextInt(cards.length)];
  debugPrint(c.toString());
  return c;


  }

  //resets cards list
  static void resetCards(){
    cards.clear();
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
      return 'assets/images/porcelainroundsmall.png';
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



  
  

