
import 'package:aponwola/common/SizeConfig.dart';
import 'package:aponwola/common/app_theme.dart';
import 'package:aponwola/controllers/cartController.dart';
import 'package:aponwola/custom_widget/btn.dart';
import 'package:aponwola/routes/app.routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class SuccessView extends StatefulWidget {
  const SuccessView({Key? key}) : super(key: key);

  @override
  State<SuccessView> createState() => _SuccessViewState();
}


class _SuccessViewState extends State<SuccessView> {

  final cartController=Get.put(CartController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const   SizedBox(height: 50,),

            Image.asset("assets/save.png",
            height: MySize.size170,
            ),
         const   SizedBox(height: 20,),

           Container(
             padding: EdgeInsets.symmetric(horizontal: MySize.size30),
               child:   Text("Order placed successfully!",
               textAlign: TextAlign.center,
               style: TextStyle(fontSize: MySize.size24),)),
            const   SizedBox(height: 20,),

           bodyText("kindly pay to the account number below to confirm your order."),
            const   SizedBox(height: 20,),

            bodyText("Account no.: 9087342211"),
           bodyText("Account name.: Aponwola kitchen"),
           bodyText("Bank name : Vbank"),

            const   SizedBox(height: 230,),


            InkWell(
              onTap: ()async{
                var whatsappUrl = "whatsapp://send?phone=2349083669369&text=Hi Aponwola";
                try {
                  launchUrl(Uri.parse(whatsappUrl));
                } catch (e) {
                  print(e);
                }
              },

              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 15),
                decoration: BoxDecoration(
                  color: Colors.greenAccent,
                  borderRadius: BorderRadius.circular(15)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const  Text("Message vendor on Whatsapp"),
                     Image.asset("assets/whatsapp.png",
                     height: 30,) ,
                  ],
                ),
              ),
            ),
            const   SizedBox(height: 20,),
            MyButton(
                text: "Continue",
                onPressed: (){
                  Navigator.pop(context);
                  Navigator.pop(context);
                  // Navigator.pop(context);
                  // Navigator.of(context);
                  //     .pushNamedAndRemoveUntil(AppRoutes.DashRoute, (Route<dynamic> route) => false);

                }),




          ],
        ),
      ),
    );
  }


  Container bodyText(String text) {
    return Container(
           padding: EdgeInsets.symmetric(horizontal: MySize.size40),
             child:   Text(text,
             textAlign: TextAlign.center,
             style: TextStyle(fontSize: MySize.size16),));
  }
}
