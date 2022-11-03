const String collectionRating='Rating';

const String ratingFieldId='ratingId';
const String ratingFieldUserId='userId';
const String ratingFieldProductId='productId';
const String ratingFieldRating='ratingId';

class RatingModel{
  String ratingId;
  String userId;
  String productId;
  num rating;

  RatingModel({
    required this.ratingId,
    required this.userId,
    required this.productId,
    required this.rating
  });



  Map<String,dynamic>toMap(){
    return <String,dynamic>{
      ratingFieldId:ratingId,
      ratingFieldUserId:userId,
      ratingFieldProductId:productId,
      ratingFieldRating:rating,
    };
  }

  factory RatingModel.fromMap(Map<String,dynamic>map)=>RatingModel(
    ratingId: map[ratingFieldId],
    userId: map[ratingFieldUserId],
    productId: map[ratingFieldProductId],
    rating: map[ratingFieldRating],
  );


}


