
import 'dart:typed_data';

import 'package:aponwola/common/SizeConfig.dart';
import 'package:aponwola/common/constant.dart';
import 'package:aponwola/controllers/category.controller.dart';
import 'package:aponwola/controllers/product.controller.dart';
import 'package:aponwola/custom_widget/btn.dart';
import 'package:aponwola/custom_widget/txt.dart';
import 'package:aponwola/data/product.dart';
import 'package:aponwola/util/imagePicker.dart';
import 'package:aponwola/util/utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class AddProductView extends StatefulWidget {
  Product? product;
  AddProductView({Key? key,this.product}) : super(key: key);



  @override
  State<AddProductView> createState() => _AddProductViewState();
}


class _AddProductViewState extends State<AddProductView> {
  final productController=Get.put(ProductController());
  final categoryController=Get.put(CategoryController());
  var avatar="http://www.listercarterhomes.com/wp-content/uploads/2013/11/dummy-image-square.jpg";
  Uint8List?_image;
  selectIImage()async{
    Uint8List img=await ImagePickerHandler.pickImage(ImageSource.gallery);
    setState(() {
      _image=img;
    });
  }


  @override
  void initState() {
    productController.clear();

    initMethod();
    super.initState();
 }

 String? id;
 initMethod()async{
    if(widget.product !=null){
      id=widget.product!.id!;
      productController.nameController.value.text=widget.product!.name!;
      productController.descriptionController .value.text=widget.product!.description!;
      productController.priceController.value.text=widget.product!.price.toString();
      productController.category.value=widget.product!.category!;
      productController.editImage.value=widget.product!.image!;
      productController.category.value=widget.product!.category!;
      productController.day.value=widget.product!.day!;
      productController.meal.value=widget.product!.meal_type!;
    }
 }


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
      ),

      body: GetX<ProductController>(
        builder: (productController) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(10.0),
            child: Form(
              key: productController.key.value,
              child: Column(

                children: [
                  SizedBox(height:MySize.size10),

                InkWell(
                  onTap: ()=>selectIImage(),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child:
                    _image!=null?
                          Image.memory(_image!,
                            fit: BoxFit.cover,
                            height: MySize.size300,)
                        :  CachedNetworkImage(
                      imageUrl: productController.editImage.value!=""?
                      productController.editImage.value:
                      avatar,
                      fit: BoxFit.cover,
                      height: MySize.size300,
                      width: MySize.size300,
                    )
                        //   : Image.network(_image!,
                        // fit: BoxFit.cover,
                        // height: MySize.size300,)

                  ),
                ),
                  SizedBox(height:MySize.size20),



                  MyText(
                    hintText: "Name",
                    controller: productController.nameController.value,
                  ),
                  MyText(
                    hintText: "Price",
                    controller: productController.priceController.value,
                  ),
                  MyText(
                    hintText: "Description",
                    controller: productController.descriptionController.value,
                  ),


                  MyDropDown(
                      hint: "Select category",
                      width: MySize.screenWidth,
                      drop_value: productController.category.value,
                      itemFunction: ["normal","daily"].map((item) {
                        return DropdownMenuItem(
                          value: item,
                          child:  Text(toBeginningOfSentenceCase(item).toString()),
                        );

                      }).toList(),
                      onChanged: (newValue) async {
                        productController.category.value = newValue.toString();
                        categoryController.categoryNormalList!.forEach((element) {
                          print(element.name);
                        });
                      }),
                   productController.category.value=="daily"?
                  MyDropDown(
                      hint: "Select day",
                      width: MySize.screenWidth,
                      drop_value: productController.day.value,
                      itemFunction: categoryController.categoryDailyList.map((item) {
                        return DropdownMenuItem(
                          value: item.name,
                          child:  Text("${toBeginningOfSentenceCase(item.name)}"),
                        );
                      }).toList(),

                      onChanged: (newValue) async {
                        productController.day.value = newValue.toString();


                      }):
                  MyDropDown(
                      hint: "Select type",
                      width: MySize.screenWidth,
                      drop_value: productController.foodBowls.value,
                      itemFunction: categoryController.categoryNormalList.map((item) {
                        return DropdownMenuItem(
                          value: item.name,
                          child:  Text("${toBeginningOfSentenceCase(item.name)}"),
                        );
                      }).toList(),

                      onChanged: (newValue) async {
                        productController.foodBowls.value = newValue.toString();
                      }),

                  if(productController.category.value=="daily")
                    MyDropDown(
                        hint: "Select meal type",
                        width: MySize.screenWidth,
                        drop_value: productController.meal.value,
                        itemFunction: ["main","protein","side"].map((item) {
                          return DropdownMenuItem(
                            value: item,
                            child:  Text("${toBeginningOfSentenceCase(item)}"),
                          );
                        }).toList(),

                        onChanged: (newValue) async {
                          productController.meal.value = newValue.toString();
                        }),

                  SizedBox(height:MySize.size50),
                  productController.isLoading.value?
                      const CupertinoActivityIndicator():
                  MyButton(
                      text: "Save",
                      height: MySize.size50,
                      onPressed: (){
                        if(productController.key.value.currentState!.validate()){
                          if(id==null){
                            productController.addProducts(context,_image);
                          }else{
                            productController.updateProducts(context,_image,id);
                          }
                        }
                      }),
                  SizedBox(height:MySize.size100),
                ],
              ),
            ),
          );
        }
      ),
    );
  }
}

