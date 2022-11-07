import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecom_admin_3/models/category_model.dart';
import 'package:ecom_admin_3/pages/product_details_page.dart';
import 'package:ecom_admin_3/providers/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ViewProductPage extends StatefulWidget {
  static const String routeName="/view_product_page";
  const ViewProductPage({Key? key}) : super(key: key);

  @override
  State<ViewProductPage> createState() => _ViewProductPageState();
}

class _ViewProductPageState extends State<ViewProductPage> {

  CategoryModel? categoryModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("All product"),
      ),
      body:Consumer<ProductProvider>(
          builder: (context,provider,child)=> Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: DropdownButtonFormField<CategoryModel>(
                  isExpanded:true,
                  hint: const Text('Select Category'),
                  value: categoryModel,
                  validator: (value){
                    if(value==null ){
                      return "Please select ";
                    }
                    return null;
                  },
                  items: provider.getCategoriesForFiltering().map((catModel)=>DropdownMenuItem(
                      value: catModel,
                      child: Text(catModel.categoryName))).toList(),
                  onChanged: (value){
                    setState(() {
                      categoryModel=value;
                      print(categoryModel!.categoryName);
                    });
                    if(categoryModel!.categoryName=="All"){
                      provider.getAllProducts();
                    }else{
                      provider.getAllProductsByCategory(categoryModel!.categoryName);
                    }
                  }
              ),
            ),
            Expanded(
                child: ListView.builder(
                  itemCount: provider.productList.length,
                    itemBuilder: (context,index){
                    final product=provider.productList[index];
                    return ListTile(
                      onTap: ()=>Navigator.pushNamed(context, ProductDetailsPage.routeName,arguments: product),
                      leading: CachedNetworkImage(
                        width: 50,
                        imageUrl: product.thumbnailImageModel.imageDownloadUrl,
                        placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                        errorWidget: (context, url, error) => const Icon(Icons.error),
                      ),
                      title: Text(product.productName),
                      subtitle: Text(product.category.categoryName),
                      trailing:Text('Stock : ${product.stock}'),
                    );
                    }
                )
            )

          ],
        ),
      ),
    );
  }
}
