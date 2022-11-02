import 'package:ecom_admin_3/auth/auth_service.dart';
import 'package:ecom_admin_3/customwidgets/dashboard_item_view.dart';
import 'package:ecom_admin_3/models/dashboard_model.dart';
import 'package:ecom_admin_3/pages/launcher_page.dart';
import 'package:ecom_admin_3/providers/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DashboardPage extends StatelessWidget {
  static const String routeName="/dashboard_page";
  const DashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Provider.of<ProductProvider>(context,listen: false).getAllCategory();
    return Scaffold(
      appBar: AppBar(
        title:const Text("Dashboard"),
        actions: [
          IconButton(
            onPressed: (){
              AuthService.logOut().then((value) =>
                  Navigator.pushReplacementNamed(context, LauncherPage.routeName),
              );
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          itemCount: dashboardModelList.length,
          itemBuilder: (context,index)=>DashboardItemView(model: dashboardModelList[index]),
      ),
    );
  }
}
