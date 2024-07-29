import 'dart:developer';
import 'dart:io';

import 'package:aponwola/common/constant.dart';
import 'package:aponwola/common/myDialog.dart';
import 'package:aponwola/data/CurrentUser.dart';
import 'package:aponwola/routes/app.routes.dart';
import 'package:aponwola/services/api.service.dart';
import 'package:aponwola/util/authHandler.dart';
import 'package:aponwola/view/auth/login.view.dart';
import 'package:aponwola/view/dashboad/dashboard.dart';
import 'package:aponwola/view/home/home.view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController{

  final loginKey=GlobalKey<FormState>().obs;
  final registerKey=GlobalKey<FormState>().obs;
  FirebaseAuth auth = FirebaseAuth.instance;
  var nameController=TextEditingController().obs;
  var emailController=TextEditingController().obs;
  var passwordController=TextEditingController().obs;
  var phoneController=TextEditingController().obs;
  var isLoading=true.obs;
 var avatar="".obs;
 var isLogin=false.obs;
 late  Rx<Uint8List> image;

  login(context, atStart)async{
   isLoading.value=true;
   try {

     UserCredential userCredential = await auth.signInWithEmailAndPassword(
         email: emailController.value.text,
         password: passwordController.value.text
     );


     if(atStart){
       Navigator.pushReplacement(
           context,
           MaterialPageRoute(builder: (_) => DashboardScreen()));
     }else{
      final userInfo = await ApiService.getSelfInfo();
      if(userInfo!=null){
        isLogin.value=true;
        ApiService.me=userInfo;
        Navigator.pop(context);
      }
      else{
        Dialogs.alertBox(context, "Unsuccessful", "This account is not available", DialogType.error);
      }

     }
     // isLogin.value=false;

     isLoading.value=false;
   }  on FirebaseAuthException catch (e) {
     isLoading.value=false;
     isLogin.value=false;

     String message=   AuthExceptionHandler.handleAuthException(e);
     Dialogs.alertBox(context, "Unsuccessful", message, DialogType.error);
   }
 }


  // login2(context)async{
  //   try {
  //     auth.signInWithEmailAndPassword(
  //         email: emailController.value.text,
  //         password: passwordController.value.text
  //     ).then((user) async {
  //       if (user != null) {
  //         log('\nUser: ${user.user}');
  //         log('\nUserAdditionalInfo: ${user.additionalUserInfo}');
  //         if ((await ApiService.userExists())) {
  //           Navigator.pushReplacement(
  //               context, MaterialPageRoute(builder: (_) =>  HomeView()));
  //         } else {
  //
  //           print("Failedd");
  //         }
  //       }
  //     });
  //
  //   } on FirebaseAuthException catch (e) {
  //     if (e.code == 'user-not-found') {
  //       print('No user found for that email.');
  //     } else if (e.code == 'wrong-password') {
  //       print('Wrong password provided for that user.');
  //     }
  //   }
  // }

 // register2(context)async{
 //   try {
 //     UserCredential userCredential = await auth.createUserWithEmailAndPassword(
 //         email: emailController.value.text,
 //         password: passwordController.value.text
 //     );
 //     print("SUCCESS_REG");
 //   } on FirebaseAuthException catch (e) {
 //     if (e.code == 'weak-password') {
 //       print('The password provided is too weak.');
 //     } else if (e.code == 'email-already-in-use') {
 //       print('The account already exists for that email.');
 //     }
 //   } catch (e) {
 //     print(e);
 //   }
 // }


  register(context,atStart)async {
    isLoading.value=true;

    var image = "";
    try {
      await auth.createUserWithEmailAndPassword(
          email: emailController.value.text,
          password: passwordController.value.text
      ).then((user) async {
        // Navigator.pop(context);
        if (user != null) {
          await ApiService.createUser(
              emailController.value.text,
              nameController.value.text
          ).then((value) async{
            isLogin.value=true;
            if(atStart){
              ApiService.me = await ApiService.getSelfInfo();
              Navigator.pop(context);
            }else{
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => DashboardScreen()));
            }
          });
        }
      });
      isLoading.value=false;

      print("SUCCESS_REG");
    } on FirebaseAuthException catch (e) {

      isLoading.value=false;
   String message=   AuthExceptionHandler.handleAuthException(e);
      Dialogs.alertBox(
          context, "Unsuccessful", message,
          DialogType.error);
    } catch (e) {
      isLoading.value=false;
      Dialogs.alertBox(context, "Unsuccessful", e.toString(), DialogType.error);
    }
  }

  updateProfile(context,img)async {
    isLoading.value=true;
    var image = "";
    if(img!=null){
      await ApiService.updateProfilePicture(img);
    }

    try {
      await ApiService.updateUserInfo(
          nameController.value.text,
        phoneController.value.text,
      ).then((value)async {
        ApiService.me = await ApiService.getSelfInfo();
        loadProfile();
        Dialogs.alertBox(
            context, "Successful", "Profile updated",
            DialogType.success);
      });
      isLoading.value=false;
      print("SUCCESS_REG");
    } on FirebaseAuthException catch (e) {
      isLoading.value=false;
   String message=   AuthExceptionHandler.handleAuthException(e);
      Dialogs.alertBox(
          context, "Unsuccessful", message,
          DialogType.error);
    } catch (e) {
      isLoading.value=false;
      Dialogs.alertBox(context, "Unsuccessful", e.toString(), DialogType.error);
    }
  }

  getAuth(context,bool isStart)async{
    isLoading.value=true;
   try {
     auth.authStateChanges()
         .listen((User? user) async {
       if (user != null) {
         print('User is signed in!');
         print(user);
         print("isStart: $isStart");
         final userInfo = await ApiService.getSelfInfo();
         print("userInfo= $userInfo");
         if(userInfo!=null) {
           ApiService.me = userInfo;
           print("USER_DETAIl");
           print(ApiService.me.email);
           print(ApiService.me.name);
           print(ApiService.me.id);
           isLogin.value = true;

         }
         Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
             MaterialPageRoute(
                 builder: (BuildContext context) => const LoginView()),
                 (Route<dynamic> route) => false);


       }else{
         if(isStart) {
           Navigator.of(context).pushAndRemoveUntil(
               MaterialPageRoute(
                   builder: (BuildContext context) => const LoginView()),
                   (Route<dynamic> route) => false);
         }else{
           Navigator.of(context).pushAndRemoveUntil(
               MaterialPageRoute(
                   builder: (BuildContext context) =>  DashboardScreen()),
                   (Route<dynamic> route) => false);
         }
       }
     });

     isLoading.value=false;
   }on FirebaseAuthException catch (e) {
     isLoading.value=false;
     String message=   AuthExceptionHandler.handleAuthException(e);
     // Dialogs.alertBox(
     //     context, "Unsuccessful", message,
     //     DialogType.error);
   } catch(e){
     isLoading.value=false;
    }
 }


 loadProfile()async{
   print("PRO_FILE");
    nameController.value.text=ApiService.me.name??"";
    phoneController.value.text=ApiService.me.phone??"";
    avatar.value=ApiService.me.image??"";
 }


 logout(context)async{
   isLoading.value=true;
   await  auth.signOut();
   isLogin.value=false;
   getAuth(context, false);

   // Navigator.of(context).pushAndRemoveUntil(
   //     MaterialPageRoute(
   //         builder: (BuildContext context) =>  DashboardScreen()),
   //         (Route<dynamic> route) => false);

   isLoading.value=false;
 }


  deleteAccount2(context)async {
    isLoading.value=true;
    try {
      await ApiService.updateUserInfo(
        nameController.value.text,
        phoneController.value.text,
      ).then((value)async {
        ApiService.me = await ApiService.getSelfInfo();
        loadProfile();
        Dialogs.alertBox(
            context, "Successful", "Profile updated",
            DialogType.success);
      });
      isLoading.value=false;
      print("SUCCESS_REG");
    } on FirebaseAuthException catch (e) {
      isLoading.value=false;
      String message=   AuthExceptionHandler.handleAuthException(e);
      Dialogs.alertBox(
          context, "Unsuccessful", message,
          DialogType.error);
    } catch (e) {
      isLoading.value=false;
      Dialogs.alertBox(context, "Unsuccessful", e.toString(), DialogType.error);
    }
  }


  Future deleteAccount(context)async {
    isLogin.value=true;

    ApiService.me = await ApiService.getSelfInfo();

    print(ApiService.me!.id!);

    try{
      return FirebaseFirestore.instance.collection('users')
          .doc(ApiService.me!.id!)
          .delete()
          .then((value) async{
        print("Account Deleted");
        await  auth.signOut();
        isLogin.value=false;
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (BuildContext context) =>  DashboardScreen()),
                (Route<dynamic> route) => false);
        Dialogs.alertBox(context, "Aponwola", "Account Deleted", DialogType.success);
          })
          .catchError((error) => print("Failed to delete category: $error"));

          }catch(e){
            print(e);
          }
    }

 }