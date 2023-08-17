import 'package:aponwola/common/SizeConfig.dart';
import 'package:aponwola/common/app_theme.dart';
import 'package:aponwola/data/address.dart';
import 'package:aponwola/data/category.dart';
import 'package:aponwola/data/dropdownClass.dart';
import 'package:aponwola/data/foodOptions.dart';
import 'package:aponwola/data/product.dart';
import 'package:aponwola/view/home/detail.view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class AddressCard extends StatelessWidget {
  const AddressCard({
    super.key,
     this.address,
     this.title,
     this.subtitle,
    this.onTap,
    this.cardColor=AppTheme.primaryColor,
    this.selectedAddressId=""

  });



  final Address? address;
  final String? title;
  final String? subtitle;
  final VoidCallback? onTap;
  final Color? cardColor;
  final String? selectedAddressId;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          margin: const EdgeInsets.only(top:10.0),
          // padding: const EdgeInsets.all(10.0),
          width: MySize.size200,
          // height: MySize.size80,
          decoration: BoxDecoration(
              color: selectedAddressId==address!.id? AppTheme.primaryColor.withOpacity(0.7) :cardColor!.withOpacity(0.2),
              borderRadius: BorderRadius.circular(15),

          ),
          child: Stack(
            children: [
              // Positioned(
              //     top:50,
              //     right: 20,
              //     child:  Container(
              //       height: MySize.size150,
              //       width: MySize.size150,
              //       decoration:  BoxDecoration(
              //           color: Colors.white.withOpacity(1),
              //           borderRadius:  BorderRadius.circular(100)
              //       ),
              //     )),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: MySize.size300,
                          child: Text(toBeginningOfSentenceCase(address!.address).toString(),
                            // overflow: TextOverflow.ellipsis,
                            style:  TextStyle(  color:selectedAddressId==address!.id? AppTheme.whiteBackground: Colors.black54),),
                        ),
                       const SizedBox(height: 4),
                        SizedBox(
                          // width: MySize.size100,
                          child: Text(toBeginningOfSentenceCase("${address!.place}  (${address!.amount})").toString(),
                            // overflow: TextOverflow.ellipsis,
                            style:  TextStyle(
                             color:   selectedAddressId==address!.id? AppTheme.whiteBackground:null,
                                fontWeight: FontWeight.w700),),
                        ),
                      ],
                    ),
                  ),
                  if(selectedAddressId==address!.id)
                  Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: Icon(Icons.check,size: MySize.size30,color: AppTheme.whiteBackground,),
                  )


                ],
              ),

            ],
          ),
        ),
      ),
    );

  }
}
