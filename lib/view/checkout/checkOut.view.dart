
import 'package:aponwola/common/SizeConfig.dart';
import 'package:aponwola/common/app_theme.dart';
import 'package:aponwola/common/myDialog.dart';
import 'package:aponwola/controllers/cartController.dart';
import 'package:aponwola/custom_widget/addressCard.dart';
import 'package:aponwola/custom_widget/btn.dart';
import 'package:aponwola/data/address.dart';
import 'package:aponwola/view/checkout/addAddress.view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class CheckOutView extends StatefulWidget {
  const CheckOutView({Key? key}) : super(key: key);

  @override
  State<CheckOutView> createState() => _CheckOutViewState();
}

class _CheckOutViewState extends State<CheckOutView> {
  final cartController=Get.put(CartController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cartController.getAddressMethod();
  }

  @override
  Widget build(BuildContext context) {
    cartController.pickedTimeFormat.value = TimeOfDay.now().format(context);
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black54),
        elevation: 0,
      ),

        body: GetX<CartController>(
        builder: (cartController) {
          return cartController.isLoading.value?
             const Center(child: CupertinoActivityIndicator()):
            SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: (
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children:const [
                      Padding(

                        padding: EdgeInsets.all(8.0),
                        child: Text("Select delivery date", textAlign: TextAlign.right,),
                      ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: ()=>cartController.pickDate(context),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              color: AppTheme.primaryColor,
                              width: 1
                            )
                          ),

                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children:  [
                               Text(cartController.selectedDate.value),
                           const   Icon(Iconsax.calendar)

                            ],
                          ),
                        ),
                      ),
                    ),
                   const SizedBox(width: 10,),
                    Expanded(
                      child: GestureDetector(
                        onTap: ()=>cartController.pickTime(context),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              color: AppTheme.primaryColor,
                              width: 1
                            )
                          ),

                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children:  [
                               Text(cartController.pickedTimeFormat.value),
                           const   Icon(Iconsax.clock)

                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),


                (cartController.addressList.isNotEmpty)?
                  newAddressTextButton(context):
                newAddressButton(context),
                if(cartController.addressList.isNotEmpty)
                addressListView(cartController),

                Column(
                  children: [
                    subTotalCard("Total food cost",AppTheme.money(cartController.totalFoodPrice.value)),
                    subTotalCard("Total delivery cost",AppTheme.money(cartController.selectedAddress.value.amount!)),
                   const Divider(thickness: 1,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Total ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: MySize.size20),),
                        Text(AppTheme.money(cartController.totalPriceWithDelivery.value),style:  TextStyle(fontWeight: FontWeight.bold,fontSize: MySize.size20),),
                      ],
                    ),
                    MyButton(
                        text: "Check-out",
                        // borderRadius: MySize.size10,
                        onPressed: (){
                          if(cartController.selectedAddress.value.id==null){
                            Dialogs.alertBox(context, "Warning",
                                "You must enter/select an address to proceeed", DialogType.warning);
                          }else{
                            cartController.checkOut(context);

                          }
                        }),

                  ],

                )
              ],

            )
            ),
          );
        }
      ),
    );
  }

  Row subTotalCard(String title, String value) {
  const   TextStyle stl=TextStyle(fontWeight: FontWeight.bold);
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(title,style: stl ),
                      Text(value,style: stl),
                    ],
                  );
  }

  SizedBox addressListView(CartController cartController) {
    return SizedBox(
                height: MySize.size300,
                child: ListView.builder(
                  physics:const  NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.zero,
                  itemCount: cartController.addressList.length,
                  itemBuilder: (context,index){
                    Address address=cartController.addressList[index];
                    return  AddressCard(
                      address: address,
                      selectedAddressId:cartController.selectedAddress.value.id ,
                      onTap: (){
                        cartController.selectAddress(address);
                      setState(() {});
                      },
                    );
                    },

                ),
              );
  }

  InkWell newAddressButton(BuildContext context) {
    return InkWell(
                onTap:()async{
                  var page=await  Navigator.of(context, rootNavigator: true).push(
                      MaterialPageRoute(
                          builder: (BuildContext context) =>const AddAddressView()));
                  // cartController.checkOut();
                  if(page==null)setState(() {});
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Container(
                    margin: const EdgeInsets.only(top:10.0),
                    decoration: BoxDecoration(
                        color: AppTheme.primaryColor!,
                        borderRadius: BorderRadius.circular(15)
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                            top:40,
                            right: 20,
                            child:  Container(
                              height: MySize.size150,
                              width: MySize.size150,
                              decoration:  BoxDecoration(
                                  color: Colors.white.withOpacity(1),
                                  borderRadius:  BorderRadius.circular(100)
                              ),
                            )),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Enter new address",
                                // overflow: TextOverflow.ellipsis,
                                style:  TextStyle(color: Colors.white),),
                              Icon(Iconsax.add,size: MySize.size30,color: Colors.white,)

                            ],
                          ),
                        ),

                      ],
                    ),
                  ),
                ),
              );
  }

  InkWell newAddressTextButton(BuildContext context) {
    return InkWell(
      onTap:()async{
        var page=await  Navigator.of(context, rootNavigator: true).push(
            MaterialPageRoute(
                builder: (BuildContext context) =>const AddAddressView()));
        // cartController.checkOut();
        if(page==null)setState(() {});
      },
      child: Container(
        // padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
          const Text("Enter new address",),
        Icon(Iconsax.add,size: MySize.size30)

        ],
      ),
    ),
    );
  }

}
