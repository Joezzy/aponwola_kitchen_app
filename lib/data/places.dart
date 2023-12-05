// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';


String placeToJson(Place data) => json.encode(data.toJson());

class Place {
  String? id;
  String? place;
  double? amount;

  Place({
    this.id,
    this.place,
    this.amount
  });

  toJson(){
    return {
      "place": place,
      "amount":amount
    };
  }


  factory Place.fromSnapShot(QueryDocumentSnapshot<Object?> documentSnapshot) {
    Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;
    return  Place(
      id: documentSnapshot.id,
      place: data["place"],
      amount: double.parse(data["amount"].toString())
    );
  }
}

