import 'package:ecom_admin_3/providers/order_provider.dart';
import 'package:ecom_admin_3/utils/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import '../models/order_constant_model.dart';

class SettingsPage extends StatefulWidget {
  static const String routeName = "/settings_page";
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final _formKey = GlobalKey<FormState>();
  final _discountController = TextEditingController();
  final _deliveryController = TextEditingController();
  final _vatController = TextEditingController();

  @override
  void dispose() {
    _discountController.dispose();
    _deliveryController.dispose();
    _vatController.dispose();
    super.dispose();
  }

  late OrderProvider orderProvider;
  @override
  void didChangeDependencies() {
    orderProvider = Provider.of<OrderProvider>(context);
    _deliveryController.text = orderProvider.orderConstantModel.deliveryCharge.toString();
    _discountController.text = orderProvider.orderConstantModel.discount.toString();
    _vatController.text = orderProvider.orderConstantModel.vat.toString();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Setting"),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: ListView(
            shrinkWrap: true,
            children: [
              TextFormField(
                keyboardType: TextInputType.number,
                controller: _discountController,
                decoration: const InputDecoration(
                  labelText: 'Discount',
                  prefixIcon: Icon(Icons.discount),
                  filled: true,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please fill up this field";
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                controller: _deliveryController,
                decoration: const InputDecoration(
                  labelText: 'Delivery',
                  prefixIcon: Icon(Icons.delivery_dining),
                  filled: true,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please fill up this field";
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                controller: _vatController,
                decoration: const InputDecoration(
                  labelText: 'Tax',
                  prefixIcon: Icon(Icons.attach_money),
                  filled: true,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please fill up this field";
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  onPressed: () {
                    _update();
                  },
                  child: const Text("Update")),
            ],
          ),
        ),
      ),
    );
  }

  void _update() {
    if (_formKey.currentState!.validate()) {
      EasyLoading.show(status: 'please wait', dismissOnTap: false);
      final model = OrderConstantModel(
        discount: num.parse(_discountController.text),
        deliveryCharge: num.parse(_deliveryController.text),
        vat: num.parse(_vatController.text),
      );
      orderProvider.updateOrderConstants(model).then((value) {
        EasyLoading.dismiss();
        showMsg(context, ' Updated');
      }).catchError((error) {
        EasyLoading.dismiss();
        showMsg(context, 'Failed Update');
      });
    }
  }
}
