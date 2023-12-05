import 'package:animations/animations.dart';
import 'package:aponwola/common/SizeConfig.dart';
import 'package:aponwola/common/app_theme.dart';
import 'package:aponwola/controllers/product.controller.dart';
import 'package:aponwola/custom_widget/btn.dart';
import 'package:aponwola/custom_widget/mainProductCard.dart';
import 'package:aponwola/custom_widget/productCard.dart';
import 'package:aponwola/data/category.dart';
import 'package:aponwola/data/product.dart';
import 'package:aponwola/view/home/home.view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class DetailsView extends StatefulWidget {
  final Category? data;
  final bool isDaily;
  const DetailsView({Key? key,  this.data, this.isDaily=true}) : super(key: key);

  @override
  _DetailsViewState createState() => _DetailsViewState();
}

class _DetailsViewState extends State<DetailsView> with SingleTickerProviderStateMixin{
  final productController=Get.put(ProductController());
  final _transitionType = ContainerTransitionType.fade;
  late final AnimationController _animationController=AnimationController(vsync: this,duration: const Duration(seconds: 1));
  late final Animation<Offset> _offsetAnimation=Tween<Offset>(begin:Offset.zero,end: const Offset(0,1.5))
      .animate(
      CurvedAnimation(parent: _animationController, curve: Curves.elasticIn)
  );


  bool startAnimation = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initMethod();
  }

  initMethod(){

    if(widget.isDaily){
      productController.getDailyProducts(widget.data!.name!);
    }
    else{
      productController.getBowlsProducts(widget.data!.name!);
    }
    Future.delayed(const Duration(seconds: 2)).then((val) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        setState(() {
          startAnimation = true;
        });
      });
    });


  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.white,
      appBar: AppBar(
         centerTitle: true,
        title:    Text(
          "${toBeginningOfSentenceCase(widget.data!.name!)}",
          style: const TextStyle(
              color: Colors.black87,
              fontSize: 25,
              fontWeight: FontWeight.bold),
        ),
        backgroundColor:AppTheme.whiteBackground,
        iconTheme: const IconThemeData(color: Colors.black54),
        elevation: 0,
      ),

      body:   GetX<ProductController>(
          builder: (productController) {
            return ListView(
              padding: const EdgeInsets.all(10),
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Hero(
                    tag: widget.data!.image!,
                    child:ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: CachedNetworkImage(
                          imageUrl:  widget.data!.image!,
                          fit: BoxFit.cover,
                          height: MySize.size300,
                          width: MySize.screenWidth,
                        )),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Text(
                    "${widget.data!.description}",
                    style: const TextStyle(
                        color: Colors.black54,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),

                if(productController.productListDailyMain.isNotEmpty)
                  ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),

                      shrinkWrap: true,
                      itemCount: productController.productListDailyMain.length,
                      itemBuilder: (context, index) {
                        Product product= productController.productListDailyMain[index];

                        return
                          MainProductCard(
                              radioValue: product.id!,
                              selected: productController.selectedMainProduct.value.id,
                              title: "${product.name}",
                              subtitle: AppTheme.money(product.price!),
                              image:product.image,
                              icon: const Icon(
                                MdiIcons.wallet,
                              ),
                              onTap: () async {
                                setState(() {
                                  productController.selectedMainProduct.value=product;
                                  productController.calculateTotal();
                                });
                              });
                      }),

                if(productController.productListDailyProtein.isNotEmpty)
                  const Header(text:"Protein"),
                if(productController.productListDailyProtein.isNotEmpty)
                  ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: productController.productListDailyProtein.length,
                      itemBuilder: (context, index) {
                        Product product= productController.productListDailyProtein[index];

                        return  OtherProductCard(
                            radioValue: product.id!,
                            selected: productController.selectedProteinProduct.contains(product.id),
                            title: "${product.name}",
                            subtitle: AppTheme.money(product.price!),
                            image:product.image,
                            icon: const Icon(
                              MdiIcons.wallet,
                            ),
                            onTap: () async {
                              setState(() {
                                productController.selectProteinMethod(product);
                              });
                            });


                      }),

                if(productController.productListDailySide.isNotEmpty)
                  const Header(text:"Side (Optional"),
                if(productController.productListDailySide.isNotEmpty)
                  ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: productController.productListDailySide.length,
                      itemBuilder: (context, index) {
                        Product product= productController.productListDailySide[index];

                        return  OtherProductCard(
                            radioValue: product.id!,
                            selected: productController.selectedSideProduct.contains(product.id),
                            title: "${product.name}",
                            subtitle: AppTheme.money(product.price!),
                            image:product.image,
                            icon: const Icon(
                              MdiIcons.wallet,
                            ),
                            onTap: () async {
                              setState(() {
                                productController.selectSideMethod(product);
                              });
                            });


                      }),

                if(productController.productListBowl.isNotEmpty)
                ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: productController.productListBowl.length,
                    itemBuilder: (context, index) {
                      Product product= productController.productListBowl[index];

                      return  OtherProductCard(
                          radioValue: product.id!,
                          selected: productController.selectedBowlProduct.contains(product.id),
                          title: "${product.name}",
                          subtitle: AppTheme.money(product.price!),
                          image:product.image,
                          icon: const Icon(
                            MdiIcons.wallet,
                          ),
                          onTap: () async {
                            setState(() {
                              productController.selectBowlMethod(product);
                            });
                          });


                    }),


              ],
            );
          }
      ),
      bottomNavigationBar: Container(
        height: MySize.size110,
        padding: const EdgeInsets.all(20),
        child:  InkWell(
          onTap: ()=>productController.addProductToCart(context),
          child: Container(
            decoration: BoxDecoration(
                color: AppTheme.primaryColor,
                borderRadius: BorderRadius.circular(20)
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children:  [
                const Text("Add to cart",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                Text(AppTheme.money(productController.totalPrice.value), style:const TextStyle(color: AppTheme.whiteBackground,  fontWeight: FontWeight.bold) ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}