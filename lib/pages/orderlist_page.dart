import 'package:flutter/material.dart';

class OrderlistPage extends StatelessWidget {
  static const String routeName="/orderlistPage";
  const OrderlistPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("OrderList"),
      ),
    );
  }
}
