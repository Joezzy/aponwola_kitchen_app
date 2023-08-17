import 'package:aponwola/common/SizeConfig.dart';
import 'package:aponwola/common/app_theme.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class MainProductCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget icon;
  final String radioValue;
  final double horizontalMargin;
  final double verticalMargin;
  final double horizontalPadding;
  final double verticalPadding;
  final VoidCallback? onTap;
  final VoidCallback? quickAdd;
  final bool showInfo;
  final bool isAdd;
  final Color? cardColor;
  final String? selected;
  final String? value;
  final String? image;

  const MainProductCard(
      {Key? key,
        this.title = "",
        this.subtitle = "",
        this.horizontalMargin = 5,
        this.verticalMargin = 10,
        this.horizontalPadding = 20,
        this.verticalPadding = 30,
        required this.icon,
        this.radioValue = "",
         this.onTap,
         this.quickAdd,
        this.showInfo = false,
        this.cardColor=AppTheme.whiteBackground,
        this.value,
        this.selected,
        this.image,
        this.isAdd=false,

      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(
            horizontal: horizontalPadding,
            vertical: MySize.size5),
        margin: EdgeInsets.symmetric(
            horizontal: horizontalMargin,
            vertical: verticalMargin),
        decoration: BoxDecoration(
            color: cardColor,
            borderRadius: BorderRadius.circular(MySize.size8)),
        child: ListTile(
          onTap: onTap,
          contentPadding: EdgeInsets.zero,
          leading:  ClipRRect(
            borderRadius:  BorderRadius.circular(10),
            child: CachedNetworkImage(
              imageUrl: image!,
              height: MySize.size100,
              width: MySize.size70,
              fit: BoxFit.cover,
            ),
          ),
          trailing:
          isAdd?
        FilledButton(onPressed: quickAdd, child: const Text("Add +")) :
          Stack(
            children: [
              Container(
                height: MySize.size28,
                width: MySize.size28,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.black,width: 1.5)
                ),

              ),
              if(selected==radioValue)
                Positioned(
                  top: 7,
                  right: 0,
                  left: 0,
                  child: Center(
                    child:
                    Container(
                      height: MySize.size14,
                      width: MySize.size14,
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(20)
                      ),
                    ),
                  ),
                )
            ],
          ),
          title: Text(
            title,
            style: TextStyle(
                fontSize: MySize.size14,fontWeight: FontWeight.w500),
          ),
          subtitle: Text(
            subtitle,
            style: TextStyle(
                fontSize: MySize.size14),
          ),
        )
    );
  }
}

class OtherProductCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget icon;
  final String radioValue;
  final double horizontalMargin;
  final double verticalMargin;
  final double horizontalPadding;
  final double verticalPadding;
  final VoidCallback onTap;
  final bool showInfo;
  final Color cardColor;
  final bool selected;
  final String? value;
  final String? image;


  const OtherProductCard(
      {Key? key,
        this.title = "",
        this.subtitle = "",
        this.horizontalMargin = 5,
        this.verticalMargin = 10,
        this.horizontalPadding = 20,
        this.verticalPadding = 30,
        required this.icon,
        this.radioValue = "",
        required this.onTap,
        this.showInfo = false,
        this.cardColor=AppTheme.o3Grey,
        this.value,
        this.selected=false,
        this.image,

      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(
            horizontal: horizontalPadding,
            vertical: MySize.size5),
        margin: EdgeInsets.symmetric(
            horizontal: horizontalMargin,
            vertical: verticalMargin),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(MySize.size8)),
        child: ListTile(
          onTap: onTap,
          contentPadding: EdgeInsets.zero,
          leading:  ClipRRect(
            borderRadius:  BorderRadius.circular(10),
            child: CachedNetworkImage(
              imageUrl: image!,
              height: MySize.size100,
              width: MySize.size70,
              fit: BoxFit.cover,
            ),
          ),
          trailing:   Icon(
    selected?
    MdiIcons.checkboxMarked:
    MdiIcons.checkboxBlankOutline
          ),
          title: Text(
            title,
            style: TextStyle(
                fontSize: MySize.size14,fontWeight: FontWeight.w500),
          ),
          subtitle: Text(
            subtitle,
            style: TextStyle(
                fontSize: MySize.size14),
          ),
        )
    );
  }
}
