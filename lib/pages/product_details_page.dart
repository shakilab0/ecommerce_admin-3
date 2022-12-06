import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecom_admin_3/customwidgets/photo_frame_view.dart';
import 'package:ecom_admin_3/models/product_model.dart';
import 'package:ecom_admin_3/pages/product_repurchase_page.dart';
import 'package:ecom_admin_3/providers/product_provider.dart';
import 'package:ecom_admin_3/utils/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../models/comment_model.dart';
import '../models/image_model.dart';
import '../utils/constants.dart';

class ProductDetailsPage extends StatefulWidget {
  static const String routeName="/product_details_page";
   const ProductDetailsPage({Key? key}) : super(key: key);

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {

  late ProductModel productModel;
  late ProductProvider productProvider;
  late Size size;
  @override
  void didChangeDependencies() {
    // as String?;

    size=MediaQuery.of(context).size;
    productProvider=Provider.of<ProductProvider>(context,listen: false);
    final object=ModalRoute.of(context)!.settings.arguments;
    if(object is String){
      productModel=productProvider.getProductByIdFromCache(object);
    }else{
      productModel=object as ProductModel;
    }

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
          SizedBox(
            height: 90,
            child:Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                PhotoFrameView(
                  onImagePresed: (){
                    _showImageInDialog(0);
                  },
                  url: productModel.additionalImageModels[0],
                  child:IconButton(
                      onPressed: (){
                        _addImage(0);
                      },
                      icon: const Icon(Icons.add_a_photo,size: 30,)
                  ),
                ),
                PhotoFrameView(
                  url: productModel.additionalImageModels[1],
                  onImagePresed: (){
                    _showImageInDialog(1);
                  },
                  child:IconButton(
                      onPressed: (){
                        _addImage(1);
                      },
                      icon: const Icon(Icons.add_a_photo,size: 30,)
                  ),
                ),
                PhotoFrameView(
                  url: productModel.additionalImageModels[2],
                  onImagePresed: (){
                    _showImageInDialog(2);
                  },
                  child:IconButton(
                      onPressed: (){
                        _addImage(2);
                      },
                      icon: const Icon(Icons.add_a_photo,size: 30,)
                  ),
                ),


              ],
            ) ,
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
          ListTile(
            title: Text(productModel.productName),
            subtitle: Text(productModel.category.categoryName),
          ),
          ListTile(
            title: Text('Sale Price: $currencySymbol${productModel.salePrice}'),
            subtitle: Text('Discount: ${productModel.productDiscount}%'),
            trailing: Text(
                '$currencySymbol${productProvider.priceAfterDiscount(productModel.salePrice, productModel.productDiscount)}'),
          ),
          SwitchListTile(
              value: productModel.available,
              onChanged: (value){
                setState(() {
                  productModel.available=!productModel.available;
                });
                productProvider.updateProductField(productModel.productId!, productFieldAvailable, productModel.available);

              },
            title: const Text("Available"),
          ),
          SwitchListTile(
            value: productModel.featured,
            onChanged: (value){
              setState(() {
                productModel.featured=!productModel.featured;
              });
              productProvider.updateProductField(productModel.productId!, productFieldFeatured, productModel.featured);

            },
            title: const Text("Featured"),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('All Comments'),
          ),
          FutureBuilder<List<CommentModel>>(
              future: productProvider.getCommentsByProduct(productModel.productId!),
              builder: (context,snapshot){
                if(snapshot.hasData){
                  final commentList=snapshot.data!;
                  if(commentList.isEmpty){
                    return const Center(child: Text("No Comment found"),);
                  }else{
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: commentList.map((comment) => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            title: Text(comment.userModel.displayName ?? comment.userModel.email),
                            subtitle: Text(comment.date),
                            leading: comment.userModel.imageUrl == null
                                ? const Icon(Icons.person)
                                : CachedNetworkImage(
                              width: 70,
                              height: 100,
                              fit: BoxFit.fill,
                              imageUrl: comment.userModel.imageUrl!,
                              placeholder: (context, url) => const Center(
                                  child: CircularProgressIndicator()),
                              errorWidget: (context, url, error) => const Icon(Icons.error),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: Text(
                              comment.comment,
                            ),
                          ),
                          OutlinedButton(
                              onPressed:comment.approved ? null :(){
                                _approveComment(comment);
                              } ,
                              child: const Text('Approve this comment'),
                          ),
                        ],
                      )).toList(),
                    );
                  }
                }
                if(snapshot.hasError){
                  return const Text("Failed to load Comment");
                }
                return const Center(child: Text("Loading comments"));
              }
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

  void _addImage(int index)async {
    final selectedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if(selectedFile!=null){
      EasyLoading.show(status: 'please Wait');
      final imageModel = await productProvider.upLoadImage(selectedFile.path);
      final previousImageList=productModel.additionalImageModels;
      previousImageList[index]=imageModel.imageDownloadUrl;
      productProvider.updateProductField(productModel.productId!, productFieldImages, previousImageList)
          .then((value) {
            setState(() {
              productModel.additionalImageModels[index]=imageModel.imageDownloadUrl;
            });
        showMsg(context, "Uploaded");
        EasyLoading.dismiss();
      })
          .catchError((error){
        showMsg(context, "failed Uploaded");
        EasyLoading.dismiss();

      });
    }
  }

  void _showImageInDialog(int i) {
    final url=productModel.additionalImageModels[i];
    showDialog(context: context, builder: (context)=>AlertDialog(
      content: CachedNetworkImage(
        //width: double.infinity,
        height: size.height/2,
        fit: BoxFit.cover,
        imageUrl: url,
        placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
        errorWidget: (context, url, error) => const Icon(Icons.error),
      ),
      actions: [

        // error asa akto
        TextButton(
            onPressed: () async{
              Navigator.pop(context);
              final selectedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
              EasyLoading.show(status: 'please Wait');

              if(selectedFile!=null) {
                final imageModel = await productProvider.upLoadImage(
                    selectedFile.path);
                productModel.additionalImageModels[i] =
                    imageModel.imageDownloadUrl;


                print('object');
                await productProvider.updateProductField(
                    productModel.productId!,
                    productFieldImages,
                    productModel.additionalImageModels
                );
                await productProvider.deleteImage(url);
                EasyLoading.dismiss();
                if(mounted)showMsg(context, " Updated");

              }
              else{
                EasyLoading.dismiss();
                showMsg(context, "Failed to Update");
              return;
              }
            },
            child:const Text("Change")
        ),

        TextButton(
            onPressed: () async{
              Navigator.pop(context);
              EasyLoading.show(status: "Deleting image");
              setState(() {
                productModel.additionalImageModels[i]='';
              });
              try{
                await productProvider.deleteImage(url);
                await productProvider.updateProductField(
                    productModel.productId!,
                    productFieldImages,
                    productModel.additionalImageModels
                );
                EasyLoading.dismiss();
                if(mounted)showMsg(context, " Deleted");

              }catch(error){
                EasyLoading.dismiss();
                showMsg(context, "Failed to Delete");
              }
            },
            child:const Text("Delete")
        ),
      ],
    ));
  }

  void _approveComment(CommentModel commentModel) async {
    EasyLoading.show(status: "Please wait");
    await productProvider.approveComment(productModel.productId!,commentModel);
    EasyLoading.dismiss();
    showMsg(context, 'comment approved');
    setState(() {

    });

  }


}


