
import 'package:flutter/material.dart';

class CardClass {
  String cardText; 
  int cardID; 
  bool isFavorite = false; 
  bool isDefault = false;

  CardClass({
    this.cardText,
    this.cardID,
    this.isDefault, 
    this.isFavorite}
  );
  
}
