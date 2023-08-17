
import 'dart:convert';
import 'dart:typed_data';

import 'package:aponwola/common/constant.dart';
import 'package:aponwola/common/myDialog.dart';
import 'package:aponwola/controllers/cartController.dart';
import 'package:aponwola/data/product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductController extends GetxController{
  final cartController=Get.put(CartController());

  CollectionReference products = FirebaseFirestore.instance.collection('products');
  final FirebaseStorage _storage=FirebaseStorage.instance;

  var productListAll=<Product>[].obs;
  var productListNormal=<Product>[].obs;
  var productListDaily=<Product>[].obs;
  var productListDailyMain=<Product>[].obs;
  var productListDailyProtein=<Product>[].obs;
  var productListDailySide=<Product>[].obs;
  var productListBowl=<Product>[].obs;





Future getProducts()async {
  try{
    final prod=await products.
    orderBy('name', descending: true).get();
    productListAll.value= prod.docs.map((doc) => Product.fromSnapShot(doc)).toList();
    // productListNormal.value = productListAll.where((i) => i.category!.toLowerCase()!.contains("daily")).toList();
    productListNormal.value = productListAll.where((i) => i.category=="normal").toList();
 print(productListNormal);

  }catch(e){
    print(e);
  }
}

Future getDailyProducts(String day)async {
  clearDetailPage();
  try{
    productListDaily.value = productListAll.where((i) => i.day!.toLowerCase()!.contains(day.toLowerCase())).toList();
    productListDailyMain.value = productListDaily.where((i) => i.meal_type!.toLowerCase()!.contains("main")).toList();
    productListDailyProtein.value = productListDaily.where((i) => i.meal_type!.toLowerCase()!.contains("protein")).toList();
    productListDailySide.value = productListDaily.where((i) => i.meal_type!.toLowerCase()!.contains("side")).toList();
 print(productListDaily);
 print(productListDailyMain);
 print(productListDailyProtein);
  }catch(e){
    print(e);
  }
}

Future getBowlsProducts(String bowls)async {
  clearDetailPage();
  try{
    print("bowl: $bowls");
    print("bowl: $productListAll");
    productListBowl.value = productListAll.where((i) => i.meal_type==bowls).toList();
 print( productListDailyMain);
  }catch(e){
    print(e);
  }
}


Future deleteProduct(id)async {

  try{
    return products
        .doc(id)
        .delete()
        .then((value) {
          print("Product Deleted");
          getProducts();
            })
        .catchError((error) => print("Failed to delete product: $error"));

  }catch(e){
    print(e);
  }
}
  final key=GlobalKey<FormState>().obs;

  var nameController=TextEditingController().obs;
  var descriptionController=TextEditingController().obs;
  var priceController=TextEditingController().obs;
  var category="normal".obs;
  var day="monday".obs;
  var foodBowls="food in bowls".obs;
  var meal="main".obs;
  var isLoading=false.obs;

  clear(){
    editImage.value="";
    nameController.value.text="";
    priceController.value.text="";
    descriptionController.value.text="";
    category.value="normal";
    day.value="monday";
    foodBowls.value="food in bowls";
    meal.value="main";
  }

Future addProducts(context,file)async {
  isLoading.value=true;
  String img="";
  if(file!=null){
    img=await uploadImageToStorage("products/image", file);
  }

    await products
        .add({
      'name': nameController.value.text,
      'category': category.value,
      'day':category.value=="normal"? "":day.value,
      'meal_type': category.value=="normal"? foodBowls.value:meal.value,
      'description': descriptionController.value.text,
      'price': priceController.value.text ,
      'image': img
    }).then((value) {
      print("Product Added");
      getProducts();
      Navigator.pop(context);
    }).catchError((error) {
      print("Failed to add product: $error");
    });

  isLoading.value=false;

 }

var editImage ="".obs;
Future updateProducts(context,file,id)async {
  isLoading.value=true;

  String img="";
  if(file!=null){
    img=await uploadImageToStorage("products/image", file);
  }else{
    img=editImage.value;
  }

   await products.doc(id)
        .update({
      'name': nameController.value.text, // John Doe
      'category': category.value, // Stokes and Sons
      'day': day.value, // Stokes and Sons
      'meal_type': meal.value, // Stokes and Sons
      'description': descriptionController.value.text, // Stokes and Sons
      'price': priceController.value.text ,
      'image': img
    }).then((value) {
      print("Product updated");
      getProducts();
      Navigator.pop(context);
    }).catchError((error) {
      print("Failed to add user: $error");
    });

  isLoading.value=false;
 }

  Future<String> uploadImageToStorage(String childName, Uint8List file)async{
    Reference ref=_storage.ref().child(childName);
    UploadTask uploadTask=ref.putData(file);
    TaskSnapshot snapshot=await uploadTask;
    String downloadUrl= await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }



  var selectedMainProduct=Product().obs;
var selectedProteinProduct=[].obs;
var selectedSideProduct=[].obs;
var selectedBowlProduct=[].obs;

  List<Product> sideProduct_List=[];
  List<Product> proteinProduct_List=[];
  List<Product> bowlProduct_List=[];

selectProteinMethod(Product prod){
  // Product  product= productListAll.where((i) => i.id!.toLowerCase()!.contains(id!)).toList().first;
  if(selectedProteinProduct.contains(prod.id!)){
    selectedProteinProduct.remove(prod.id!);
    proteinProduct_List.remove(prod);
  }else{
    selectedProteinProduct.add(prod.id!);
    proteinProduct_List.add(prod);
  }
  calculateTotal();

}

selectSideMethod(Product prod){
  // Product  product= productListAll.where((i) => i.id!.toLowerCase()!.contains(id!)).toList().first;
  if(selectedSideProduct.contains(prod.id!)){
    selectedSideProduct.remove(prod.id);
    sideProduct_List.remove(prod);
  }else{
    selectedSideProduct.add(prod.id);
    sideProduct_List.add(prod);
  }
  calculateTotal();
  }

selectBowlMethod(Product prod){
  if(selectedBowlProduct.contains(prod.id!)){
    selectedBowlProduct.remove(prod.id);
    bowlProduct_List.remove(prod);
  }else{
    selectedBowlProduct.add(prod.id);
    bowlProduct_List.add(prod);
  }
  calculateTotal();
  }


clearDetailPage(){
  productListDailyMain.clear();
  productListDailySide.clear();
  productListBowl.clear();
  productListDailyProtein.clear();
   selectedMainProduct.value=Product();
   selectedProteinProduct.clear();
   selectedSideProduct.clear();
   sideProduct_List.clear();
   proteinProduct_List.clear();
   bowlProduct_List.clear();
   selectedBowlProduct.clear();
   totalPrice.value=0.0;
}

quickAddToCart(Product product){
  List <Product> cartProduct=[];
  cartProduct.add(product);
  cartController.addToCart(cartProduct);
}
addProductToCart(context){



      List <Product> cartProduct=[];
      if(bowlProduct_List.isNotEmpty){
        for(var i=0; i<bowlProduct_List.length; i++){
          cartProduct.add(bowlProduct_List[i]);
        }
      }

      if(selectedMainProduct.value.id!=null)
        {
          cartProduct.add(selectedMainProduct.value);
        }

      if(proteinProduct_List.isNotEmpty){
        for(var i=0; i<proteinProduct_List.length; i++){
          cartProduct.add(proteinProduct_List[i]);
        }
      }

      if(sideProduct_List.isNotEmpty){
        for(var i=0; i<sideProduct_List.length; i++){
          cartProduct.add(sideProduct_List[i]);
        }
      }


      if(cartProduct.isEmpty){
        Dialogs.alertBox(context, "Warning", "Select at least one item", DialogType.warning);
      }else{
        cartController.addToCart(cartProduct);
        Navigator.pop(context);
      }


}



 var totalPrice=0.0.obs;

  calculateTotal(){
    totalPrice.value=0.0;

    if(selectedMainProduct.value.id!=null)
    {
      totalPrice.value=totalPrice.value + selectedMainProduct.value.price!;
    }

    if(proteinProduct_List.isNotEmpty){
      for(var i=0; i<proteinProduct_List.length; i++){
        totalPrice.value=totalPrice.value + proteinProduct_List[i].price!;
      }
    }

    if(sideProduct_List.isNotEmpty){
      for(var i=0; i<sideProduct_List.length; i++){
        totalPrice.value=totalPrice.value + sideProduct_List[i].price!;
      }
    }

    if(bowlProduct_List.isNotEmpty){
      for(var i=0; i<bowlProduct_List.length; i++){
        totalPrice.value=totalPrice.value + bowlProduct_List[i].price!;
      }
    }


  }

}