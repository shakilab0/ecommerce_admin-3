import 'package:ecom_admin_3/utils/widget_function.dart';
import 'package:flutter/material.dart';

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
                print(value);
              }
          );
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text("Category"),
      ),

    );
  }
}
