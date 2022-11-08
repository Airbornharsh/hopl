import 'package:flutter/cupertino.dart';

class Order {
  final String shopId;
  final String productId;
  final String name;
  final int quantity;
  final double price;

  Order({
    required this.shopId,
    required this.productId,
    required this.name,
    required this.quantity,
    required this.price,
  });
}

class Orders with ChangeNotifier {
  final Map<String, Order> _items = {};

  void addItem(String shopId, String productId, String name, int quantity,
      double price) {
    if (_items.containsKey("$shopId$productId")) {
      _items.update(
        "$shopId$productId",
        (existingOrder) => Order(
            shopId: existingOrder.shopId,
            productId: existingOrder.productId,
            name: existingOrder.name,
            quantity: existingOrder.quantity + 1,
            price: existingOrder.price),
      );
    } else {
      _items.putIfAbsent(
        "$shopId$productId",
        () => Order(
            shopId: shopId,
            productId: productId,
            name: name,
            quantity: quantity,
            price: price),
      );
    }
    print(_items.length);
    notifyListeners();
  }

  void removeItem(String shopId, String productId, String name, int quantity,
      double price) {
    if (_items.containsKey("$shopId$productId")) {
      _items.update(
        "$shopId$productId",
        (existingOrder) => Order(
            shopId: existingOrder.shopId,
            productId: existingOrder.productId,
            name: existingOrder.name,
            quantity: existingOrder.quantity - 1,
            price: existingOrder.price),
      );
    }
    if (_items["$shopId$productId"]?.quantity == 1) {
      _items.remove("$shopId$productId");
    }
    // print(_items["$shopId$productId"]?.quantity);
    notifyListeners();
  }

  int get getLength {
    return _items.length;
  }
}
