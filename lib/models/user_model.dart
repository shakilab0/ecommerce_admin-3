import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecom_admin_3/models/address_model.dart';

const String collectionUser='User';

const String userFieldId='userId';
const String userFieldDisplayName='displayName';
const String userFieldAddressModel='addressModel';
const String userFieldCreationTime='CreationTime';
const String userFieldGender='gender';
const String userFieldAge='age';
const String userFieldPhone='phone';
const String userFieldEmail='email';


class UserModel{
String? userId;
String? displayName;
AddressModel? addressModel;
Timestamp? userCreationTime;
String? gender;
String? age;
String? phone;
String email;

  UserModel({
        this.userId,
        this.displayName,
        this.addressModel,
        this.userCreationTime,
        this.gender,
        this.age,
        this.phone,
        required this.email
  });

  Map<String,dynamic>toMap(){
    return <String,dynamic>{
      userFieldId:userId,
      userFieldDisplayName:displayName,
      userFieldAddressModel:addressModel?.toMap(),
      userFieldCreationTime:userCreationTime,
      userFieldGender:gender,
      userFieldAge:age,
      userFieldPhone:phone,
      userFieldEmail:email,
    };
  }
  factory UserModel.fromMap(Map<String,dynamic>map)=>UserModel(
    userId: map[userFieldId],
    displayName: map[userFieldDisplayName],
    addressModel:map[userFieldAddressModel]==null ? null:AddressModel.fromMap(map[userFieldAddressModel]),
    userCreationTime: map[userFieldCreationTime],
    gender: map[userFieldGender],
    age: map[userFieldAge],
    phone: map[userFieldPhone],
    email: map[userFieldEmail],
  );
}