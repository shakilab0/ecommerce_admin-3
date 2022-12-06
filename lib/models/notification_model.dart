
import 'comment_model.dart';
import 'order_model.dart';
import 'user_model.dart';

const String collectionNotification = 'Notifications';

const String notificationFieldId = 'notificationId';
const String notificationFieldType = 'type';
const String notificationFieldMessage = 'Message';
const String notificationFieldStatus = 'status';
const String notificationFieldComment = 'comment';
const String notificationFieldUser = 'user';
const String notificationFieldOrder = 'order';

class NotificationModel {
  String id;
  String type;
  String message;
  bool status;
  CommentModel? commentModel;
  UserModel? userModel;
  OrderModel? orderModel;

  NotificationModel({
    required this.id,
    required this.type,
    required this.message,
    this.status = false,
    this.commentModel,
    this.userModel,
    this.orderModel,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      notificationFieldId: id,
      notificationFieldType: type,
      notificationFieldMessage: message,
      notificationFieldStatus: status,
      notificationFieldComment: commentModel?.toMap(),
      notificationFieldUser: userModel?.toMap(),
      notificationFieldOrder: orderModel?.toMap(),
    };
  }

  factory NotificationModel.fromMap(Map<String, dynamic> map) =>
      NotificationModel(
        id: map[notificationFieldId],
        type: map[notificationFieldType],
        message: map[notificationFieldMessage],
        status: map[notificationFieldStatus],
        commentModel: map[notificationFieldComment] == null
            ? null
            : CommentModel.fromMap(map[notificationFieldComment]),
        userModel: map[notificationFieldUser] == null
            ? null
            : UserModel.fromMap(map[notificationFieldUser]),
        orderModel: map[notificationFieldOrder] == null
            ? null
            : OrderModel.fromMap(map[notificationFieldOrder]),
      );
}
