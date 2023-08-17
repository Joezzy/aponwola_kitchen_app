import 'package:aponwola/common/SizeConfig.dart';
import 'package:aponwola/common/app_theme.dart';
import 'package:aponwola/controllers/cartController.dart';
import 'package:aponwola/services/api.service.dart';
import 'package:aponwola/view/auth/login.view.dart';
import 'package:aponwola/view/cart/cart.view.dart';
import 'package:aponwola/view/home/home.view.dart';
import 'package:aponwola/view/order/order.view.dart';
import 'package:aponwola/view/profile/profile.view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

////
class _DashboardScreenState extends State<DashboardScreen>
    with SingleTickerProviderStateMixin {
  late  TabController tabController;
  int selectedIndex = 1;
  onItemClicked(int index) {
    setState(() {
      if (index==0){
        // Navigator.pop(context);
      }

      if(index==1){
      }
      else if(index==2){
      }
      // else if(index==3){
      //   // settingController.fillText();
      // }

      selectedIndex = index;
      tabController.index = selectedIndex;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: 3, vsync: this);

    onItemClicked(0) ;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    // tabController.dispose();
    super.dispose();
  }

  PersistentTabController _controller = PersistentTabController(initialIndex: 0);

  @override
  Widget build(BuildContext context) {

    return PersistentTabView(
      context,
      controller: _controller,
      screens: [

        HomeView(),
        const CartView(),
        OrderView(),
        //
      ],
      items: _navBarsItems(),
      onItemSelected: (int){
        setState(() {
          selectedIndex=_controller.index;
          // print(int);
          // print(selectedIndex);
          // if(selectedIndex==3){
          //   // settingController.fillText();
          //   print("selectedIndex=3");
          //
          // }
        });
      },
      confineInSafeArea: true,
      backgroundColor: Colors.white, // Default is Colors.white.
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset: true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true, // Default is true.
      hideNavigationBarWhenKeyboardShows: true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.white,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties:const  ItemAnimationProperties( // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation( // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle: NavBarStyle.style6, // Choose the nav bar style with this property.
    );

    // return MaterialApp(
    //   debugShowCheckedModeBanner: false,
    //   theme: ThemeData(
    //     backgroundColor: AppTheme.o3Background,
    //     fontFamily: 'ClashDisplay',
    //   ),
    //   home: DefaultTabController(
    //     length: 3,
    //     // set initial index to 1
    //     initialIndex: 0,
    //     child: Scaffold(
    //       backgroundColor: AppTheme.whiteBackground,
    //       // appBar:(selectedIndex!=3)? BrentAppBar(title: pageTitle,):null,
    //       body: TabBarView(
    //
    //         physics: const NeverScrollableScrollPhysics(),
    //         controller: tabController,
    //         children: <Widget>[
    //
    //           HomeScreen(),
    //           MyTokenScreen(),
    //           CommunityScreen(),
    //           SettingsScreen()
    //
    //           //
    //         ],
    //
    //       ),
    //
    //
    //       bottomNavigationBar: BottomNavigationBar(
    //
    //         items: <BottomNavigationBarItem>[
    //           BottomNavigationBarItem(
    //               activeIcon:  Icon(Iconsax.home_trend_up5),
    //               icon: Icon(Iconsax.home_trend_up),
    //               label:"Home"
    //           ),
    //
    //           BottomNavigationBarItem(
    //               activeIcon:Icon(Iconsax.money_25),
    //               icon: Icon(Iconsax.money_2),
    //               label: "Players"),
    //           BottomNavigationBarItem(
    //               activeIcon:Icon(Iconsax.profile_2user5),
    //               icon: Icon(Iconsax.profile_2user),
    //               label: "Community"),
    //           BottomNavigationBarItem(
    //               activeIcon:Image.asset("assets/setting-2.png"),//g_25
    //               // activeIcon:Icon(Iconsax.setting_25),//g_25
    //               icon: Icon(Iconsax.setting_2),
    //               label: "Settings"),
    //
    //         ],
    //         currentIndex: selectedIndex,
    //         unselectedItemColor: Colors.grey,
    //         selectedItemColor: AppTheme.o3Blue,
    //         //showSelectedLabels: true,
    //         showUnselectedLabels: true,
    //         type: BottomNavigationBarType.shifting,
    //         selectedLabelStyle: TextStyle(fontSize:12),
    //         onTap: onItemClicked,
    //       ),
    //     ),
    //   ),
    // );
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(selectedIndex==0?Iconsax.home:Iconsax.home4),
        // title: ("Home"),
        activeColorPrimary: AppTheme.primaryColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Stack(
          children: [
            Container(

              padding: EdgeInsets.symmetric(
                  horizontal: MySize.size10
              ),
              // width: MySize.size50,
              // height: MySize.size30,
              decoration: BoxDecoration(
                // color: AppTheme.o3Grey,
                  borderRadius: BorderRadius.circular(6)
              ),
              child: const Icon(Iconsax.shopping_cart,size: 30,),
            ),

            Positioned(
                top: 0,
                right: 5,
                child: Container(
                  height: 15,
                    width: 15,
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(6)
                    ),
                    padding: EdgeInsets.symmetric(
                        horizontal: MySize.size2
                    ),
                    child: GetX<CartController>(
                        builder: (cartController) {
                          return Center(child: Text("${cartController.cartModelList.length}",style:const TextStyle(fontSize: 11),));
                        }
                    )
                )
            ),
          ],
        ),
        activeColorPrimary: AppTheme.primaryColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),

      PersistentBottomNavBarItem(
        icon: Icon(selectedIndex==1?Iconsax.shopping_bag:Iconsax.shopping_bag),
        // title: ("My orders"),
        activeColorPrimary: AppTheme.primaryColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),

      // PersistentBottomNavBarItem(
      //   icon: const Icon(Iconsax.user),
      //   // title: ("Cart"),
      //   activeColorPrimary: AppTheme.primaryColor,
      //   inactiveColorPrimary: CupertinoColors.systemGrey,
      // ),

    ];
  }

}



