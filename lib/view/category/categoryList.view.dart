
import 'package:aponwola/common/SizeConfig.dart';
import 'package:aponwola/controllers/category.controller.dart';
import 'package:aponwola/controllers/product.controller.dart';
import 'package:aponwola/data/category.dart';
import 'package:aponwola/data/product.dart';
import 'package:aponwola/view/category/addCategory.view.dart';
import 'package:aponwola/view/product/addProduct.view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class CategoryListView extends StatefulWidget {
  CategoryListView({Key? key}) : super(key: key);

  @override
  State<CategoryListView> createState() => _CategoryListViewState();
}


class _CategoryListViewState extends State<CategoryListView> {
  final categoryController=Get.put(CategoryController());
  @override
  void initState() {
    super.initState();
    categoryController.getCategories();
  }


  @override
  Widget build(BuildContext context) {
    return  GetX<CategoryController>(
        builder: (categoryController) {
          return Scaffold(
            appBar: AppBar(
              actions: [
                Padding(
                  padding: const  EdgeInsets.symmetric(horizontal: 8.0),
                  child: InkWell(
                      onTap: ()=>  Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (BuildContext context) => AddCategoryView(
                              ))),
                      child: const Icon(MdiIcons.plus,size: 20,)),
                )
              ],
            ),

            body: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: MySize.size23),
              itemCount: categoryController.categoryList.length,
              itemBuilder: (context,index){
                Category category=categoryController.categoryList[index];
                return   ListTile(
                  title: Text(category.name!),
                  trailing: InkWell(
                      onTap: (){
                        categoryController.deleteCategory(category.id!);
                      },
                      child:const  Icon(MdiIcons.trashCanOutline)),
                  onTap: (){
                    Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (BuildContext context) => AddCategoryView(
                              category: category,
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

