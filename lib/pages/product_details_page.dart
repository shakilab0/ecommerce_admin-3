import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecom_admin_3/models/product_model.dart';
import 'package:ecom_admin_3/pages/product_repurchase_page.dart';
import 'package:ecom_admin_3/providers/product_provider.dart';
import 'package:ecom_admin_3/utils/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductDetailsPage extends StatefulWidget {
  static const String routeName="/product_details_page";
   ProductDetailsPage({Key? key}) : super(key: key);

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  late ProductModel productModel;

  late ProductProvider productProvider;
  @override
  void didChangeDependencies() {
    productProvider=Provider.of<ProductProvider>(context,listen: false);
    productModel=ModalRoute.of(context)!.settings.arguments as ProductModel;

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(productModel.productName),
      ),
      body: ListView(
        children: [
          CachedNetworkImage(
            width: double.infinity,
            height: 200,
            fit: BoxFit.cover,
            imageUrl: productModel.thumbnailImageModel.imageDownloadUrl,
            placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              OutlinedButton(
                  onPressed: ()=>Navigator.pushNamed(context, ProductRepurchasePage.routeName,arguments: productModel),
                  child: const Text("Re-Purchase"),
              ),
              OutlinedButton(
                  onPressed: (){
                    _showPurchaseHistory();
                  },
                  child: const Text("Purchase History"),
              ),
            ],
          ),
          SwitchListTile(
              value: productModel.available,
              onChanged: (value){},
            title: const Text("Available"),
          )
        ],
      ),
    );
  }

  void _showPurchaseHistory() {
    showModalBottomSheet(
        constraints: const BoxConstraints(),
        enableDrag: true,
        isDismissible: true,
        context: context,
        builder: (context){
          final purchaseList=productProvider.getPurchasesByProductId(productModel.productId!);
          return ListView.builder(
              itemCount: purchaseList.length,
              itemBuilder: (context,index){
                final purchaseModel=purchaseList[index];
                return ListTile(
                  title: Text(getFormattedDate(purchaseModel.dateModel.timestamp.toDate())),
                  subtitle: Text('BDT ${purchaseModel.purchasePrice}'),
                  trailing: Text("Quantity: ${purchaseModel.purchaseQuantity}"),
                );
              }
          );
        }
    );
  }
}
