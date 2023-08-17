

import 'package:aponwola/common/SizeConfig.dart';
import 'package:aponwola/common/app_theme.dart';
import 'package:aponwola/controllers/auth.controller.dart';
import 'package:aponwola/custom_widget/btn.dart';
import 'package:aponwola/custom_widget/txt.dart';
import 'package:aponwola/routes/app.routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class WelcomeView extends StatefulWidget {
  WelcomeView({Key? key}) : super(key: key);

  @override
  State<WelcomeView> createState() => _WelcomeViewState();
}

class _WelcomeViewState extends State<WelcomeView> {

  final  authController=Get.put(AuthController());

  bool showPassword=false;
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  GetX<AuthController>(
        builder: (authController) {
        return Scaffold(
          // backgroundColor: Colors.white,
          body: authController.isLoading.value?
          const  Center(child:   CupertinoActivityIndicator()): Stack(
            children: [
              Positioned(
                bottom: -500,
                left: -300,
                right:-300,
                child: Container(
                  height: MySize.screenHeight,
                  width: MySize.size200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(MySize.size100),
                    image:const  DecorationImage(
                      image: AssetImage(
                          'assets/foodie.png'),
                      fit: BoxFit.fill,
                    ),


                  ),

                ),
              ),
              Positioned(
                top: 50,
                right:10,
                child: TextButton(
                  onPressed: (){
                    Navigator.of(context).pushNamedAndRemoveUntil(AppRoutes.DashRoute, (Route<dynamic> route) => false);
                  },
                child:const  Text("Skip",style: TextStyle(fontWeight: FontWeight.bold),),
                ),
              ),

              Form(
                key: authController.loginKey.value,

                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Image.asset("assets/apon.png",
                        width: MySize.size300,
                      ),
                      SizedBox(height:MySize.size250),

                      MyButton(
                          text: "Login",
                          // borderRadius: MySize.size10,
                          onPressed: (){
                            Navigator.of(context)
                                .pushNamedAndRemoveUntil(AppRoutes.LoginRoute, (Route<dynamic> route) => false);

                          }),

                      MyButton(
                          text: "Register",
                          enabledColor: Colors.white,
                          fontColor: AppTheme.primaryColor,
                          borderColor: AppTheme.primaryColor,
                          // borderRadius: MySize.size10,
                          onPressed: (){
                            Navigator.of(context).pushNamedAndRemoveUntil(AppRoutes.RegisterRoute, (Route<dynamic> route) => false);
                          }),


                      SizedBox(height:MySize.size50),


                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }
    );
  }
}
