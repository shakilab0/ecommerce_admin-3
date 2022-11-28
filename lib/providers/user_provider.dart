
import 'package:flutter/material.dart';

import '../db/db_helper.dart';
import '../models/user_model.dart';

class UserProvider extends ChangeNotifier {
  Future<bool> doesUserExist(String uid) => DbHelper.doesUserExist(uid);
  List<UserModel> userList = [];

  getAllUsers() {
    DbHelper.getAllUsers().listen((snapshot) {
      userList = List.generate(snapshot.docs.length,
          (index) => UserModel.fromMap(snapshot.docs[index].data()));
      notifyListeners();
    });
  }
}
