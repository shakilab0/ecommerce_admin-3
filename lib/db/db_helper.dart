import 'package:cloud_firestore/cloud_firestore.dart';

class DbHelper{
  static const String collectionAdmin='Admins';
  static final _db=FirebaseFirestore.instance;

  static Future<bool>isAdmin(String uid)async{
    final snapshort=await _db.collection(collectionAdmin).doc(uid).get();
    return snapshort.exists;
  }

}