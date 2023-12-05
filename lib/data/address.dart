// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';


String addressToJson(Address data) => json.encode(data.toJson());

class Address {
  String? id;
  String? place;
  double? amount;
  String? address;
  String? placeId;

  Address({
    this.id,
    this.place,
    this.amount=0.0,
    this.address,
    this.placeId
  });

  toJson(){
    return {
      "place": place,
      "amount":amount,
      "address":address,
      "place_id":placeId
    };
  }

  factory Address.fromSnapShot(QueryDocumentSnapshot<Object?> documentSnapshot) {
    Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;
    return  Address(
        id: documentSnapshot.id,
        place: data["place"],
        address: data["address"],
        placeId: data["place_id"],
        amount: double.parse(data["amount"].toString())
    );
  }
}

