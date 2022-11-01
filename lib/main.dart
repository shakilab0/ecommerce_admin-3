import 'package:ecom_admin_3/pages/add_product_page.dart';
import 'package:ecom_admin_3/pages/category_page.dart';
import 'package:ecom_admin_3/pages/dashboard_page.dart';
import 'package:ecom_admin_3/pages/launcher_page.dart';
import 'package:ecom_admin_3/pages/login_page.dart';
import 'package:ecom_admin_3/pages/orderlist_page.dart';
import 'package:ecom_admin_3/pages/product_details_page.dart';
import 'package:ecom_admin_3/pages/product_repurchase_page.dart';
import 'package:ecom_admin_3/pages/report_page.dart';
import 'package:ecom_admin_3/pages/settings_page.dart';
import 'package:ecom_admin_3/pages/userlist_page.dart';
import 'package:ecom_admin_3/pages/view_product_page.dart';
import 'package:ecom_admin_3/providers/product_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context)=>ProductProvider()),
    ],
     child: const MyApp())
  );
}
  class MyApp extends StatelessWidget {
    const MyApp({Key? key}) : super(key: key);

    @override
    Widget build(BuildContext context) {

      return MaterialApp(

        builder: EasyLoading.init(),
        initialRoute: LauncherPage.routeName,
        routes: {

          AddProductPage.routeName:(context)=>const AddProductPage(),
          CategoryPage.routeName:(context)=>const CategoryPage(),
          DashboardPage.routeName:(context)=>const DashboardPage(),
          LauncherPage.routeName:(context)=>const LauncherPage(),
          LoginPage.routeName:(context)=>const LoginPage(),
          OrderlistPage.routeName:(context)=>const OrderlistPage(),
          ProductDetailsPage.routeName:(context)=>const ProductDetailsPage(),
          ProductRepurchasePage.routeName:(context)=>const ProductRepurchasePage(),
          ReportPage.routeName:(context)=>const ReportPage(),
          SettingsPage.routeName:(context)=>const SettingsPage(),
          UserlistPage.routeName:(context)=>const UserlistPage(),
          ViewProductPage.routeName:(context)=>const ViewProductPage(),

        },
      );
    }
  }
