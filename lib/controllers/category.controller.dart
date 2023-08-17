
import 'dart:convert';
import 'dart:typed_data';

import 'package:aponwola/common/constant.dart';
import 'package:aponwola/data/category.dart';
import 'package:aponwola/data/places.dart';
import 'package:aponwola/data/product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryController extends GetxController{
  final FirebaseStorage _storage=FirebaseStorage.instance;
  var categoryList=<Category>[].obs;
  var categoryDailyList=<Category>[].obs;
  var categoryNormalList=<Category>[].obs;
  var isLoadingCategory=false.obs;
  var categoryType="normal".obs;

  Future getCategories()async {
  print("GET_CAT");
  isLoadingCategory.value=true;
  try{
    final cat=await firebase.collection('categories').
    orderBy('name', descending: true).get();
    categoryList.value= cat.docs.map((doc) => Category.fromSnapShot(doc)).toList();
    categoryNormalList.value = categoryList.where((i) => i.type == "normal").toList();
    categoryDailyList.value = categoryList.where((i) => i.type == "daily").toList();
    print("FISRT_ ${categoryNormalList.first.name}");
    isLoadingCategory.value=false;

  }catch(e){
    print(e);
    isLoadingCategory.value=false;
  }
}

Future deleteCategory(id)async {

  try{
    return firebase
        .doc(id)
        .delete()
        .then((value) {
          print("Category Deleted");
          getCategories();
            })
        .catchError((error) => print("Failed to delete category: $error"));

  }catch(e){
    print(e);
  }
}
  final key=GlobalKey<FormState>().obs;

  var nameController=TextEditingController().obs;
  var descController=TextEditingController().obs;
  var isLoading=false.obs;


Future addCategory(context,file)async {
  String img="";
  if(file!=null){
    img=await uploadImageToStorage("categories/${nameController.value.text}", file);
  }


   await firebase.collection('categories')
        .add({
      'name': nameController.value.text,
      'description': descController.value.text,
     'type': categoryType.value,
      'image': img
    }).then((value) {
      print("Product Added");
      getCategories();
      Navigator.pop(context);
    }).catchError((error) {
      print("Failed to add user: $error");
    });

 }
Future updateCategory(context,file,id)async {
  String img="";
  var body;
  if(file!=null){
    img=await uploadImageToStorage("products/${nameController.value.text}", file);
    body= {
      'name': nameController.value.text,
      'type': categoryType.value,
      'description': descController.value.text,
      'image': img
    };
  }else{
    body= {
      'name': nameController.value.text,
      'description': descController.value.text,
      'type': categoryType.value
    };
  }

    var res=await firebase.doc(id)
        .update(body).then((value) {
      print("Product updated");
      getCategories();
      Navigator.pop(context);
    }).catchError((error) {
      print("Failed to add user: $error");
    });
 }



  Future<String> uploadImageToStorage(String childName, Uint8List file)async{
    Reference ref=_storage.ref().child(childName);
    UploadTask uploadTask=ref.putData(file);
    TaskSnapshot snapshot=await uploadTask;
    String downloadUrl= await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

}