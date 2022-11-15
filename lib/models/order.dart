import 'package:kasrzero_flutter/models/user_data.dart';

class BuyingOrder {
  String buyerId;
  String sellerId;
  String productId;
  int productPrice;
  int profit;
  int shipping;
  UserAddress addressto;
  String paymentmethod;
  BuyingOrder({
    required this.addressto,
    required this.buyerId,
    required this.productId,
    required this.productPrice,
    required this.profit,
    required this.sellerId,
    required this.shipping,
    required this.paymentmethod
  });
}

class ExchangingOrder {
  String buyerId;
  String sellerId;
  String productId;
  int productPrice;
  int profit;
  int shipping;
  UserAddress addressto;
  bool exchangable;
  ExchangeProperties exchangeProperties;
  String paymentmethod;

  ExchangingOrder({
    required this.addressto,
    required this.buyerId,
    required this.exchangable,
    required this.exchangeProperties,
    required this.productId,
    required this.productPrice,
    required this.profit,
    required this.sellerId,
    required this.shipping,
    required this.paymentmethod
  });
}

class ExchangeProperties {
  String productId;
  int productPrice;
  int profit;
  int shipping;
  String paymentmethod;

  ExchangeProperties({
    required this.productId,
    required this.paymentmethod,
    required this.productPrice,
    required this.profit,
    required this.shipping,
  });
}
