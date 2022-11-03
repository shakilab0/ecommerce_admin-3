
const String imageFieldProductId="productId";
const String imageFieldTitle="title";
const String imageFieldUrl="imageUrl";

class ImageModel{
  String? productId;
  String title;
  String imageDownloadUrl;

  ImageModel({
    this.productId,
    required this.title,
    required this.imageDownloadUrl
  });

  Map<String,dynamic>toMap(){
    return <String,dynamic>{
      imageFieldProductId:productId,
      imageFieldTitle:title,
      imageFieldUrl:imageDownloadUrl,

    };
  }

  factory ImageModel.fromMap(Map<String,dynamic>map)=>ImageModel(
    productId: map[imageFieldProductId],
    title: map[imageFieldTitle],
    imageDownloadUrl: map[imageFieldUrl],
  );



}