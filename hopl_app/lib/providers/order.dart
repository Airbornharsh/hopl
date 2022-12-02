import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:hopl_app/models/userProduct.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TempOrder {
  String shopId;
  List<UserProduct> items;
  double totalPrice;

  TempOrder(
      {required this.shopId, required this.items, required this.totalPrice});
}

class Order with ChangeNotifier {
  List<TempOrder> _tempOrders = [];
  late TempOrder tempOrder;

  List<UserProduct> getShopOrders(String shopId) {
    List<UserProduct> tempItems = [];

    if (_tempOrders.isNotEmpty) {
      _tempOrders.firstWhere((tempOrder) {
        if (tempOrder.shopId == shopId) {
          tempItems = tempOrder.items;
          return true;
        }
        return false;
      });
    }

    return tempItems;
  }

  double getTotalPrice(String shopId) {
    double tempPrice = 0;

    _tempOrders.firstWhere((order) {
      if (order.shopId == shopId) {
        tempPrice = order.totalPrice;
        return true;
      }
      return false;
    });

    return tempPrice;
  }

  void createOrder(String shopId) {
    _tempOrders.add(TempOrder(shopId: shopId, items: [], totalPrice: 0));
  }

  void addItem(String shopId, String productId, String name, double price,
      String imageUrl) {
    // if (_tempOrders.isNotEmpty) {
    _tempOrders.firstWhere((tempOrder) {
      if (tempOrder.shopId == shopId) {
        int have = 0;

        int tempOrdersLength = tempOrder.items.length;
        for (int i = 0; i < tempOrdersLength; i++) {
          if (tempOrder.items[i].productId == productId) {
            have = 1;
            tempOrder.items.add(UserProduct(
                shopId: tempOrder.items[i].shopId,
                productId: tempOrder.items[i].productId,
                name: tempOrder.items[i].name,
                quantity: tempOrder.items[i].quantity + 1,
                price: tempOrder.items[i].price,
                imageUrl: tempOrder.items[i].imageUrl));
            tempOrder.items.removeAt(i);
            tempOrder.totalPrice += price;
          }
        }

        if (have == 0) {
          tempOrder.items.add(UserProduct(
              shopId: shopId,
              productId: productId,
              name: name,
              quantity: 1,
              price: price,
              imageUrl: imageUrl));
          tempOrder.totalPrice += price;
        }

        return true;
      }
      return false;
    });
    notifyListeners();
  }

  void removeItem(String shopId, String productId, String name, double price) {
    _tempOrders.firstWhere((tempOrder) {
      if (tempOrder.shopId == shopId) {
        late UserProduct newUserProduct;
        int have = 0;
        tempOrder.items.removeWhere((item) {
          if (item.productId == productId) {
            if (item.quantity > 1) {
              have = 1;
              newUserProduct = UserProduct(
                  shopId: item.shopId,
                  productId: item.productId,
                  name: item.name,
                  quantity: item.quantity - 1,
                  price: item.price,
                  imageUrl: item.imageUrl);
            }
            tempOrder.totalPrice -= price;
            return true;
          }
          return false;
        });

        if (have == 1) {
          tempOrder.items.add(newUserProduct);
        }
        return true;
      }
      return false;
    });
    notifyListeners();
  }

  int getProductQuantity(String shopId, String productId) {
    int quantity = 0;
    if (_tempOrders.isNotEmpty) {
      _tempOrders.firstWhere((tempOrder) {
        if (tempOrder.shopId == shopId) {
          if (tempOrder.items.isNotEmpty) {
            tempOrder.items.firstWhere((UserProduct) {
              if (UserProduct.productId == productId) {
                quantity = UserProduct.quantity;
                return true;
              }
              return false;
            },
                orElse: () => UserProduct(
                    shopId: shopId,
                    productId: productId,
                    name: "",
                    quantity: 0,
                    price: 0,
                    imageUrl: ""));
          }
          return true;
        }
        return false;
      });
    }
    return quantity;
  }

  Future<String> AddOrder(String shopId) async {
    var tempOrder = {"shopId": shopId, "userProducts": []};

    _tempOrders.removeWhere((order) {
      if (order.shopId == shopId) {
        order.items.forEach((product) {
          var tempProduct = {
            "shopId": product.shopId,
            "productId": product.productId,
            "name": product.name,
            "quantity": product.quantity,
            "price": product.price,
            "imgUrl": product.imageUrl,
            "confirm": false
          };
          (tempOrder["userProducts"] as List<dynamic>).add(tempProduct);
        });

        return true;
      }
      return false;
    });

    // print(tempOrder);

    var client = Client();
    final prefs = await SharedPreferences.getInstance();
    String domainUri = prefs.get("hopl_backend_uri") as String;
    var token = prefs.getString("hopl_accessToken");

    var finalResponse;

    try {
      var res = await client.post(
          Uri.parse("$domainUri/api/logged-user/user-order"),
          body: json.encode({
            "shopId": tempOrder["shopId"],
            "userProducts": tempOrder["userProducts"]
          }),
          headers: {
            "Content-Type": "application/json",
            "authorization": "Bearer hopl $token"
          });

      if (res.statusCode != 200) {
        throw res.body;
      }

      var parsedBody = json.decode(res.body);

      finalResponse = parsedBody["status"];
    } catch (e) {
      print(e);
    } finally {
      client.close();
      notifyListeners();
    }
    return finalResponse;
  }

  // int get getLength {
  //   return _items.length;
  // }
}
