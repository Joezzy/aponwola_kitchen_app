
import 'package:aponwola/common/SizeConfig.dart';
import 'package:aponwola/common/app_theme.dart';
import 'package:aponwola/controllers/auth.controller.dart';
import 'package:aponwola/custom_widget/btn.dart';
import 'package:aponwola/custom_widget/txt.dart';
import 'package:aponwola/routes/app.routes.dart';
import 'package:aponwola/util/validator.dart';
import 'package:aponwola/view/auth/login.view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';

class RegisterView extends StatefulWidget {
 final  bool atStart;
  const  RegisterView({Key? key,this.atStart=true}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final  authController=Get.put(AuthController());


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // authController.getAuth(context);
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar:(!widget.atStart)?
      AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black54),
        elevation: 0,
        centerTitle: true,
        title: const Text("Register",style: TextStyle(color: Colors.black),),
      ):null,
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


              regFormWidget(context,authController),
            ],
          );
        }
      ),
    );
  }

  Form regFormWidget(BuildContext context,AuthController authController) {

        return
          Form(
              key: authController.registerKey.value,
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
                          Text("Enter you details to",style: TextStyle(fontSize: MySize.size18),),
                        ],
                      ),

                      Row(
                        children: [
                          Text("Get started!",style: TextStyle(fontSize: MySize.size40,fontWeight: FontWeight.bold),),
                        ],
                      ),
                    ],
                  ),
                    SizedBox(height:MySize.size30),

                    MyText(
                      hintText: "Full name",
                      controller: authController.nameController.value,
                      validator: Validator.requiredValidator,
                    ),

                    MyText(
                      hintText: "Email",
                      controller: authController.emailController.value,
                      validator: Validator.emailValidator,

                    ),
                    MyText(
                      hintText: "Phone",
                      keyboardType: TextInputType.number,
                      controller: authController.phoneController.value,
                     validator: MinLengthValidator(10, errorText: 'Phone must be at least 10 digits long'),
                    ),
                    MyText(
                      hintText: "Password",
                      controller: authController.passwordController.value,
                      validator: Validator.passwordValidator,

                    ),

                    // SizedBox(height:MySize.size20),
                    authController.isLoading.value?
                    const Center(child:   CupertinoActivityIndicator()):
                    MyButton(
                        text: "Sign-up",
                        onPressed: (){
                          if(authController.registerKey.value.currentState!.validate()){
                            authController.register(context,widget.atStart);
                          }
                        }),

                    GestureDetector(
                      onTap: (){
                        Navigator.of(context).push<void>(MaterialPageRoute(builder: (_) {
                          return LoginView(
                          );
                        }));

                      },
                      child: Center(
                        child: RichText(
                          text: const TextSpan(
                              style: TextStyle(color: Colors.black, fontSize: 16),
                              children: [
                                TextSpan(text: "Already have an account? " ),
                                TextSpan(
                                    text: 'Login',
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
