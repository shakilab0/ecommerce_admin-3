import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/order_provider.dart';
import '../utils/constants.dart';
import '../utils/helper_function.dart';
import 'order_details_page.dart';

class OrderlistPage extends StatelessWidget {
  static const String routeName="/orderlist";
  const OrderlistPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Orders'),
      ),

      body: Consumer<OrderProvider>(
        builder: (context, provider, child) => ListView.builder(
          itemCount: provider.orderList.length,
          itemBuilder: (context, index) {
            final order = provider.orderList[index];
            return ListTile(
              onTap: () => Navigator.pushNamed(context, OrderDetailsPage.routeName, arguments: order.orderId),
              title: Text(getFormattedDate(order.orderDate.timestamp.toDate(),
                  pattern: 'dd/MM/yyyy HH:mm:ss')),
              subtitle: Text(order.orderStatus),
              trailing: Text('$currencySymbol${order.grandTotal}'),
            );
          },
        ),
      ),
    );
  }
}
