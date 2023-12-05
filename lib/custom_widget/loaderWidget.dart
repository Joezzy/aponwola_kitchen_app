import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:aponwola/common/SizeConfig.dart';

class LoaderWidget extends StatefulWidget {
  final int seconds;

  const LoaderWidget({this.seconds = 3});

  @override
  _SizeWidgetState createState() => _SizeWidgetState();
}

class _SizeWidgetState extends State<LoaderWidget> {
  bool reverse = false;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MySize.size100,
        height: MySize.size100,
        child: Column(
          children: [
            // Image.asset(
            //   "assets/logo.png",
            //   width: MySize.size50,
            //   height: MySize.size50,
            // ),
           const  CupertinoActivityIndicator(),
            Text("Loading...")
          ],
        ));
  }
}
