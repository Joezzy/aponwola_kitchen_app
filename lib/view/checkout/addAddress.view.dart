

import 'package:aponwola/common/SizeConfig.dart';
import 'package:aponwola/controllers/cartController.dart';
import 'package:aponwola/custom_widget/btn.dart';
import 'package:aponwola/custom_widget/txt.dart';
import 'package:aponwola/routes/app.routes.dart';
import 'package:aponwola/util/validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AddAddressView extends StatefulWidget {
  const AddAddressView({Key? key}) : super(key: key);

  @override
  State<AddAddressView> createState() => _AddAddressViewState();
}


class _AddAddressViewState extends State<AddAddressView> {
final cartController=Get.put(CartController());
  bool safeAddress=false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cartController.selectedPlace.value="";
    cartController.getDeliveryCostMethod();
    // cartController.getAddressMethod();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black54),
        elevation: 0,
        title:const Text("Enter address", style: TextStyle(color: Colors.black),),
      ),
      // backgroundColor: Colors.white,
      body: Stack(
        children: [
          AddressFormWidget(context),
        ],
      ),
    );
  }

  GetX AddressFormWidget(BuildContext context) {
    return GetX<CartController>(
      builder: (cartController) {
        return Form(
          key: cartController.addressKey.value,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(

              children: [

                SizedBox(height:MySize.size10),



                if(cartController.selectedPlace.value!="")
                  MyDropDown(
                      hint: "Select type",
                      width: MySize.screenWidth,
                      drop_value: cartController.selectedPlace.value,
                      itemFunction: cartController.placesList.map((item) {
                        return DropdownMenuItem(
                          value: item.id,
                          child:  Text("${toBeginningOfSentenceCase(item.place)} - ${item.amount}"),
                        );
                      }).toList(),

                      onChanged: (newValue) async {
                        cartController.selectPlace(newValue!);
                      }),

                MyText(
                  hintText: "Actual address",
                  controller: cartController.addressController.value,
                  validator: Validator.requiredValidator,
                  maxLine: 3,
                ),

                MyButton(
                    text: "Add",
                    // borderRadius: MySize.size10,
                    onPressed: (){
                      if(cartController.addressKey.value.currentState!.validate()){
                          cartController.addAddressMethod(context);
                      }

                    }),

                SizedBox(height:MySize.size20),

              ],
            ),
          ),
        );
      }
    );
  }}
