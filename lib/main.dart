import 'package:aponwola/firebase_options.dart';
import 'package:aponwola/routes/app.routes.dart';
import 'package:aponwola/testiing.dart';
import 'package:aponwola/view/home/home.view.dart';
import 'package:aponwola/view/splashScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.black.withOpacity(0.01),
      statusBarColor: Colors.transparent,
    ));
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Aponwola',
      theme: ThemeData(
        primarySwatch:Colors.red,
        fontFamily: 'Montserrat',
      ),
      // home: const OpenContainerTransformDemo(),
      initialRoute: AppRoutes.SplashRoute,
      routes: AppRoutes.routes,
    );
  }

}

