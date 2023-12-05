

import 'package:aponwola/data/dropdownClass.dart';
import 'package:aponwola/data/foodOptions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

String? loginToken;
String msgTitle="aponwola_admin";
final firebase = FirebaseFirestore.instance;

 // const List<String> dayList=["monday","tuesday","wednesday","thursday","friday"];
 // const List<String> dayList=["Food in bowls","Soup in litres", "Food in bulk"];
// CurrentUser? currentUser;


// List<FoodOption> bulkFoodList=[
//  FoodOption(image: "assets/bowl.jpg", title: "Food in bowls", value:"
//
//  food_bowl"),
//  FoodOption(image: "assets/soup.jpg", title: "Soup in litre", value:"food_litre"),
//  FoodOption(image: "assets/bowl2.jpg", title: "Food in bulk", value:"food_bulk"),
// ];
