import 'package:ecom_admin_3/auth/auth_service.dart';
import 'package:ecom_admin_3/pages/launcher_page.dart';
import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  static const String routeName="/dashboard_page";
  const DashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text("Dashboard"),
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
      body: Center(child: Text("DashboardPage"),),
    );
  }
}
