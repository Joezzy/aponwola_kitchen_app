
import 'package:aponwola/common/SizeConfig.dart';
import 'package:aponwola/controllers/category.controller.dart';
import 'package:aponwola/controllers/product.controller.dart';
import 'package:aponwola/data/product.dart';
import 'package:aponwola/view/product/addProduct.view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class ProductListView extends StatefulWidget {
   ProductListView({Key? key}) : super(key: key);

  @override
  State<ProductListView> createState() => _ProductListViewState();
}


class _ProductListViewState extends State<ProductListView> {
  final productController=Get.put(ProductController());
  final categoryController=Get.put(CategoryController());
  @override
  void initState() {
    super.initState();
    categoryController.getCategories();
    productController.getProducts();
  }
  @override
  Widget build(BuildContext context) {
    return  GetX<ProductController>(
      builder: (productController) {
        return Scaffold(
          appBar: AppBar(
            actions: [
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: 8.0),
                child: InkWell(
                  onTap: ()=>  Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (BuildContext context) => AddProductView(
                          ))),
                    child: Icon(MdiIcons.plus,size: 20,)),
              )
            ],
          ),
          body: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: MySize.size23),
            itemCount: productController.productListAll.length,
            itemBuilder: (context,index){
              Product product=productController.productListAll[index];
              return   ListTile(
                title: Text(product.name!),
                subtitle: Text(product.price.toString()),
                trailing: InkWell(
                    onTap: (){
                      productController.deleteProduct(product.id!);
                    },
                    child:const  Icon(MdiIcons.trashCanOutline)),
                onTap: (){
                  Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) => AddProductView(
                          product: product,
                        )));

                },
              );
            },

          ),
        );
      }
    );
  }
}

