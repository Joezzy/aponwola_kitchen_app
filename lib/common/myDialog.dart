import 'package:flutter/material.dart';
import 'package:aponwola/common/SizeConfig.dart';
import 'package:aponwola/common/app_theme.dart';


enum DialogAction { yes, abort }
enum DialogType { success, warning, error, confirm,info }

class Dialogs {


  static Future<DialogAction> alertBox(
      BuildContext context,
      String title,
      String body,
      DialogType type,
      ) async {
    final action = await showDialog(
        context: context,
        // barrierDismissible: false,
        builder: (BuildContext context) {
          return  Dialog(
            child: Container(
                height: MySize.size250,
                width: MySize.size200,

                padding: EdgeInsets.all(MySize.size20),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                        type==DialogType.success?
                        "assets/check.png":
                            "assets/info.png",
                      height: MySize.size80,
                      width: MySize.size80,
                    ),
                    SizedBox(height: MySize.size10,),

                    Text(title, style: TextStyle(fontSize: MySize.size16,fontWeight: FontWeight.w500),),
                    SizedBox(height: MySize.size10,),
                    Text(body, textAlign: TextAlign.center, style: TextStyle(fontSize: MySize.size13)),
                    SizedBox(height: MySize.size30,),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        InkWell(
                          onTap: () => Navigator.of(context).pop(DialogAction.yes),
                          child:  Container(
                            width: MySize.size100,
                            padding: EdgeInsets.all(MySize.size10),
                            decoration: BoxDecoration(
                              color: AppTheme.primaryColor,
                              borderRadius: BorderRadius.circular(6)

                            ),

                            child: Text(
                              'Ok',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                )),
          );
        });
    return (action != null) ? action : DialogAction.abort;
  }

  static Future<DialogAction> alertBoxWithFunction(
      BuildContext context,
      String title,
      String body,
      String buttonText,
      DialogType type,
      ) async {
    final action = await showDialog(
        context: context,
        // barrierDismissible: false,
        builder: (BuildContext context) {
          return  Dialog(
            child: Container(
                height: MySize.size270,
                width: MySize.size200,

                padding: EdgeInsets.all(MySize.size20),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                        type==DialogType.success?
                        "assets/check.png":
                            "assets/info.png",
                      fit: BoxFit.cover,
                      height: MySize.size80,
                      width: MySize.size80,
                    ),
                    SizedBox(height: MySize.size10,),

                    Text(title, style: TextStyle(fontSize: MySize.size16,fontWeight: FontWeight.w500),),
                    SizedBox(height: MySize.size10,),
                    Text(body, textAlign: TextAlign.center, style: TextStyle(fontSize: MySize.size13)),
                    SizedBox(height: MySize.size30,),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        InkWell(
                          onTap: () => Navigator.of(context).pop(DialogAction.yes),
                          child:  Container(
                            width: MySize.size200,
                            padding: EdgeInsets.all(MySize.size10),
                            decoration: BoxDecoration(
                              color: AppTheme.primaryColor,
                              borderRadius: BorderRadius.circular(6)
                            ),

                            child: Text(
                                 buttonText,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                fontSize: 12
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                )),
          );
        });
    return (action != null) ? action : DialogAction.abort;
  }


  static Future<DialogAction> yesAbortDialog(
      BuildContext context,
      String title,
      String body,
      ) async {
    final action = await showDialog(
        context: context,
        // barrierDismissible: false,
        builder: (BuildContext context) {
          return  Dialog(
            child: Container(
                height: MySize.size250,
                width: MySize.size300,

                padding: EdgeInsets.all(MySize.size20),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      "assets/info.png",
                      height: MySize.size60,
                      width: MySize.size60,
                    ),

                    SizedBox(height: MySize.size10,),
                    Text(title,style: TextStyle(fontSize: MySize.size16,fontWeight: FontWeight.bold),),
                    SizedBox(height: MySize.size10,),
                    Text(body,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: MySize.size10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          onTap: () => Navigator.of(context).pop(DialogAction.abort),
                          child: Container(
                            padding: EdgeInsets.all(MySize.size10),
                            color: Colors.redAccent,
                            width: MySize.size100,
                            child:  Text('Cancel',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                        ),

                        InkWell(
                          onTap: () => Navigator.of(context).pop(DialogAction.yes),
                          child:  Container(
                            width: MySize.size100,
                            padding: EdgeInsets.all(MySize.size10),
                            color: AppTheme.primaryColor,

                            child: Text(
                              'Yes',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                )),
          );
        });
    return (action != null) ? action : DialogAction.abort;
  }


  static Future<DialogAction> infoAlert(
      BuildContext context,
      String? image,
      String? title,
      String body,
      DialogType? type,
      ) async {
    final action = await showDialog(
        context: context,
        // barrierDismissible: false,
        builder: (BuildContext context) {
          return  Dialog(
            child: Container(
                height: MySize.size350,
                width: MySize.size200,

                padding: EdgeInsets.all(MySize.size20),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      "assets/touch.jpg",
                      height: MySize.size100,
                      width: MySize.size100,
                    ),
                    SizedBox(height: MySize.size10,),

                    // Text(title!,style: TextStyle(fontSize: MySize.size16,fontWeight: FontWeight.bold),),
                    SizedBox(height: MySize.size20,),
                    Text(body,
                    textAlign: TextAlign.center,),
                    SizedBox(height: MySize.size30,),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        InkWell(
                          onTap: () => Navigator.of(context).pop(DialogAction.yes),
                          child:  Container(
                            width: MySize.size100,
                            padding: EdgeInsets.all(MySize.size10),
                            color: AppTheme.primaryColor,

                            child: Text(
                              'Ok',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                )),
          );
        });
    return (action != null) ? action : DialogAction.abort;
  }







}
