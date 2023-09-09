
import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';

import 'package:aponwola/common/constant.dart';
import 'package:aponwola/controllers/order.controller.dart';
import 'package:aponwola/data/address.dart';
import 'package:aponwola/data/cart.dart';
import 'package:aponwola/data/category.dart';
import 'package:aponwola/data/places.dart';
import 'package:aponwola/data/product.dart';
import 'package:aponwola/services/api.service.dart';
import 'package:aponwola/view/success/success.view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CartController extends GetxController{
  final addressKey=GlobalKey<FormState>().obs;
 final orderController=Get.put(OrderController())
;  var addressController=TextEditingController().obs;

  var cartList=<List<Product>>[].obs;
  var cartModelList=<CartModel>[].obs;
  var totalFoodPrice=0.0.obs;
  var totalPriceWithDelivery=0.0.obs;

  var placesList=<Place>[].obs;
  var addressList=<Address>[].obs;
  var selectedPlace="".obs;
  var placeObject=Place().obs;
  var selectedAddress=Address().obs;

  var selectedDate = DateFormat('yyyy-MM-dd').format(DateTime.now()).obs;
  var selectedTime = DateFormat('HH:mm:ss').format(DateTime.now()).obs;
  var pickedTimeFormat = "".obs;
 var isLoading=false.obs;
  Future<void> pickDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(3040, 8),);
    if (picked != null){
      // selectedDate.value = picked;
      selectedDate.value = DateFormat('yyyy-MM-dd').format(picked);
    }

  }

  Future<void> pickTime(context) async {
    TimeOfDay? pickedTime =  await showTimePicker(
      initialTime: TimeOfDay.now(),
      context: context, //context of current state
    );

    if(pickedTime != null ){
      print(pickedTime.format(context));
      pickedTimeFormat.value=pickedTime.format(context);//output 10:51 PM
      DateTime parsedTime = DateFormat.jm().parse(pickedTime.format(context).toString());
      //converting to DateTime so that we can further format on different pattern.
      // print(parsedTime); //output 1970-01-01 22:53:00.000
       selectedTime.value= DateFormat('HH:mm:ss').format(parsedTime);
      //DateFormat() is from intl package, you can format the time on any pattern you need.
    }else{
      print("Time is not selected");
    }
  }


  selectPlace(String place){
    selectedPlace.value =place;
    placeObject.value= placesList.where((i) => i.id==place).toList().first;
    print(placeObject.value.place);
    print(placeObject.value.amount);
    print(placeObject.value.id);
  }

  addAddressMethod(context)async{

    await firebase.collection('users')
        .doc(ApiService.me.id)
        .collection("address")
        .doc(DateTime.now().millisecondsSinceEpoch.toString())
        .set({
      'address': addressController.value.text,
      'place_id':  placeObject.value.id,
      'place':  placeObject.value.place,
      'amount':  placeObject.value.amount
    }).then((value) {
      print("Success");
      addressController.value.text="";
      getAddressMethod();
      Navigator.pop(context);
    }).catchError((error) {
      log("Failed, $error");
    });
  }


  Future getAddressMethod()async {

    try{
      final address=  await firebase.collection('users')
          .doc(ApiService.me.id).collection("address").orderBy('place', descending: true).get();
           addressList.value= address.docs.map((doc) => Address.fromSnapShot(doc)).toList();
           if(addressList.isNotEmpty){
             selectAddress(addressList.first);

           }else{
             selectedAddress.value=Address();
           }
    }catch(e){
      //
    }
  }

  selectAddress(Address addr){
    selectedAddress.value=addr;
    calculateTotal();
  }

  Future getDeliveryCostMethod()async {
    try{
      final places=await firebase.collection('places').orderBy('place', descending: true).get();
      print(places);
      placesList.value= places.docs.map((doc) => Place.fromSnapShot(doc)).toList();
      selectedPlace.value=placesList.first.id!;
      // print("FISRT_ ${placesList.first.place}");
      selectPlace(selectedPlace.value);
    }catch(e){
      //
    }
  }


  addToCart(List<Product> cart){
    List  productList= cartList.where((i) => i==cart).toList();
    double subTotal=0.0;
    for(var i=0; i<cart.length; i++){
      subTotal=subTotal+cart[i].price!;
    }

    cartModelList.add(CartModel(productList: cart, quantity:productList.length+1,total:subTotal, subTotal: subTotal));
    print("INT=${productList.length}");
    calculateTotal();
  }

  calculateTotal(){
    totalFoodPrice.value=0.0;
    for(var x=0; x<cartModelList.length; x++){
     print(cartModelList[x]);
       totalFoodPrice.value=totalFoodPrice.value + cartModelList[x].subTotal!;
    }
    totalPriceWithDelivery.value=totalFoodPrice.value + selectedAddress.value!.amount!;
  }

  removeItem(CartModel cartItem){
    cartModelList.remove(cartItem);
    calculateTotal();
  }

  increaseItem(CartModel cartItem){
    double subTotal=0.0;
    double total=0.0;
    int qty=0;

    if(cartModelList.contains(cartItem)){
      qty=cartItem!.quantity! + 1;
      subTotal=cartItem.total! * qty;
      // subTotal=cartItem.subTotal! * qty;
      // cartModelList.remove(cartItem);
      cartModelList[cartModelList.indexWhere((element) => element.productList == cartItem.productList)]
      = CartModel(productList: cartItem.productList, quantity:qty,total: cartItem.total, subTotal:subTotal);
      // cartModelList.add(CartModel(productList: cartItem.productList, quantity:qty,subTotal:subTotal));
    }

    // List  productList= cartList.where((i) => i==cart).toList();
    // for(var i=0; i<cart.length; i++){
    //   subTotal=subTotal+cart[i].price!;
    // }

    calculateTotal();
  }

  decreaseItem(CartModel cartItem){
    double subTotal=0.0;
    int qty=0;
    if(cartModelList.contains(cartItem)){
      qty=cartItem!.quantity! - 1;
      subTotal=cartItem.subTotal! - cartItem.total!;
      // subTotal= cartItem.total! * qty;

      // cartModelList.remove(cartItem);
      if(qty>0){
        cartModelList[cartModelList.indexWhere((element) => element.productList == cartItem.productList)] = CartModel(productList: cartItem.productList, quantity:qty, total:cartItem.total, subTotal:subTotal);
      }
      // cartModelList.add(CartModel(productList: cartItem.productList, quantity:qty,subTotal:subTotal));
    }

    calculateTotal();
  }



 Future checkOut(context)async{
    isLoading.value=true;
    List allProduct = [];
    var docValue=DateTime.now().millisecondsSinceEpoch.toString();

    for(var cart=0; cart<cartModelList.length; cart++) {
      List<Map<String, dynamic>> products = [];
      List<Product>? productList = cartModelList[cart].productList;
      for (var x = 0; x < productList!.length; x++) {
        productList[x].toJson();
        products.add(productList[x].toJson());
      }


      var body={
        'group_id': docValue,
        'products': products,
        'quantity':  cartModelList[cart].quantity,
        'subtotal':  cartModelList[cart].subTotal,
        'address': selectedAddress.value.address,
        'place': selectedAddress.value.place,
        'delivery_price': selectedAddress.value.amount,
        'total': totalPriceWithDelivery.value,
        'fullname': ApiService.me.name,
        'phone': ApiService.me.phone??'No phone',
        'date': DateFormat('dd-MM-yyyy').format(DateTime.now()),
        'delivery_date': selectedDate.value,
        'delivery_time': pickedTimeFormat.value,
      };
      allProduct.add(body);
    }

      print(allProduct);
      await firebase.collection('orders')
      .doc(docValue)
          .set({
        "order_id": int.parse(docValue),
        "order":allProduct,
        'user_id': ApiService.me.id
      }

      ).then((value) {
      print("Success");
      // products.clear();
      cartModelList.clear();
      orderController.getOrders(context);

      Navigator.of(context, rootNavigator: true).push(
          MaterialPageRoute(
              builder: (BuildContext context) =>const SuccessView()));


      }).catchError((error) {
        print("Faiiledd, $error");
        isLoading.value=false;
      });



    // cartModelList.clear();


    isLoading.value=false;

  }



}