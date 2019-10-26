
import 'dart:math';

import 'package:flutter/material.dart';
class CardClass {
  String cardText; 
  String cardID; 
  bool isFavorite = false; 
  bool isDefault = true;
  static List cards = [];
  

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
 // debugPrint(number.toString());
  //debugPrint(cards.length.toString());
  CardClass c= cards[rng.nextInt(cards.length)];
  debugPrint(c.toString());
  return c;


  }

}



  
  

