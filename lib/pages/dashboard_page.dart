import 'dart:convert';
import 'dart:io';

import 'package:ecom_admin_3/auth/auth_service.dart';
import 'package:ecom_admin_3/customwidgets/dashboard_item_view.dart';
import 'package:ecom_admin_3/models/dashboard_model.dart';
import 'package:ecom_admin_3/pages/launcher_page.dart';
import 'package:ecom_admin_3/providers/order_provider.dart';
import 'package:ecom_admin_3/providers/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import '../customwidgets/badge_view.dart';
import '../providers/notification_provider.dart';
import '../providers/user_provider.dart';

class DashboardPage extends StatelessWidget {
  static const String routeName="/dashboard_page";
  const DashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Provider.of<ProductProvider>(context,listen: false).getAllCategory();
    Provider.of<ProductProvider>(context,listen: false).getAllProducts();
    Provider.of<ProductProvider>(context,listen: false).getAllPurchase();
    Provider.of<OrderProvider>(context,listen: false).getOrderConstants();
    Provider.of<UserProvider>(context,listen: false).getAllUsers();
    Provider.of<OrderProvider>(context,listen: false).getOrders();
    Provider.of<NotificationProvider>(context,listen: false).getAllNotifications();

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
          IconButton(
            onPressed: (){
              _sendNotification();

            },
            icon: const Icon(Icons.send),
          ),
        ],
      ),
      body: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: MediaQuery.of(context).size.width > 600 ? 3 : 2,
          ),
          itemCount: dashboardModelList.length,
          itemBuilder: (context,index){
            //DashboardItemView(model: dashboardModelList[index])
            final model=dashboardModelList[index];
            if(model.title=="Notification"){
              final count=Provider.of<NotificationProvider>(context).totalUnreadMessage;
              return DashboardItemView(
                model: model,
                badge: BadgeView(count: count,),
              );
            }
            return DashboardItemView(model: model);


          },
      ),
    );
  }

  void _sendNotification()async {
    final url=' https://fcm.googleapis.com/fcm/send';
    final header={
      'Content-Type':'application/json',
      'Authorization':'key=$serverKey'
    };
    final body={

        "to": "/topics/promo",
        "notification": {
          "title": "Bigg offer",
          "body": "New news story available."
        },
        "data": {
          "key": "promo",
          "value":"off234"
        }
    };
    try{
      final response = await http.post(Uri.parse(url),headers: header,body: json.encode(body) );

    }catch(error){
      print(error.toString());

    }
  }


}


const serverKey='AAAAxvMPZMw:APA91bF9ByOgqyBBGDRIlvwdP0Fy_PZZyvrahPB87b3-7fs0v-trd-_ki4bF5i8myCNOsOrA4rIsh5KdakSEMXOQwwv3Bafy76u1NzR19UzNzCUoaRa--l2XyAxeT-Z6VDTP2IBvOMQz';
