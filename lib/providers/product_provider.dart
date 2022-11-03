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

}