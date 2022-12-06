import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/order_provider.dart';
import '../providers/product_provider.dart';
import '../providers/user_provider.dart';

class ReportPage extends StatefulWidget {
  static const String routeName="/report_page";
  const ReportPage({Key? key}) : super(key: key);

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  late OrderProvider orderProvider;
  late ProductProvider productProvider;
  late UserProvider userProvider;

  @override
  void didChangeDependencies() {
    orderProvider = Provider.of<OrderProvider>(context, listen: false);
    productProvider = Provider.of<ProductProvider>(context, listen: false);
    userProvider = Provider.of<UserProvider>(context, listen: false);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Report'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(8),
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Orders',
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  headerSection('Today'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          const Text('Total Orders', style: TextStyle(fontSize: 14),),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              orderProvider
                                  .getOrderByDate(DateTime.now().day,
                                  DateTime.now().month, DateTime.now().year)
                                  .toString(),
                              style: TextStyle(fontSize: 22),
                            ),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          const Text('Items Sold', style: TextStyle(fontSize: 14),),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              orderProvider
                                  .getTotalItemsSoldByDate(DateTime.now().day,
                                  DateTime.now().month, DateTime.now().year)
                                  .toString(),
                              style: TextStyle(fontSize: 22),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  headerSection('Last 7 Days'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          const Text('Total Orders', style: TextStyle(fontSize: 14),),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              orderProvider
                                  .getOrderByDate(DateTime.now().day,
                                  DateTime.now().month, DateTime.now().year)
                                  .toString(),
                              style: TextStyle(fontSize: 22),
                            ),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          const Text('Items Sold', style: TextStyle(fontSize: 14),),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              orderProvider
                                  .getTotalItemsSoldByDate(DateTime.now().day,
                                  DateTime.now().month, DateTime.now().year)
                                  .toString(),
                              style: const TextStyle(fontSize: 22),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Column headerSection(String title) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title,
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        const Divider(
          color: Colors.black,
          height: 3,
        ),
      ],
    );
  }
}
