import 'package:animations/animations.dart';
import 'package:aponwola/common/SizeConfig.dart';
import 'package:aponwola/common/app_theme.dart';
import 'package:aponwola/common/myDialog.dart';
import 'package:aponwola/controllers/auth.controller.dart';
import 'package:aponwola/controllers/cartController.dart';
import 'package:aponwola/controllers/product.controller.dart';
import 'package:aponwola/custom_widget/btn.dart';
import 'package:aponwola/custom_widget/mainProductCard.dart';
import 'package:aponwola/custom_widget/productCard.dart';
import 'package:aponwola/data/cart.dart';
import 'package:aponwola/data/category.dart';
import 'package:aponwola/data/product.dart';
import 'package:aponwola/view/auth/login.view.dart';
import 'package:aponwola/view/checkout/checkOut.view.dart';
import 'package:aponwola/view/home/home.view.dart';
import 'package:aponwola/view/profile/profile.view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartView extends StatefulWidget {
  const CartView({Key? key}) : super(key: key);

  @override
  _CartViewState createState() => _CartViewState();
}

class _CartViewState extends State<CartView> with SingleTickerProviderStateMixin{
  final cartController=Get.put(CartController());
  final  authController=Get.put(AuthController());



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initMethod();
  }

  initMethod(){

  }
  @override
  Widget build(BuildContext context) {
    return GetX<CartController>(
        builder: (cartController) {
        return Scaffold(
          backgroundColor: AppTheme.whiteBackground,
          appBar: AppBar(
            backgroundColor: Colors.white,
            iconTheme: const IconThemeData(color: Colors.black54),
            elevation: 0,
            centerTitle: true,
            title: const Text("Cart",style: TextStyle(color: Colors.black),),
          ),
          body:cartController.cartModelList.isEmpty?
                 emptyCartWidget():
                 cartListWidget(cartController),

          bottomNavigationBar: cartController.cartModelList.isNotEmpty?
          checkOutButton(cartController):null,
        );
      }
    );
  }

  Container checkOutButton(CartController cartController) {
    return Container(
          height: MySize.size110,
          padding: const EdgeInsets.all(20),
          child:  GetX<AuthController>(
            builder: (authController) {
              return InkWell(
                onTap: ()async{
                  if(authController.isLogin.value){
                    Navigator.of(context, rootNavigator: true).push(
                        MaterialPageRoute(
                            builder: (BuildContext context) =>const CheckOutView()));

                  }else{

                DialogAction action=   await Dialogs.yesAbortDialog(context, "Login/Signup",
                    "You need to login/create an account to continue.\n Do you want  to create an account or login now?");

                    if(action==DialogAction.yes){
                      Navigator.of(context, rootNavigator: true).push(
                          MaterialPageRoute(
                              builder: (BuildContext context) => ProfileView()));
                    }

                  }


                },
                child: Container(
                  decoration: BoxDecoration(
                      color: AppTheme.primaryColor,
                      borderRadius: BorderRadius.circular(20)
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:  [
                    const   Text("Checkout",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                      Text("${AppTheme.money(cartController.totalFoodPrice.value)}",style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                    ],
                  ),
                ),
              );
            }
          ),
        );
  }


  ListView cartListWidget(CartController cartController) {
    return ListView(
                padding: const EdgeInsets.all(10),
                children: <Widget>[

                  ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: cartController.cartModelList.length,
                      itemBuilder: (context, index) {
                      CartModel cartModel= cartController.cartModelList[index];
                        // List<Product> productList= cartController.cartModelList[index];

                        return Stack(
                          children: [
                            Container(
                              padding: EdgeInsets.all( MySize.size20),
                              margin: EdgeInsets.symmetric(vertical: MySize.size10,horizontal:  MySize.size10),
                              decoration: BoxDecoration(
                                color: AppTheme.primaryColor.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Column(
                                children: [

                                  ListView.builder(
                                      physics: const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount:cartModel.productList!.length,
                                      itemBuilder: (context, index) {
                                        Product product= cartModel.productList![index];

                                        return Column(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.symmetric(vertical: 2.0),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                 Row(
                                                   children: [
                                                     // ClipRRect(
                                                     //   borderRadius:  BorderRadius.circular(10),
                                                     //   child: CachedNetworkImage(
                                                     //     imageUrl:  product.image!,
                                                     //     height: MySize.size30,
                                                     //     width: MySize.size30,
                                                     //     fit: BoxFit.cover,
                                                     //   ),
                                                     // ),
                                                     Container(
                                                         width: MySize.size200,
                                                         padding: EdgeInsets.symmetric(horizontal: MySize.size10),
                                                         child: Text("* ${product.name}\n",
                                                           style: TextStyle(fontWeight: FontWeight.w400,fontSize: MySize.size12),)),
                                                   ],
                                                 ),
                                                  Text("${AppTheme.money(product.price!)}")
                                                ],
                                              ),
                                            ),

                                            // if(product.meal_type!="main")
                                            // Container(
                                            //   padding: EdgeInsets.only(left: MySize.size50),
                                            //   child: Row(
                                            //     children: [
                                            //      Container(
                                            //          width: MySize.size230,
                                            //          padding: EdgeInsets.symmetric(horizontal: MySize.size10),
                                            //          child: Text("${product.name}")),
                                            //       Text("${product.price}")
                                            //     ],
                                            //   ),
                                            // ),

                                          ],
                                        );

                                      }),

                                  const Divider(thickness: 1,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          ChipWidget(
                                              child: const  Icon(Icons.remove,color:AppTheme.primaryColor,),
                                              onTap: (){
                                                cartController.decreaseItem(cartModel);

                                              }) ,
                                          Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Text("${cartModel.quantity}"),
                                            // child: Text("${cartController.cartModelList.where((proList) => proList==cartModel).toList().length}"),
                                          ),

                                          ChipWidget(
                                              child: const  Icon(Icons.add,color: AppTheme.primaryColor,),
                                              onTap: (){
                                                cartController.increaseItem(cartModel);
                                              }) ,
                                        ],
                                      ),

                                      Text(AppTheme.money(cartModel.subTotal!),style: const TextStyle(fontWeight: FontWeight.w600),),

                                    ],
                                  ),

                                ],
                              ),
                            ),

                            Positioned(
                              right: 15,
                                top:15,
                                child: ChipWidget(
                                    child: const  Icon(Icons.close,color: AppTheme.primaryColor,),
                                    onTap: (){
                                      cartController.removeItem(cartModel!);
                                    })
                            )
                          ],
                        );

                      }),

                ],
              );
  }

  Center emptyCartWidget() {
    return Center(
          child: Container(
            padding: EdgeInsets.only(bottom: MySize.size200),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/empty_cart.png",
                height: MySize.size250,),
                const Text("Empty cart!")
              ],
            ),
          ),
        );
  }


}


class ChipWidget extends StatelessWidget {
  final Widget child;
  final VoidCallback onTap;
  const ChipWidget({Key? key,
   required this.child,
  required  this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30)
          ),
          child: child),
    );
  }
}
