import 'dart:io';

import 'package:ecom_admin_3/db/db_helper.dart';
import 'package:ecom_admin_3/models/category_model.dart';
import 'package:ecom_admin_3/models/image_model.dart';
import 'package:ecom_admin_3/models/product_model.dart';
import 'package:ecom_admin_3/models/purchase_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';

import '../utils/constants.dart';

class ProductProvider extends ChangeNotifier{
  List<CategoryModel>categoryList=[];
  List<ProductModel>productList=[];

  List<PurchaseModel> purchaseList=[];

  Future<void>addCategory(String category){
    final categoryModel=CategoryModel(categoryName: category);
    return DbHelper.addCategory(categoryModel);
  
  }

  getAllCategory(){
    DbHelper.getAllCategory().listen((snapshot) {
      categoryList=List.generate(snapshot.docs.length, (index) =>
      CategoryModel.fromMap(snapshot.docs[index].data()));
      categoryList.sort((model1,model2)=>model1.categoryName.compareTo(model2.categoryName));
      notifyListeners();
    });
  }

  getAllProducts(){
    DbHelper.getAllProducts().listen((snapshot) {
      productList=List.generate(snapshot.docs.length, (index) =>
          ProductModel.fromMap(snapshot.docs[index].data()));
      notifyListeners();
    });
  }

  getAllPurchase(){
    DbHelper.getAllPurchase().listen((snapshot) {
      purchaseList=List.generate(snapshot.docs.length, (index) =>
          PurchaseModel.fromMap(snapshot.docs[index].data()));
      notifyListeners();
    });
  }


  getAllProductsByCategory(String categoryName){
    DbHelper.getAllProductsByCategory(categoryName).listen((snapshot) {
      productList=List.generate(snapshot.docs.length, (index) =>
          ProductModel.fromMap(snapshot.docs[index].data()));
      notifyListeners();
    });
  }

  List<PurchaseModel> getPurchasesByProductId(String productId){

    return purchaseList.where((element) => element.productId==productId).toList();


  }

  List<CategoryModel>getCategoriesForFiltering(){
    return <CategoryModel>[CategoryModel(categoryName: "All"),
      ...categoryList,
    ];
  }


  Future<ImageModel>upLoadImage(String path)async{
    final imageName='pro_${DateTime.now().millisecondsSinceEpoch}';
    final imageRef=FirebaseStorage.instance.ref().child('$firebaseStorageProductImageDir/$imageName');
    final uploadTask=imageRef.putFile(File(path));
    final snapshot=await uploadTask.whenComplete(() => null);
    final downloadUrl=await snapshot.ref.getDownloadURL();
    return ImageModel(
      title: imageName,
      imageDownloadUrl: downloadUrl,
    );
  }

 Future<void>addNewproduct(ProductModel productModel, PurchaseModel purchaseModel) {
    return DbHelper.addNewProduct(productModel,purchaseModel);
 }

  Future<void> repurchase(PurchaseModel purchaseModel, ProductModel productModel) {
    return DbHelper.repurchase(purchaseModel,productModel);

  }

}