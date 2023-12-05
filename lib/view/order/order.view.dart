

import 'package:aponwola/common/SizeConfig.dart';
import 'package:aponwola/common/app_theme.dart';
import 'package:aponwola/controllers/auth.controller.dart';
import 'package:aponwola/controllers/order.controller.dart';
import 'package:aponwola/custom_widget/btn.dart';
import 'package:aponwola/custom_widget/txt.dart';
import 'package:aponwola/data/order.dart';
import 'package:aponwola/routes/app.routes.dart';
import 'package:aponwola/view/order/orderDetail.view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class OrderView extends StatefulWidget {
  OrderView({Key? key}) : super(key: key);

  @override
  State<OrderView> createState() => _OrderViewState();
}

class _OrderViewState extends State<OrderView> {

  final  orderController=Get.put(OrderController());
  final  authController=Get.put(AuthController());

  bool showPassword=false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    orderController.getOrders(context);

  }
  @override
  Widget build(BuildContext context) {
    return  GetX<OrderController>(
      builder: (orderController) {
        return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              iconTheme: const IconThemeData(color: Colors.black54),
              elevation: 0,
              centerTitle: true,
              title: const Text("Orders",style: TextStyle(color: Colors.black),),
            ),


            backgroundColor: AppTheme.whiteBackground,
          body: !authController.isLogin.value || orderController.orderList.isEmpty?
              emptyOrderWidget():
          ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: MySize.size23),
            itemCount: orderController.orderList.length,
            itemBuilder: (context,index){
              OrderGroup order=orderController.orderList[index];
              return   Container(
                margin: const EdgeInsets.symmetric(vertical: 8),
                decoration:  BoxDecoration(
                    color: AppTheme.primaryColor.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(15)
                ),
                child: ListTile(
                  title: Text(order.id!),
                  subtitle: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Amount: ${AppTheme.money(order.order!.first!.total!)}"),
                      Text("Quantity: ${order.order!.first!.quantity!}".toString()),
                    ],
                  ),

                  trailing: InkWell(
                      onTap: (){
                        // productController.deleteProduct(product.id!);
                      },
                      child:const  Icon(MdiIcons.close,color: Colors.red,)),
                  onTap: (){
                    Navigator.of(context, rootNavigator: true).push(
                      MaterialPageRoute(
                          builder: (BuildContext context) => OrderDetailView(orderGroup: order)),);
                  },
                ),
              );
            },


          )
        );
      }
    );
  }



  Center emptyOrderWidget() {
    return Center(
      child: Container(
        padding: EdgeInsets.only(bottom: MySize.size200),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/empty_order.jpg",
              height: MySize.size250,),
            const Text("No order found!")
          ],
        ),
      ),
    );
  }

}
