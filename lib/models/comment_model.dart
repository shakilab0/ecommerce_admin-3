const String collectionComment='Comment';

const String commentFieldId='commentId';
const String commentFieldUserId='userId';
const String commentFieldProductId='productId';
const String commentFieldComment='comment';
const String commentFieldApproved='approved';

class CommentModel{
  String commentId;
  String userId;
  String productId;
  String comment;
  bool approved;

  CommentModel({
    required this.commentId,
    required this.userId,
    required this.productId,
    required this.comment,
    this.approved=false,
  });

  Map<String,dynamic>toMap(){
    return <String,dynamic>{
      commentFieldId:commentId,
      commentFieldUserId:userId,
      commentFieldProductId:productId,
      commentFieldComment:comment,
    };
  }

  factory CommentModel.fromMap(Map<String,dynamic>map)=>CommentModel(
    commentId: map[commentFieldId],
    userId: map[commentFieldUserId],
    productId: map[commentFieldProductId],
    comment: map[commentFieldComment],
  );

}