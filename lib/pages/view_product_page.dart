import 'package:flutter/material.dart';

class ViewProductPage extends StatelessWidget {
  static const String routeName="/view_product_page";
  const ViewProductPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("View Products"),
      ),
    );
  }
}
