import 'package:aponwola/common/SizeConfig.dart';
import 'package:aponwola/common/app_theme.dart';
import 'package:aponwola/data/category.dart';
import 'package:aponwola/data/dropdownClass.dart';
import 'package:aponwola/data/foodOptions.dart';
import 'package:aponwola/data/product.dart';
import 'package:aponwola/util/openWhatsapp.dart';
import 'package:aponwola/view/home/detail.view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';

class ProductHCard extends StatelessWidget {
  const ProductHCard({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.all(10.0),
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                  ),
                  child: CachedNetworkImage(
                    imageUrl: product.image!,
                    width: MySize.size100,
                    height: MySize.size100,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: MySize.size180,
                        child: Text(product.name!,
                          // overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontWeight: FontWeight.w700),),
                      ),

                      Text("${product.description}",style:  const TextStyle(color: Colors.grey),),
                      Text("${product.price}",style: const  TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),

                    ],
                  ),
                ),
              ],
            ),
            GestureDetector(
              onTap: (){

              },

              child: Container(
                decoration: BoxDecoration(
                    color: AppTheme.primaryColor,
                    borderRadius: BorderRadius.circular(8)
                ),

                padding: const  EdgeInsets.all(5.0),
                child: const Icon(MdiIcons.plus,color: Colors.white,),
              ),
            ),
          ],
        ),
      ),
    );

  }
}

class Category2Card extends StatelessWidget {
  const Category2Card({
    super.key,
    required this.category,
  });

  final Category category;

  @override
  Widget build(BuildContext context) {
    return InkWell(
   onTap:()async{
     if(category.name=="Event bookings"){
       openWhatsapp("Hi Aponwola, I will like to make some inquiry");
     }else{
     Navigator.push(
     context,
     MaterialPageRoute(
     builder: (context) => DetailsView(data: category, isDaily:false)));
     }
   },


      child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
          margin: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20)
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius:  BorderRadius.circular(10),
                      child:
                      CachedNetworkImage(
                        imageUrl: category.image!,
                        fit: BoxFit.cover,
                        width: MySize.size70,
                        height: MySize.size70,
                      )
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            child: Text(toBeginningOfSentenceCase(category.name!).toString(),
                              style: const TextStyle(fontWeight: FontWeight.w700),),
                          ),
                         const  SizedBox(height: 10,),
                          SizedBox(
                            child: Text(toBeginningOfSentenceCase(category.name!).toString(),
                              style:  TextStyle(color:Colors.grey,fontSize: MySize.size12),),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),


            ],
          ),
        ),
      ),
    );

  }
}

class CarouselCard extends StatelessWidget {
  final VoidCallback openContainer;
  final Category data;

  const CarouselCard({
    super.key,
    required this.data,
    required this.openContainer,
  });


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: openContainer,
      child: Container(
        height: MySize.size900,
        margin: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),

        ),
        child: Hero(
          tag: data.name!,
          child: GestureDetector(
            onTap: () {

              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DetailsView(data: data)));
            },
            child: Stack(
              children: [
                Positioned.fill(
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: CachedNetworkImage(
                        imageUrl: data.image!,
                        fit: BoxFit.cover,
                        // height: MySize.size300,
                      )
                  ),


                ),

                Positioned.fill(
                  child: Container(

                    decoration: BoxDecoration(

                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      gradient: const LinearGradient(
                        colors: [
                          AppTheme.primaryColor,
                          Colors.transparent,
                          Colors.transparent,
                          AppTheme.primaryColor
                        ],

                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        stops: [0, 0, 0.6, 1],
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(14.0),
                          child: Text(toBeginningOfSentenceCase(data.name!).toString(),style:const TextStyle(color: Colors.white,fontSize: 16),),
                        )

                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
