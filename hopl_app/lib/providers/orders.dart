import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:hopl_app/providers/order.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserOrder {
  String orderId;
  String shopId;
  List<Product> products;
  double totalPrice;
  String createdAt;
  bool confirm;

  UserOrder({
    required this.orderId,
    required this.shopId,
    required this.products,
    required this.totalPrice,
    required this.createdAt,
    required this.confirm,
  });
}

class Product {
  final String userProductId;
  final String name;
  final String productId;
  final String orderId;
  final int quantity;
  final double price;
  final String imgUrl;
  bool confirm = false;

  Product(
      {required this.userProductId,
      required this.name,
      required this.productId,
      required this.orderId,
      required this.quantity,
      required this.price,
      required this.imgUrl,
      required this.confirm});
}

class Orders with ChangeNotifier {
  List<UserOrder> _items = [];

  List<UserOrder> get getItems {
    return _items;
  }

  Future<List<UserOrder>> onLoad() async {
    var client = Client();
    final prefs = await SharedPreferences.getInstance();
    String domainUri = prefs.get("hopl_backend_uri") as String;
    var token = prefs.getString("hopl_accessToken");
    try {
      var orderRes = await client.post(
          Uri.parse("$domainUri/api/logged-user/user-order"),
          body: json.encode({"method": "LIST"}),
          headers: {
            "Content-Type": "application/json",
            "authorization": "Bearer hopl $token"
          });

      if (orderRes.statusCode != 200) {
        throw orderRes.body;
      }
      var parsedOrderBody = json.decode(orderRes.body);

      _items.clear();
      parsedOrderBody.forEach((order) {
        var tempOrder = UserOrder(
            confirm: order["confirm"],
            createdAt: order["createdAt"],
            orderId: order["_id"],
            shopId: order["shopId"],
            products: [],
            totalPrice: 0);

        _items.add(tempOrder);
      });
    } catch (e) {
      print(e);
    } finally {
      client.close();
      notifyListeners();
      return _items;
    }
  }
}
