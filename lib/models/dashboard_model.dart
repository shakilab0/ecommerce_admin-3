

import 'package:ecom_admin_3/pages/add_product_page.dart';
import 'package:ecom_admin_3/pages/dashboard_page.dart';
import 'package:ecom_admin_3/pages/orderlist_page.dart';
import 'package:ecom_admin_3/pages/report_page.dart';
import 'package:ecom_admin_3/pages/settings_page.dart';
import 'package:ecom_admin_3/pages/userlist_page.dart';
import 'package:ecom_admin_3/pages/view_product_page.dart';
import 'package:flutter/material.dart';

import '../pages/category_page.dart';
import '../pages/notification_page.dart';

class DashboardModel{
  final String title;
  final IconData iconData;
  final String routeName;

  const DashboardModel({
    required this.title,
    required this.iconData,
    required this.routeName
  });
}

const List<DashboardModel>dashboardModelList=[
  DashboardModel(title: "Add Product", iconData: Icons.add, routeName: AddProductPage.routeName,),
  DashboardModel(title: "View Product", iconData: Icons.card_giftcard, routeName: ViewProductPage.routeName,),
  DashboardModel(title: "Category ", iconData: Icons.category, routeName: CategoryPage.routeName,),
  DashboardModel(title: "Orders", iconData: Icons.monetization_on, routeName: OrderlistPage.routeName,),
  DashboardModel(title: "Users", iconData: Icons.person, routeName: UserlistPage.routeName,),
  DashboardModel(title: "Setting", iconData: Icons.settings, routeName: SettingsPage.routeName,),
  DashboardModel(title: "Report", iconData: Icons.report, routeName: ReportPage.routeName,),
  DashboardModel(title: "Notification", iconData: Icons.notification_important, routeName: NotificationPage.routeName,),

];