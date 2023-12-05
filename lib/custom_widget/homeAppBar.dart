

import 'package:aponwola/common/SizeConfig.dart';
import 'package:aponwola/common/app_theme.dart';
import 'package:aponwola/controllers/auth.controller.dart';
import 'package:aponwola/controllers/cartController.dart';
import 'package:aponwola/controllers/product.controller.dart';
import 'package:aponwola/custom_widget/mainProductCard.dart';
import 'package:aponwola/data/product.dart';
import 'package:aponwola/services/api.service.dart';
import 'package:aponwola/view/cart/cart.view.dart';
import 'package:aponwola/view/dashboad/dashboard.dart';
import 'package:aponwola/view/profile/profile.view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class HomeAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onTapLeadingIcon;

  HomeAppBar({Key? key,
    this.title = "",
    this.onTapLeadingIcon
  })
      : preferredSize = const Size.fromHeight(kToolbarHeight);

  @override
  final Size preferredSize;

  @override
  State<HomeAppBar> createState() => _HomeAppBarState();
}


class _HomeAppBarState extends State<HomeAppBar> {
  // final cartController=Get.put(CartController());
  final authController=Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return  PreferredSize(
      preferredSize: const Size.fromHeight(50),
      // here the desired height

      child: AppBar(
        titleSpacing: 0,

        title: Padding(
          padding:  EdgeInsets.only(left: MySize.size20),
          child: GestureDetector(
            onTap: (){
              Navigator.of(context, rootNavigator: true).push(
                MaterialPageRoute(
                    builder: (BuildContext context) => ProfileView()),);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
            (ApiService.me.image =="" || ApiService.me.image ==null || !authController.isLogin.value)?
                // !authController.isLogin.value?
              const   CircleAvatar(
                  radius: 22,
                  backgroundImage:AssetImage("assets/avatar.jpg")
              ):

                CircleAvatar(
                  radius: 22,
                  backgroundImage: NetworkImage(ApiService.me.image.toString() ),
              ),

                Text(
                  authController.isLogin.value ? ' Hi, ${ApiService.me.name!.split(" ").first}':'  Hello',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black, fontSize: MySize.size20),
                ),
              ],
            ),
          ),
        ),
        actions: [

          IconButton(onPressed: (){
            showSearch(context: context,
            delegate: CustomSearchDelegate());
          },
              icon:const  Icon(Iconsax.search_normal)),
          IconButton(onPressed: (){
            Navigator.of(context, rootNavigator: true).push(
              MaterialPageRoute(
                  builder: (BuildContext context) =>const  CartView()),);
          },
              icon:const CartIconWidget()),
          SizedBox(width: MySize.size10,)
        ],
        iconTheme: const IconThemeData(color: AppTheme.primaryColor),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
    );
  }
}

class CustomSearchDelegate extends SearchDelegate{
  final productController=Get.put(ProductController());

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(onPressed: (){
        query='';
      }, icon:const  Icon(Iconsax.close_circle))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(onPressed: (){
      close(context,null);
}, icon:const  Icon(Iconsax.arrow_left));  }

  @override
  Widget buildResults(BuildContext context) {
  
    List<Product> matchQuery=[];
    for(var product in productController.productListNormal){
      if(product.name!.toLowerCase().contains(query.toLowerCase())){
        matchQuery.add(product);
        print("matchQuery $matchQuery");
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
        itemBuilder: (context,index) {
        var product = matchQuery[index];
        return  MainProductCard(
            isAdd: true,
            title: "${product.name}",
            subtitle: AppTheme.money(product.price!),
            image:product.image,
            icon: const Icon(
              MdiIcons.wallet,
            ),

            quickAdd: () async {
              productController.quickAddToCart(product);

            });
    });
  }


  @override
  Widget buildSuggestions(BuildContext context) {
    List<Product> matchQuery = [];
    for (var product in productController.productListNormal) {
      if (product.name!.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(product);
        print("matchQuery $matchQuery");
      }
    }

    return ListView.builder(
        itemCount: matchQuery.length,
        itemBuilder: (context,index) {
          var product = matchQuery[index];
          return  MainProductCard(
              isAdd: true,
              title: "${product.name}",
              subtitle: AppTheme.money(product.price!),
              image:product.image,
              icon: const Icon(
                MdiIcons.wallet,
              ),

              quickAdd: () async {
                productController.quickAddToCart(product);
              });
        });
  }
}