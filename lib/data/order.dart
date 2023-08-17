// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);

import 'dart:convert';

import 'package:aponwola/data/product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


String orderToJson(OrderData data) => json.encode(data.toJson());

List<OrderData> orderDataFromJson(String str) =>
    List<OrderData>.from(json.decode(str).map((x) => OrderData.fromJson(x)));

class OrderData {
  String? id;
  String? groupId;
  String? fullName;
  String? phone;
  String? address;
  double? deliveryPrice;
  String? deliveryDate;
  String? deliveryTime;
  String? date;
  String? place;
  int? quantity;
  double? subtotal;
  double? total;
  List<Product>? products;

  OrderData({
    this.id,
    this.address,
    this.groupId,
    this.phone,
    this.deliveryPrice,
    this.place,
    this.quantity,
    this.subtotal,
    this.total,
    this.products,
    this.fullName,
    this.deliveryDate,
    this.deliveryTime,
    this.date
  });

  toJson(){
    return {
      "id": id,
      "group_id": groupId,
      "address": address,
      "phone": phone,
      "delivery_price":deliveryPrice,
      "place":place,
      "quantity":quantity,
      "subtotal":subtotal,
      "total":total,
      "fullname":fullName,
      "delivery_date":deliveryDate,
      "delivery_time":deliveryTime,
      "products":products,
      "date":date,
    };
  }

  factory OrderData.fromSnapShot(QueryDocumentSnapshot<Object?> documentSnapshot) {
    Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;
    return  OrderData(
      id: documentSnapshot.id,
        groupId: data["group_id"],
      address: data["address"],
      phone: data["phone"]==""?"NA":data["phone"],
      deliveryPrice: data["delivery_price"],
      place: data["place"],
      quantity: data["quantity"],
      subtotal: data["subtotal"],
      total: data["total"],
      fullName: data["fullname"],
      date: data["date"],
      // deliveryTime: data["delivery_time"].toString(),
      //   deliveryDate:data["delivery_date"].toString(),
            // ==null?DateTime.now(): DateTime.parse(data["delivery_date"]),
        products:  productResultFromJson(json.encode(data["products"]))
      // products: data["products"].map((doc) => Product.fromSnapShot(doc)).toList()
    );
  }


  factory OrderData.fromJson(Map<String, dynamic> data) {
    return  OrderData(
        groupId: data["group_id"],
        address: data["address"],
        phone: data["phone"],
        deliveryPrice: data["delivery_price"],
        place: data["place"],
        quantity: data["quantity"],
        subtotal: data["subtotal"],
        total: data["total"],
        fullName: data["fullname"],
        deliveryTime: data["delivery_time"].toString(),
        deliveryDate:data["delivery_date"].toString(),
        date:data["date"].toString(),
        // ==null?DateTime.now(): DateTime.parse(data["delivery_date"]),
        products:  productResultFromJson(json.encode(data["products"]))
    );
  }

}


class OrderGroup {
  String? id;
  List<OrderData>? order;

  OrderGroup({
    this.id,
    this.order,
  });

  toJson(){
    return {
      "id": id,
      "order": order,

    };
  }
  factory OrderGroup.fromSnapShot(QueryDocumentSnapshot<Object?> documentSnapshot) {
    Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;
    return  OrderGroup(
      id: documentSnapshot.id,
        order:  orderDataFromJson(json.encode(data["order"]))
    );
  }

}

