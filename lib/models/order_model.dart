import 'address_model.dart';
import 'cart_model.dart';
import 'date_model.dart';

const String collectionOrder = 'Order';

const String orderFieldOrderId = 'orderId';
const String orderFieldUserId = 'userId';
const String orderFieldGrandTotal = 'grandTotal';
const String orderFieldDiscount = 'discount';
const String orderFieldVat = 'vat';
const String orderFieldDeliveryCharge = 'deliveryCharge';
const String orderFieldOrderStatus = 'orderStatus';
const String orderFieldPaymentMethod = 'payMethod';
const String orderFieldOrderDate = 'orderDate';
const String orderFieldDeliveryAddress = 'deliveryAddress';
const String orderFieldProductDetails = 'productDetails';

class OrderModel {
  String orderId;
  String userId;
  String orderStatus;
  String payMethod;
  num grandTotal;
  num discount;
  num vat;
  num deliveryCharge;
  DateModel orderDate;
  AddressModel deliveryAddress;
  List<CartModel> productDetails;

  OrderModel(
      {required this.orderId,
        required this.userId,
        required this.orderStatus,
        required this.payMethod,
        required this.grandTotal,
        required this.discount,
        required this.vat,
        required this.deliveryCharge,
        required this.orderDate,
        required this.deliveryAddress,
        required this.productDetails});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      orderFieldOrderId: orderId,
      orderFieldUserId: userId,
      orderFieldOrderStatus: orderStatus,
      orderFieldPaymentMethod: payMethod,
      orderFieldGrandTotal: grandTotal,
      orderFieldDiscount: discount,
      orderFieldVat: vat,
      orderFieldDeliveryCharge: deliveryCharge,
      orderFieldOrderDate: orderDate.toMap(),
      orderFieldDeliveryAddress: deliveryAddress.toMap(),
      orderFieldProductDetails: List.generate(
          productDetails.length, (index) => productDetails[index].toMap()),
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) => OrderModel(
    orderId: map[orderFieldOrderId],
    userId: map[orderFieldUserId],
    orderStatus: map[orderFieldOrderStatus],
    payMethod: map[orderFieldPaymentMethod],
    grandTotal: map[orderFieldGrandTotal],
    discount: map[orderFieldDiscount],
    vat: map[orderFieldVat],
    deliveryCharge: map[orderFieldDeliveryCharge],
    orderDate: DateModel.fromMap(map[orderFieldOrderDate]),
    deliveryAddress: AddressModel.fromMap(map[orderFieldDeliveryAddress]),
    productDetails: (map[orderFieldProductDetails] as List)
        .map((e) => CartModel.fromMap(e))
        .toList(),
  );
}
