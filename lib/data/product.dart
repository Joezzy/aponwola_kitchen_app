// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

// Product productFromJson(String str) => Product.fromJson(json.decode(str));

String productToJson(Product data) => json.encode(data.toJson());
List<Product> productResultFromJson(String str) =>
    List<Product>.from(json.decode(str).map((x) => Product.fromJson(x)));

class Product {
  String? id;
  String? name;
  String? category;
  String? day;
  String? meal_type;
  double? price;
  String? description;
  String? image;

  Product({
    this.id,
    this.name,
    this.category,
    this.day,
    this.meal_type,
    this.price,
    this.description,
    this.image,
  });

  toJson(){
    return {"price": price,
      "name": name,
      "description": description,
      "category": category,
      "meal_type": meal_type,
      "day": day,"image":image};
  }

  factory Product.fromSnapShot(QueryDocumentSnapshot<Object?> documentSnapshot) {
    Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;
    return  Product(
      id: documentSnapshot.id,
      name: data["name"],
      category: data["category"],
      day: data["day"],
      meal_type: data["meal_type"],
      price: data["price"]==null || data["price"]==""?0.0:double.parse(data["price"].toString()),
      description: data["description"],
      image: data["image"],
    );
  }

  // factory Product.fromJson(Map<String, dynamic> json) => Product(
  //   count: json["count"],
  //   next: json["next"],
  //   previous: json["previous"],
  //   productResult: List<ProductResult>.from(json["results"].map((x) => ProductResult.fromJson(x))),
  // );

  factory Product.fromJson(Map<String, dynamic> data) {
    return  Product(
      name: data["name"],
      category: data["category"],
      day: data["day"],
      meal_type: data["meal_type"],
      price: data["price"]==null || data["price"]==""?0.0:double.parse(data["price"].toString()),
      description: data["description"],
      image: data["image"],
    );
  }






}

// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);
