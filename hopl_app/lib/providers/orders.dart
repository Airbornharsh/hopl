import 'package:flutter/cupertino.dart';

class Order {
  final String shopId;
  final String productId;
  final String name;
  final int quantity;
  final double price;
  final String imageUrl;

  Order({
    required this.shopId,
    required this.productId,
    required this.name,
    required this.quantity,
    required this.price,
    required this.imageUrl,
  });
}

class Orders with ChangeNotifier {
  final Map<String, Order> _items = {};
  var _totalPrice = 0.0;

  List<Order> getShopOrders(String shopId) {
    List<Order> tempItems = [];

    _items.forEach((key, value) {
      if (_items[key]?.shopId == shopId) {
        tempItems.add(value);
      }
    });

    // tempItems = [
    //   Order(
    //       shopId: "893hfy34brw9u34u3494h",
    //       productId: "7hy8f734u3r",
    //       name: "Chips",
    //       quantity: 5,
    //       price: 5,
    //       imageUrl:
    //           "https://images.unsplash.com/photo-1613919113640-25732ec5e61f?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80")
    // ];

    return tempItems;
  }

  double get getTotalPrice {
    return _totalPrice;
  }

  void addItem(String shopId, String productId, String name, double price,
      String imageUrl) {
    if (_items.containsKey("$shopId$productId")) {
      _items.update(
        "$shopId$productId",
        (existingOrder) => Order(
            shopId: existingOrder.shopId,
            productId: existingOrder.productId,
            name: existingOrder.name,
            quantity: existingOrder.quantity + 1,
            price: existingOrder.price,
            imageUrl: existingOrder.imageUrl),
      );
      _totalPrice += price;
    } else {
      _items.putIfAbsent(
        "$shopId$productId",
        () => Order(
            shopId: shopId,
            productId: productId,
            name: name,
            quantity: 1,
            price: price,
            imageUrl: imageUrl),
      );
      _totalPrice += price;
    }
    print(_items.length);
    notifyListeners();
  }

  void removeItem(String shopId, String productId, String name, double price) {
    if (_items.containsKey("$shopId$productId")) {
      _items.update(
        "$shopId$productId",
        (existingOrder) => Order(
            shopId: existingOrder.shopId,
            productId: existingOrder.productId,
            name: existingOrder.name,
            quantity: existingOrder.quantity - 1,
            price: existingOrder.price,
            imageUrl: existingOrder.imageUrl),
      );
      _totalPrice -= price;
    }
    if (_items["$shopId$productId"]?.quantity == 1) {
      _items.remove("$shopId$productId");
      _totalPrice -= price;
    }
    // print(_items["$shopId$productId"]?.quantity);
    notifyListeners();
  }

  int get getLength {
    return _items.length;
  }
}
