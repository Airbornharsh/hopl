import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Product {
  String productId;
  String name;
  String description;
  int quantity;
  double price;
  String category;
  String imgUrl;

  Product({
    required this.productId,
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

      _products.clear();
      parsedProductBody.forEach((product) {
        var tempProduct = Product(
            productId: product["_id"],
            name: product["name"],
            description: product["description"],
            quantity: product["quantity"],
            price: product["price"].toDouble(),
            category: product["category"],
            imgUrl: product["imgUrl"]);

        _products.add(tempProduct);
      });
    } catch (e) {
      print(e);
    } finally {
      client.close();
      notifyListeners();
    }
    return _products;
  }

  Future<bool> addProduct(String name, String description, int quantity,
      double price, String category, String imgurl) async {
    var client = Client();
    final prefs = await SharedPreferences.getInstance();
    String domainUri = prefs.get("hopl_backend_uri") as String;
    var token = prefs.getString("hopl_accessToken");
    try {
      var productRes = await client.post(
          Uri.parse("$domainUri/api/shopkeeper/shop/product"),
          body: json.encode({
            "name": name,
            "description": description,
            "quantity": quantity,
            "price": price,
            "category": category,
            "imgUrl": imgurl
          }),
          headers: {
            "Content-Type": "application/json",
            "authorization": "Bearer hopl $token"
          });

      if (productRes.statusCode != 200) {
        return false;
      }

      var parsedProductRes = json.decode(productRes.body);

      var tempProduct = Product(
          productId: parsedProductRes["_id"],
          name: name,
          description: description,
          quantity: quantity,
          price: price,
          category: category,
          imgUrl: imgurl);

      _products.add(tempProduct);
    } catch (e) {
      print(e);
      return false;
    } finally {
      client.close();
      notifyListeners();
    }
    return true;
  }

  Future<bool> editProduct(String productId, String name, String description,
      int quantity, double price, String category, String imgurl) async {
    var client = Client();
    final prefs = await SharedPreferences.getInstance();
    String domainUri = prefs.get("hopl_backend_uri") as String;
    var token = prefs.getString("hopl_accessToken");
    try {
      var productRes = await client.patch(
          Uri.parse("$domainUri/api/shopkeeper/shop/product"),
          body: json.encode({
            "productId": productId,
            "name": name,
            "description": description,
            "quantity": quantity,
            "price": price,
            "category": category,
            "imgUrl": imgurl
          }),
          headers: {
            "Content-Type": "application/json",
            "authorization": "Bearer hopl $token"
          });

      if (productRes.statusCode != 200) {
        return false;
      }

      var parsedProductRes = json.decode(productRes.body);

      _products.firstWhere((product) {
        if (product.productId == productId) {
          product.name = name;
          product.description = description;
          product.quantity = quantity;
          product.price = price;
          product.imgUrl = imgurl;
          product.category = category;
          return true;
        }
        return false;
      });

      // var tempProduct = Product(
      //     name: name,
      //     description: description,
      //     quantity: quantity,
      //     price: price,
      //     category: category,
      //     imgUrl: imgurl);

      // _products.add(tempProduct);
    } catch (e) {
      print(e);
      return false;
    } finally {
      client.close();
      notifyListeners();
    }
    return true;
  }

  Future<bool> deleteProduct(String productId) async {
    var client = Client();
    final prefs = await SharedPreferences.getInstance();
    String domainUri = prefs.get("hopl_backend_uri") as String;
    var token = prefs.getString("hopl_accessToken");
    try {
      var productRes = await client.delete(
          Uri.parse("$domainUri/api/shopkeeper/shop/product"),
          body: json.encode({
            "productId": productId,
          }),
          headers: {
            "Content-Type": "application/json",
            "authorization": "Bearer hopl $token"
          });

      if (productRes.statusCode != 200) {
        return false;
      }

      var parsedProductRes = json.decode(productRes.body);

      _products.removeWhere((product) {
        if (product.productId == productId) {
          return true;
        }
        return false;
      });

    } catch (e) {
      print(e);
      return false;
    } finally {
      client.close();
      notifyListeners();
    }
    return true;
  }
}
