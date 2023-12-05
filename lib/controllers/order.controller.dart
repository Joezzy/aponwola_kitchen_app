

import 'dart:convert';
import 'dart:typed_data';

import 'package:aponwola/common/constant.dart';
import 'package:aponwola/data/category.dart';
import 'package:aponwola/data/order.dart';
import 'package:aponwola/data/places.dart';
import 'package:aponwola/data/product.dart';
import 'package:aponwola/services/api.service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderController extends GetxController{
  final FirebaseStorage _storage=FirebaseStorage.instance;
  var orderList= <OrderGroup>[].obs;

var isLoadingOrder=false.obs;

  Future getOrders(context)async {
    print("GET_ORDER");
    isLoadingOrder.value=true;
    try{
      final order=await firebase.collection('orders')
          .where('user_id', isEqualTo: ApiService.me.id)
          .orderBy("order_id",descending: true)
          .limit(50)
          .get();
    print(order.docs.first["order"]);
    print(order.docs);
    orderList.value= order.docs.map((doc) => OrderGroup.fromSnapShot(doc)).toList();
      print(orderList);
      isLoadingOrder.value=false;
    }catch(e){
      print(e);
      isLoadingOrder.value=false;
    }
  }


}