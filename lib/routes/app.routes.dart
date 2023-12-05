
import 'package:aponwola/view/auth/login.view.dart';
import 'package:aponwola/view/auth/register.view.dart';
import 'package:aponwola/view/auth/welcome.view.dart';
import 'package:aponwola/view/cart/cart.view.dart';
import 'package:aponwola/view/category/categoryList.view.dart';
import 'package:aponwola/view/dashboad/dashboard.dart';
import 'package:aponwola/view/home/home.view.dart';
import 'package:aponwola/view/product/productList/productList.view.dart';
import 'package:aponwola/view/splashScreen.dart';

class AppRoutes{
  static const String LoginRoute="/login";
  static const String SplashRoute="/";
  static const String RegisterRoute="/register";
  static const String RegisterFromLoginRoute="/login/register";
  static const String CartRoute="/cart";
  static const String HomeRoute="/home";
  static const String DashRoute="/dashboard";
  static const String ProductListViewRoute="/login/ProductList";
  static const String CategoryListRoute="/category";
  static const String WelcomeRoute="/welcome";

  static final routes={
    SplashRoute:(context)=>SplashScreen(),
    WelcomeRoute:(context)=>WelcomeView(),
    LoginRoute:(context)=>LoginView(),
    RegisterRoute:(context)=>RegisterView(),
    RegisterFromLoginRoute:(context)=>RegisterView(),
    CartRoute:(context)=>const CartView(),
    HomeRoute:(context)=> HomeView(),
    DashRoute:(context)=> DashboardScreen(),
    ProductListViewRoute:(context)=>ProductListView(),
    CategoryListRoute:(context)=>CategoryListView(),
  };
}