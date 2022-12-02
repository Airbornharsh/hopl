import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Product {
  String name;
  String description;
  int quantity;
  double price;
  String category;
  String imgUrl;

  Product({
    required this.name,
    required this.description,
    required this.quantity,
    required this.price,
    required this.category,
    required this.imgUrl,
  });
}

class ShopkeeperShop with ChangeNotifier {
  List<Product> _products = [];

  Future<List<Product>> onLoad() async {
    var client = Client();
    final prefs = await SharedPreferences.getInstance();
    String domainUri = prefs.get("hopl_backend_uri") as String;
    var token = prefs.getString("hopl_accessToken");
    try {
      var productRes = await client.post(
          Uri.parse("$domainUri/api/shopkeeper/shop/product"),
          body: json.encode({"method": "LIST"}),
          headers: {
            "Content-Type": "application/json",
            "authorization": "Bearer hopl $token"
          });

      if (productRes.statusCode != 200) {
        throw productRes.body;
      }

      var parsedProductBody = json.decode(productRes.body);

      print(parsedProductBody);
    } catch (e) {
      print(e);
    } finally {
      client.close();
      notifyListeners();
    }
    return _products;
  }
}
