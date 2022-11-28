
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import '../models/order_model.dart';
import '../providers/order_provider.dart';
import '../utils/constants.dart';
import '../utils/helper_function.dart';

class OrderDetailsPage extends StatelessWidget {
  static const String routeName = '/order_details';
  const OrderDetailsPage({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final orderProvider = Provider.of<OrderProvider>(context);
    final orderId = ModalRoute.of(context)!.settings.arguments as String;
    final orderModel = orderProvider.getOrderById(orderId);
    return Scaffold(
      appBar: AppBar(
        title: Text(orderId),
      ),
      body: ListView(
        padding: const EdgeInsets.all(8),
        children: [
          buildHeader('Product Info'),
          buildProductInfoSection(orderModel),
          buildHeader('Order Summery'),
          buildOrderSummerySection(orderModel),
          buildHeader('Order Status'),
          buildOrderStatusSection(orderModel, orderProvider),
        ],
      ),
    );
  }

  Padding buildHeader(String header) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Text(
        header,
        style: const TextStyle(fontSize: 18, color: Colors.grey),
      ),
    );
  }

  Widget buildProductInfoSection(OrderModel orderModel) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: orderModel.productDetails
              .map((cartModel) => ListTile(
                    title: Text(cartModel.productName),
                    trailing:
                        Text('${cartModel.quantity}x${cartModel.salePrice}'),
                  ))
              .toList(),
        ),
      ),
    );
  }

  Widget buildOrderSummerySection(OrderModel orderModel) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            ListTile(
              title: const Text('Discount'),
              trailing: Text('${orderModel.discount}%'),
            ),
            ListTile(
              title: const Text('Vat'),
              trailing: Text('${orderModel.vat}%'),
            ),
            ListTile(
              title: const Text('Delivery Charge'),
              trailing: Text('$currencySymbol${orderModel.deliveryCharge}'),
            ),
            ListTile(
              title: const Text(
                'Grand Total',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              trailing: Text(
                '$currencySymbol${orderModel.grandTotal}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildOrderStatusSection(
      OrderModel orderModel, OrderProvider orderProvider) {
    ValueNotifier<bool> updateBtnNotifier = ValueNotifier(true);
    ValueNotifier<String> statusNotifier =
        ValueNotifier(orderModel.orderStatus);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                ValueListenableBuilder<String>(
                  valueListenable: statusNotifier,
                  builder: (context, value, child) => Radio<String>(
                    value: OrderStatus.pending,
                    groupValue: value,
                    onChanged: (value) {
                      statusNotifier.value = value!;
                      updateBtnNotifier.value =
                          isEnabled(orderModel, statusNotifier.value);
                    },
                  ),
                ),
                 const Text(OrderStatus.pending),
              ],
            ),
            Row(
              children: [
                ValueListenableBuilder<String>(
                  valueListenable: statusNotifier,
                  builder: (context, value, child) => Radio<String>(
                    value: OrderStatus.processing,
                    groupValue: value,
                    onChanged: (value) {
                      statusNotifier.value = value!;
                      updateBtnNotifier.value =
                          isEnabled(orderModel, statusNotifier.value);
                    },
                  ),
                ),
                 const Text(OrderStatus.processing),
              ],
            ),
            Row(
              children: [
                ValueListenableBuilder<String>(
                  valueListenable: statusNotifier,
                  builder: (context, value, child) => Radio<String>(
                    value: OrderStatus.delivered,
                    groupValue: value,
                    onChanged: (value) {
                      statusNotifier.value = value!;
                      updateBtnNotifier.value =
                          isEnabled(orderModel, statusNotifier.value);
                    },
                  ),
                ),
                 const Text(OrderStatus.delivered),
              ],
            ),
            Row(
              children: [
                ValueListenableBuilder<String>(
                  valueListenable: statusNotifier,
                  builder: (context, value, child) => Radio<String>(
                    value: OrderStatus.cancelled,
                    groupValue: value,
                    onChanged: (value) {
                      statusNotifier.value = value!;
                      updateBtnNotifier.value =
                          isEnabled(orderModel, statusNotifier.value);
                    },
                  ),
                ),
                 const Text(OrderStatus.cancelled),
              ],
            ),
            Row(
              children: [
                ValueListenableBuilder<String>(
                  valueListenable: statusNotifier,
                  builder: (context, value, child) => Radio<String>(
                    value: OrderStatus.returned,
                    groupValue: value,
                    onChanged: (value) {
                      statusNotifier.value = value!;
                      updateBtnNotifier.value =
                          isEnabled(orderModel, statusNotifier.value);
                    },
                  ),
                ),
                 const Text(OrderStatus.returned),
              ],
            ),
            ValueListenableBuilder<bool>(
              valueListenable: updateBtnNotifier,
              builder: (context, value, child) => ElevatedButton(
                onPressed: value
                    ? null
                    : () {
                        EasyLoading.show(status: 'Updating status...');
                        orderProvider
                            .updateOrderStatus(
                                orderModel.orderId, statusNotifier.value)
                            .then((value) {
                          EasyLoading.dismiss();
                          showMsg(context, 'Updated');
                        }).catchError((error) {
                          EasyLoading.dismiss();
                          showMsg(context, 'Failed to update');
                        });
                      },
                child: const Text('Update'),
              ),
            )
          ],
        ),
      ),
    );
  }

  bool isEnabled(OrderModel orderModel, String groupValue) {
    return orderModel.orderStatus == groupValue;
  }
}
