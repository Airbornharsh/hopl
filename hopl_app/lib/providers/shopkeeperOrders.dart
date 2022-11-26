import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:hopl_app/models/userProduct.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserData {
  String name;
  int phoneNumber;
  String address;
  String imgUrl;
  String createdAt;

  UserData({
    required this.name,
    required this.phoneNumber,
    required this.address,
    required this.imgUrl,
    required this.createdAt,
  });
}

class ShopkeeperOrder {
  UserData user;
  String userId;
  String orderId;
  String shopId;
  List<shopkeeperUserProduct> products;
  double totalPrice;
  String createdAt;
  bool confirm;

  ShopkeeperOrder({
    required this.user,
    required this.userId,
    required this.orderId,
    required this.shopId,
    required this.products,
    required this.totalPrice,
    required this.createdAt,
    required this.confirm,
  });
}

class ShopkeeperOrders with ChangeNotifier {
  List<ShopkeeperOrder> _items = [];

  List<ShopkeeperOrder> get getItems {
    return _items;
  }

  void onLoad(String shopId) async {
    var client = Client();
    final prefs = await SharedPreferences.getInstance();
    String domainUri = prefs.get("hopl_backend_uri") as String;
    try {
      var token = prefs.getString("hopl_accessToken");
      var orderRes = await client.post(
          Uri.parse("$domainUri/api/shopkeeper/user/order/list"),
          body: json.encode({"method": "LIST", "shopId": shopId}),
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
        _items.add(ShopkeeperOrder(
            user: UserData(
                name: "name",
                phoneNumber: 7637673675,
                address: "Near this College,That City,765034",
                imgUrl:
                    "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png",
                createdAt: "createdAt"),
            userId: order["userId"],
            orderId: order["_id"],
            shopId: order["shopId"],
            products: [],
            totalPrice: 0,
            createdAt: "created At",
            // createdAt: order["createdAt"],
            confirm: false));
      });
    } catch (e) {
      print(e);
    } finally {
      client.close();
      notifyListeners();
    }
  }

  Future<ShopkeeperOrder> onOrderLoad(String orderId) async {
    ShopkeeperOrder orderData = ShopkeeperOrder(
        user: UserData(
            name: "",
            phoneNumber: 00000000000,
            address: "",
            imgUrl:
                "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png",
            createdAt: "createdAt"),
        userId: "",
        orderId: "",
        shopId: "",
        products: [],
        totalPrice: 0,
        createdAt: "",
        confirm: false);

    var client = Client();
    final prefs = await SharedPreferences.getInstance();
    String domainUri = prefs.get("hopl_backend_uri") as String;
    var token = prefs.getString("hopl_accessToken");
    try {
      var userRes = await client.post(
          Uri.parse("$domainUri/api/shopkeeper/user/profile"),
          body: json.encode({"method": "GET", "orderId": orderId}),
          headers: {
            "Content-Type": "application/json",
            "authorization": "Bearer hopl $token"
          });

      if (userRes.statusCode != 200) {
        throw userRes.body;
      }

      var parsedUserBody = json.decode(userRes.body);

      var tempUser = UserData(
          name: parsedUserBody["name"],
          phoneNumber: parsedUserBody["phoneNumber"],
          address: parsedUserBody["address"],
          imgUrl: parsedUserBody["imgUrl"],
          createdAt: parsedUserBody["createdAt"]);

      orderData.user = tempUser;

      var productsRes = await client.post(
          Uri.parse("$domainUri/api/shopkeeper/user/order/product/list"),
          body: json.encode({"orderId": orderId, "method": "LIST"}),
          headers: {
            "Content-Type": "application/json",
            "authorization": "Bearer hopl $token"
          });

      if (productsRes.statusCode != 200) {
        throw productsRes.body;
      }

      var parsedProductBody = json.decode(productsRes.body);

      _items.firstWhere((item) {
        if (item.orderId == orderId) {
          item.products.clear();
          item.totalPrice = 0;
          parsedProductBody.every((product) {
            item.products.add(shopkeeperUserProduct(
                userProductId: product["_id"],
                name: product["name"],
                productId: product["productId"],
                orderId: product["orderId"],
                quantity: product["quantity"],
                price: product["price"].toDouble(),
                imgUrl:
                    "https://images.unsplash.com/photo-1604719312566-8912e9227c6a?ixlib=rb-…",
                confirm: product["confirm"]));
            item.totalPrice += product["price"] * product["quantity"];
            return true;
          });
          return true;
        }
        return false;
      });

      orderData = _items.firstWhere((i) {
        if (i.orderId == orderId) {
          i.user = tempUser;
          return true;
        }
        return false;
      });
    } catch (e) {
      print(e);
    } finally {
      client.close();
      notifyListeners();
    }

    return orderData;
  }

  Future<bool> confirmOrder(String userProductId) async {
    bool response = false;
    var client = Client();
    final prefs = await SharedPreferences.getInstance();
    String domainUri = prefs.get("hopl_backend_uri") as String;
    var token = prefs.getString("hopl_accessToken");
    try {
      var res = await client.post(
          Uri.parse("$domainUri/api/shopkeeper/user/order/product/confirm"),
          body: json.encode({"userProductId": userProductId}),
          headers: {
            "Content-Type": "application/json",
            "authorization": "Bearer hopl $token"
          });

      if (res.statusCode != 200) {
        throw res.body;
      }

      // var parsedBody = json.decode(res.body);

      response = true;

      return true;
    } catch (e) {
      print(e);
    } finally {
      client.close();
      notifyListeners();
    }

    return response;
  }
}
