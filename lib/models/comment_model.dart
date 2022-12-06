import 'package:ecom_admin_3/models/user_model.dart';

const String collectionComment='Comment';

const String commentFieldId='commentId';
const String commentFieldUserModel = 'userModel';
const String commentFieldUserId='userId';
const String commentFieldProductId='productId';
const String commentFieldComment='comment';
const String commentFieldDate = 'date';
const String commentFieldApproved='approved';

class CommentModel{
  String commentId;
  UserModel userModel;
  String productId;
  String comment;
  bool approved;
  String date;

  CommentModel({
    required this.commentId,
    required this.userModel,
    required this.productId,
    required this.comment,
    required this.date,
    this.approved=false,
  });

  Map<String,dynamic>toMap(){
    return <String,dynamic>{
      commentFieldId:commentId,
      commentFieldUserModel: userModel.toMap(),
      commentFieldProductId:productId,
      commentFieldDate: date,
      commentFieldComment:comment,
    };
  }

  factory CommentModel.fromMap(Map<String,dynamic>map)=>CommentModel(

    commentId: map[commentFieldId],
    userModel: UserModel.fromMap(map[commentFieldUserModel]),
    comment: map[commentFieldComment],
    productId: map[commentFieldProductId],
    date: map[commentFieldDate],
  );

}