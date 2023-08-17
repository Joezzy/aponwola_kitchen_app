

import 'package:aponwola/common/SizeConfig.dart';
import 'package:aponwola/common/app_theme.dart';
import 'package:aponwola/controllers/auth.controller.dart';
import 'package:aponwola/custom_widget/btn.dart';
import 'package:aponwola/custom_widget/txt.dart';
import 'package:aponwola/routes/app.routes.dart';
import 'package:aponwola/util/validator.dart';
import 'package:aponwola/view/auth/register.view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class LoginView extends StatefulWidget {
  final  bool atStart;

 const  LoginView({Key? key,this.atStart=true}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {

final  authController=Get.put(AuthController());

 bool showPassword=false;
@override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      // backgroundColor: Colors.white,
      body: GetX<AuthController>(
          builder: (authController) {
          return Stack(
            children: [
              if(widget.atStart)
                Positioned(
                bottom: -350,
                left: -100,
                right:-100,
                child: Container(
                  height: MySize.size600,
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
              if(widget.atStart)
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

              loginFormWidget(context,authController ),
            ],
          );
        }
      ),
    );
  }

  Form loginFormWidget(BuildContext context,AuthController authController) {
    return Form(
          key: authController.loginKey.value,

          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(

              children: [
                if(widget.atStart)
              Column(
                children: [
                  SizedBox(height:MySize.size150),
                  Row(
                    children: [
                      Text("Welcome back",style: TextStyle(fontSize: MySize.size40,fontWeight: FontWeight.bold),),
                    ],
                  ),
                ],
              ),
                Row(
                  children: [
                    Text("Enter you details to login",style: TextStyle(fontSize: MySize.size18),),
                  ],
                ),
                SizedBox(height:MySize.size10),

                MyText(
                  hintText: "Email",
                  controller: authController.emailController.value,
                  validator: Validator.emailValidator,
                ),

                MyText(
                  hintText: "Password",
                  controller: authController.passwordController.value,
                  validator: Validator.passwordValidator,
                  isPasswordField: showPassword,
                  suffixIcon: showPassword
                      ? const Icon(MdiIcons.eyeOutline)
                      : const Icon(MdiIcons.eyeOffOutline),
                  onSuffixItemTapped: () {
                    setState(() {
                      if (!showPassword){
                        showPassword = true;
                      }
                      else{
                        showPassword = false;
                      }
                    });
                  },
                ),
                authController.isLoading.value?
                const  Center(child:   CupertinoActivityIndicator()):
                MyButton(
                  text: "Sign-in",
                    // borderRadius: MySize.size10,
                    onPressed: (){
                      if(authController.loginKey.value.currentState!.validate()){
                      authController.login(context,widget.atStart);
                    }
                }),


                SizedBox(height:MySize.size20),
                GestureDetector(
                  onTap: (){
                    Navigator.of(context).push<void>(MaterialPageRoute(builder: (_) {
                      return RegisterView(
                        atStart: widget.atStart,
                      );
                    }));
                    // Navigator.of(context).pushNamedAndRemoveUntil(AppRoutes.RegisterFromLoginRoute, (Route<dynamic> route) => false);
                  },

                  child: Center(
                    child: RichText(
                      text: const TextSpan(
                          style: TextStyle(color: Colors.black, fontSize: 16),
                          children: [
                            TextSpan(text: "Don't have an account? " ),
                            TextSpan(
                                text: 'Sign-up',
                                style: TextStyle(fontWeight: FontWeight.bold,color: AppTheme.primaryColor)),
                          ]),
                    ),
                  ),
                )



              ],
            ),
          ),
        );
  }
}
