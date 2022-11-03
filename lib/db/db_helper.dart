import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecom_admin_3/models/category_model.dart';
import 'package:ecom_admin_3/models/product_model.dart';
import 'package:ecom_admin_3/models/purchase_model.dart';

class DbHelper{
  static const String collectionAdmin='Admins';
  static final _db=FirebaseFirestore.instance;

  static Future<bool>isAdmin(String uid)async{
    final snapshort=await _db.collection(collectionAdmin).doc(uid).get();
    return snapshort.exists;
  }

  static Future<void>addCategory(CategoryModel categoryModel){
    final catDoc=_db.collection(collectionCategory).doc();
    categoryModel.categoryId=catDoc.id;
    return catDoc.set(categoryModel.toMap());
  }


  static Future<void> addNewProduct(ProductModel productModel, PurchaseModel purchaseModel) {
    final wb=_db.batch();
    final productDoc=_db.collection(collectionProduct).doc();
    final purchaseDoc=_db.collection(collectionPurchase).doc();
    productModel.productId=productDoc.id;
    purchaseModel.productId=productDoc.id;
    purchaseModel.purchaseId=purchaseDoc.id;
    wb.set(productDoc, productModel.toMap());
    wb.set(purchaseDoc, purchaseModel.toMap());
    final updatedCount=purchaseModel.purchaseQuantity+productModel.category.productCount;
    final catDoc=_db.collection(collectionCategory).doc(productModel.category.categoryId);
    wb.update(catDoc, {categoryFieldProductCount:updatedCount});
    return wb.commit();


  }


  static Stream<QuerySnapshot<Map<String,dynamic>>>getAllCategory()=>
      _db.collection(collectionCategory).snapshots();

}