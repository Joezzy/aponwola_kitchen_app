// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

// Product productFromJson(String str) => Product.fromJson(json.decode(str));

String categoryToJson(Category data) => json.encode(data.toJson());

class Category {
  String? id;
  String? name;
  String? description;
  String? image;
  String? type;

  Category({
    this.id,
    this.name,
    this.image,
    this.description,
    this.type,
  });

  toJson(){
    return { "name": name,
      "description":description,
      "type":type,
      "image":image};
  }
  factory Category.fromSnapShot(QueryDocumentSnapshot<Object?> documentSnapshot) {
    Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;
    return  Category(
      id: documentSnapshot.id,
      name: data["name"],
      description: data["description"],
      image: data["image"],
      type: data["type"],
    );
  }

}

