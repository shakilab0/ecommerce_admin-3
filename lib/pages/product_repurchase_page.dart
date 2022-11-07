import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecom_admin_3/models/date_model.dart';
import 'package:ecom_admin_3/models/product_model.dart';
import 'package:ecom_admin_3/models/purchase_model.dart';
import 'package:ecom_admin_3/providers/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

import '../utils/helper_function.dart';

class ProductRepurchasePage extends StatefulWidget {
  static const String routeName="/product_repurchase_page";
  const ProductRepurchasePage({Key? key}) : super(key: key);

  @override
  State<ProductRepurchasePage> createState() => _ProductRepurchasePageState();
}

class _ProductRepurchasePageState extends State<ProductRepurchasePage> {

  late ProductModel productModel;
  final _formKey = GlobalKey<FormState>();

  final _purchaseController=TextEditingController();
  final _quantityController=TextEditingController();
  DateTime?purchaseDate;
  @override
  void dispose() {
    _purchaseController.dispose();
    _quantityController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
     productModel = ModalRoute.of(context)!.settings.arguments as ProductModel;
    super.didChangeDependencies();
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Repurchase"),
      ),
      body: Center(
        child: Form(
          key:_formKey,
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              Text(productModel.productName,style: Theme.of(context).textTheme.headline4,),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  controller:_purchaseController,
                  decoration:const InputDecoration(
                    labelText: 'Purchase price',
                    prefixIcon: Icon(Icons.money),
                    filled: true,
                  ) ,
                  validator: (value){
                    if(value==null || value.isEmpty){
                      return "Please fill up this field";
                    }
                    if(num.parse(value)<=0){
                      return "price should be geter then 0";
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 10,),
              //Quientity
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  controller:_quantityController ,
                  decoration:const InputDecoration(
                    labelText: 'quantity',
                    prefixIcon: Icon(Icons.money),
                    filled: true,
                  ) ,
                  validator: (value){
                    if(value==null || value.isEmpty){
                      return "Please fill up this field";
                    }
                    if(num.parse(value)<=0){
                      return "price should be geter then 0";
                    }
                    return null;
                  },
                ),
              ),

              Card(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton.icon(onPressed: (){
                      _selectDate();
                    },
                      label: const Text("Select Date"),
                      icon: const Icon(Icons.calendar_month),
                    ),
                    Text(purchaseDate==null? "no date chosen": getFormattedDate(purchaseDate!)),
                  ],
                ),
              ),
              OutlinedButton(
                  onPressed: (){
                    _repurchase();
                  },
                  child: const Text("Re-Purchase")
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _selectDate()async {
    final date=await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(DateTime.now().year-1),
      lastDate: DateTime.now(),
    );
    if(date!=null){
      setState(() {
        purchaseDate=date;
      });
    }
  }

  void _repurchase() {
    if(purchaseDate==null){
      showMsg(context, "Please select purchase");
      return ;
    }
    if(_formKey.currentState!.validate()){
      EasyLoading.show(status: "please Wait");
      final purchaseModel=PurchaseModel(
        productId: productModel.productId,
        purchasePrice:num.parse(_purchaseController.text),
        purchaseQuantity:num.parse(_quantityController.text),
        dateModel:DateModel(
          timestamp: Timestamp.fromDate(purchaseDate!),
          day: purchaseDate!.day,
          month: purchaseDate!.month,
          year: purchaseDate!.year,
        ),
      );
      Provider.of<ProductProvider>(context,listen: false).repurchase(purchaseModel,productModel)
        .then((value) {
          EasyLoading.dismiss();
        Navigator.pop(context);
      }).catchError((error){
        EasyLoading.dismiss();
        showMsg(context, "Failed to save");
      });
    }
  }
  
}
