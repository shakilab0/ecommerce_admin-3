import 'package:ecom_admin_3/providers/product_provider.dart';
import 'package:ecom_admin_3/utils/widget_function.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryPage extends StatelessWidget {

  static const String routeName="/catagory_page";

  const CategoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          showSingleTextFieldInputDialog(
              context: context,
              title: "Category",
              positiveButton: "Add",
              onSubmit: (value){
                Provider.of<ProductProvider>(context,listen: false)
                    .addCategory(value);
              }
          );
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text("Category "),
      ),
      body: Consumer<ProductProvider>(
        builder: (context,provider,child)=>ListView.builder(
          itemCount: provider.categoryList.length,
          itemBuilder: (context,index){
            final catModel=provider.categoryList[index];
            return ListTile(
              title: Text(catModel.categoryName),
              trailing: Text('Total : ${catModel.productCount}'),
            );
          },
        ),
      ),


    );
  }
}
