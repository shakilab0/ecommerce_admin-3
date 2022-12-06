import 'package:ecom_admin_3/db/db_helper.dart';
import 'package:ecom_admin_3/models/order_constant_model.dart';
import 'package:ecom_admin_3/models/order_model.dart';
import 'package:flutter/material.dart';

class OrderProvider extends ChangeNotifier {
  OrderConstantModel orderConstantModel = OrderConstantModel();
  List<OrderModel>orderList=[];

  OrderModel getOrderById(String id) {
    return orderList.firstWhere((element) => element.orderId == id);
  }

  getOrders(){
    DbHelper.getAllOrders().listen((snapshot) {
      orderList=List.generate(snapshot.docs.length, (index) => OrderModel.fromMap(snapshot.docs[index].data()));
      notifyListeners();
    });
  }

  getOrderConstants() {
    DbHelper.getOrderConstants().listen((snapshot) {
      if (snapshot.exists) {
        orderConstantModel = OrderConstantModel.fromMap(snapshot.data()!);
        notifyListeners();
      }
    });
  }

  Future<void> updateOrderConstants(OrderConstantModel model) {
    return DbHelper.updateOrderConstants(model);
  }

  Future<void> updateOrderStatus(String orderId, String status) {
    return DbHelper.updateOrderStatus(orderId, status);
  }

  num getOrderByDate(num day, num month, num year) {
    //final dt = DateTime.now().subtract(Duration(days: 7));
    num total = 0;
    for(final order in orderList) {
      if(order.orderDate.day == day &&
          order.orderDate.month == month &&
          order.orderDate.year == year) {
        total += 1;
      }
    }
    return total;
  }


  num getTotalItemsSoldByDate(num day, num month, num year) {
    num total = 0;
    for(final order in orderList) {
      if(order.orderDate.day == day &&
          order.orderDate.month == month &&
          order.orderDate.year == year) {
        for(final model in order.productDetails) {
          total += model.quantity;
        }
      }
    }
    return total;
  }

}
