
import 'package:aponwola/common/SizeConfig.dart';
import 'package:aponwola/common/app_theme.dart';
import 'package:aponwola/controllers/auth.controller.dart';
import 'package:aponwola/controllers/order.controller.dart';
import 'package:aponwola/custom_widget/btn.dart';
import 'package:aponwola/custom_widget/txt.dart';
import 'package:aponwola/data/order.dart';
import 'package:aponwola/data/product.dart';
import 'package:aponwola/routes/app.routes.dart';
import 'package:aponwola/view/home/home.view.dart';
import 'package:aponwola/view/order/foodDetail.view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class OrderDetailView extends StatefulWidget {
  OrderDetailView({Key? key,  required this.orderGroup}) : super(key: key);
  final OrderGroup orderGroup;
  @override
  State<OrderDetailView> createState() => _OrderDetailViewState();
}

class _OrderDetailViewState extends State<OrderDetailView> {

  final  orderController=Get.put(OrderController());

  bool showPassword=false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(color: Colors.black54),
          elevation: 0,
          centerTitle: true,
          title: const Text("Order detail",style: TextStyle(color: Colors.black),),
        ),
        backgroundColor: AppTheme.whiteBackground,
        body: ListView(
          padding: EdgeInsets.symmetric(horizontal: MySize.size20),

          children: [
            Column(
              children: [
                const   Header(text:"Food items" ,),
                SizedBox(
                  height: MySize.size90 * widget.orderGroup.order!.length,
                  child: ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    padding:const  EdgeInsets.only(bottom: 500),

                    separatorBuilder: (context, index) {
                      return const Divider();
                    },
                    itemCount: widget.orderGroup.order!.length,
                    itemBuilder: (context,index){
                      OrderData order=widget.orderGroup.order![index];

                      return     Container(
                        decoration: BoxDecoration(
                            color: AppTheme.primaryColor.withOpacity(0.05),
                            borderRadius: BorderRadius.circular(15)
                        ),
                        child: ListTile(

                          title: Text(order!.products!.first.name!),
                          subtitle: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("${AppTheme.money(order.subtotal!)}"),
                              Text("x${order.quantity}"),
                              // Text(" ${toBeginningOfSentenceCase(product.meal_type)}".toString()),
                            ],
                          ),
                          trailing: const Icon(Iconsax.arrow_right_3),
                          onTap: (){
                            Navigator.of(context, rootNavigator: true).push(
                              MaterialPageRoute(
                                  builder: (BuildContext context) => FoodDetailView(order: order)),);
                          },
                        ),
                      );
                    },

                  ),
                ),
                Container(
                  // height: MySize.size90 * widget.order.products!.length,
                  padding: EdgeInsets.symmetric(horizontal: MySize.size20),
                  decoration: BoxDecoration(
                      color: AppTheme.primaryColor.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(15)
                  ),
                  child: Column(
                    children: [
                      list("Name",widget.orderGroup.order!.first!.fullName!),
                      list("Phone",widget.orderGroup.order!.first!.phone!),
                      list("Address","${widget.orderGroup.order!.first!.address!} (${widget.orderGroup.order!.first!.place!})"),
                      list("Total",AppTheme.money(widget.orderGroup.order!.first!.subtotal!)),
                      list("Quantity","x${widget.orderGroup.order!.first!.quantity!}"),
                      list("Delivery fee" ,"${widget.orderGroup.order!.first!.deliveryPrice!}"),
                          list("Delivery date  & time","${widget.orderGroup.order!.first!.deliveryDate!},  ${widget.orderGroup.order!.first!.deliveryTime!} "),
                          list("Date created","${widget.orderGroup.order!.first.date}"),
                    ],
                  ),
                ),




              ],
            ),
          ],
        )
    );
  }

  ListTile list(label,text) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
        title: Text(text),
        subtitle:  Text(label),
      );
  }
}
