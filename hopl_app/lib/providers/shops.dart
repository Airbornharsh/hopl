import 'dart:convert';

import "package:http/http.dart";
import 'package:flutter/cupertino.dart';
import 'package:hopl_app/models/shop.dart';
import 'package:hopl_app/models/shopItem.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Shops with ChangeNotifier {
  final List<Shop> _items = [];

  final List<Map<String, Object>> _shopProducts = [
    {"shopId": "", "productIds": []}
  ];

  List<Shop> get items {
    return _items;
  }

  Future<List<Shop>> onLoad() async {
    var client = Client();
    final prefs = await SharedPreferences.getInstance();
    String domainUri = prefs.get("hopl_backend_uri") as String;
    try {
      var shopRes = await client.get(Uri.parse("$domainUri/api/user/shop-list"),
          headers: {"Content-Type": "application/json"});

      if (shopRes.statusCode != 200) {
        throw shopRes.body;
      }

      var parsedShopBody = json.decode(shopRes.body);

      _items.clear();
      parsedShopBody.forEach((shop) {
        _items.add(Shop(
            shopName: shop["name"] as String,
            description: shop["description"] as String,
            shopId: shop["_id"] as String,
            rating: 3,
            category: shop["category"] as String,
            items: [],
            imgUrl:
                "https://images.unsplash.com/photo-1604719312566-8912e9227c6a?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1074&q=80"));

        _shopProducts.add(
            {"shopId": shop["_id"] as String, "productIds": shop["products"]});
      });
    } catch (e) {
      print(e);
    } finally {
      client.close();
      notifyListeners();
    }

    return _items;
  }

  Future<Shop> onShopLoad(String shopId) async {
    Shop shopData = Shop(
        shopName: "",
        description: "",
        shopId: shopId,
        rating: 0,
        category: "",
        items: [],
        imgUrl:
            "https://images.unsplash.com/photo-1604719312566-8912e9227c6a?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1074&q=80");
    var client = Client();
    final prefs = await SharedPreferences.getInstance();
    String domainUri = prefs.get("hopl_backend_uri") as String;
    try {
      var productsRes = await client.post(
          Uri.parse("$domainUri/api/user/shop-list/product-list"),
          body: json.encode({"shopId": shopId}),
          headers: {"Content-Type": "application/json"});

      if (productsRes.statusCode != 200) {
        throw productsRes.body;
      }

      var products = json.decode(productsRes.body);

      _items.firstWhere((shop) {
        if (shop.shopId == shopId) {
          shopData = shop;
          shop.items.clear();
          products.forEach((product) {
            shop.items.add(ShopItem(
                name: product["name"],
                price: product["price"].toDouble(),
                stockQuantity: product["quantity"],
                imgUrl:
                    "https://images.unsplash.com/photo-1613919113640-25732ec5e61f?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80",
                category: product["category"],
                productId: product["_id"],
                shopId: product["shopId"]));
          });

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
    return shopData;
  }

  Shop filterById(String shopId) {
    Shop shopData = _items.firstWhere((shop) => shop.shopId == shopId);
    return shopData;
  }
}
