import 'dart:math';


import 'package:animations/animations.dart';
import 'package:aponwola/common/SizeConfig.dart';
import 'package:aponwola/common/app_theme.dart';
import 'package:aponwola/common/constant.dart';
import 'package:aponwola/controllers/auth.controller.dart';
import 'package:aponwola/controllers/category.controller.dart';
import 'package:aponwola/controllers/product.controller.dart';
import 'package:aponwola/custom_widget/animatedWidget.dart';
import 'package:aponwola/custom_widget/homeAppBar.dart';
import 'package:aponwola/custom_widget/productCard.dart';
import 'package:aponwola/data/category.dart';
import 'package:aponwola/data/dropdownClass.dart';
import 'package:aponwola/data/foodOptions.dart';
import 'package:aponwola/data/product.dart';
import 'package:aponwola/view/home/detail.view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';


class HomeView extends StatefulWidget {
   HomeView({Key? key}) : super(key: key);


  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with SingleTickerProviderStateMixin {
  final _transitionType = ContainerTransitionType.fade;
  bool startAnimation = false;

  late final AnimationController _animationController=AnimationController(vsync: this,duration: const Duration(seconds: 1));
  late final Animation<Offset> _offsetAnimation=Tween<Offset>(begin:Offset.zero,end:const  Offset(0,1.5))
      .animate(
    CurvedAnimation(parent: _animationController, curve: Curves.elasticIn)
  );

  final categoryController=Get.put(CategoryController());
  final productController=Get.put(ProductController());
  final authController=Get.put(AuthController());

  late PageController _pageController;
  int currentPage = 1;

  @override
  void initState() {
    // TODO: implement initState
    _pageController = PageController(initialPage: currentPage, viewportFraction: 0.9);
    categoryController.getCategories();
    productController.getProducts();
    // authController.loadProfile();
    super.initState();
    // _pageController.position.haveDimensions;
    initMethod();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _animationController.dispose();
    _pageController.dispose();
  }

  initMethod(){
    Future.delayed(const Duration(seconds: 1)).then((val) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        setState(() {
          startAnimation = true;
        });
      });
    });


    // Future.delayed(const Duration(seconds: 2)).then((val) {
    //   _pageController.animateToPage(_pageController.page!.toInt() + 1,
    //       duration: const Duration(milliseconds: 400),
    //       curve: Curves.easeIn
    //        );
    //    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.grey.withOpacity(.05),
      appBar: HomeAppBar(),
      body: GetX<CategoryController>(
          builder: (categoryController) {
            return categoryController.isLoadingCategory.value?
            const Center(child:   CupertinoActivityIndicator())
                :
           Container(
            height: MySize.screenHeight,
            padding: const EdgeInsets.only(top: 5),
            child: ListView(
              physics: const NeverScrollableScrollPhysics(),
              children: <Widget>[
                Padding(
                  padding:  EdgeInsets.symmetric(vertical: MySize.size15,horizontal: MySize.size20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Finger licking \ndelicacies",
                        // textAlign: TextAlign.right,
                        textWidthBasis: TextWidthBasis.longestLine,
                        style: TextStyle(fontSize: MySize.size25,
                            fontWeight: FontWeight.bold),),
                      FilledButton(onPressed: ()async{

                        var whatsappUrl = "whatsapp://send?phone=2349083669369&text=Hi Aponwola";
                        try {
                          launchUrl(Uri.parse(whatsappUrl));
                        } catch (e) {
                          print(e);
                        }
                      }, child: const Text("You have an event?"))

                    ],
                  ),

                ),
                const Header(text:"Category"),
                Container(
                  child: SizedBox(
                    height: MySize.size100,
                    child: SlideTransition(
                      position: _offsetAnimation,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          padding: EdgeInsets.only(
                            // bottom: MySize.size600,
                            left: MySize.size10,
                            right: MySize.size10,
                          ),
                          // physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: categoryController.categoryList.length,
                          itemBuilder: (context, index) {
                            Category cat= categoryController.categoryList[index];

                            return
                              cat.type=="normal"?
                              AnimatedContainer(
                                  curve: Curves.easeInOut,
                                  duration: Duration(milliseconds:500 + (index * 500)),
                                  transform: Matrix4.translationValues(startAnimation ? 0
                                      : MySize.screenWidth, 0, 0),
                                  child: Category2Card(category: cat)):Container();

                          }),
                    ),
                  ),
                ),
               AspectRatio(
                 aspectRatio: 0.9,
                 child: PageView.builder(
                     itemCount: categoryController.categoryList.length,
                     physics: const ClampingScrollPhysics(),
                     controller: _pageController,
                     itemBuilder: (context, index) {
                       return  categoryController.categoryList[index].type=="daily"?
                       carouselView(index,categoryController):Container();
                     }),
               ),


              ],
            ),
          );
        }
      ),
    );
  }



  Widget carouselView(int index,categoryController) {
    return AnimatedBuilder(
      animation: _pageController,
      builder: (context, child) {
        double value = 0.00;
        if (_pageController.position.haveDimensions) {
          value = index.toDouble() - (_pageController.page ?? 0);
          value = (value * 0.1).clamp(-1, 1);
          print("value $value index $index");
        }

        return Transform.rotate(
          angle: pi * value,
          child:
          AnimatedContainerWrapper(
            transitionType: _transitionType,
            closedBuilder: (BuildContext _, VoidCallback openContainer) {
              return CarouselCard(data: categoryController.categoryList[index],openContainer: openContainer,);
            },
            // onClosed: false,
            child:  DetailsView(data: categoryController.categoryList[index]),

          ),

          // carouselCard(categoryController.categoryList[index]),
        );
      },
    );
  }
  // Obx(() => Text("${controller.name}"));

  // Widget carouselCard(Category data) {


  //   return CarouselCard(context: context);
  // }
}



class Header extends StatelessWidget {
  const Header({
    super.key,
    this.text=""
  });
final String text;
  @override
  Widget build(BuildContext context) {
    return Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Text(text, textAlign: TextAlign.left,
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.grey,
                        fontSize: MySize.size16)),
              ],
            ),
          );
  }
}





