
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
    this.cardText = text;

    if(b.toLowerCase() == "false"){
      this.isFavorite = false;
    }
    else{
      this.isFavorite = true;
    }
    if(isDefault.toLowerCase() == "true"){
      this.isFavorite = true;
    }
    else{
      this.isFavorite = false;
    }
    cards.add(this);




  }
  static List getCards(){
    return cards;
  }
  
 

  String toString(){
    return(cardID+"&"+cardText+"&"+isFavorite.toString()+"&"+isDefault.toString() + "&");
  }

  String getAllStrings(){
    var s = "";

    for(CardClass c in cards){
      s += c.toString();

    }
    return s;
  }
}

  
  

