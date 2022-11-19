import 'package:flutter/cupertino.dart';

class OrderItem {
  final String shopId;
  final String productId;
  final String name;
  final int quantity;
  final double price;
  final String imageUrl;

  OrderItem({
    required this.shopId,
    required this.productId,
    required this.name,
    required this.quantity,
    required this.price,
    required this.imageUrl,
  });
}

class TempOrder {
  final String shopId;
  final List<OrderItem> items;

  TempOrder({required this.shopId, required this.items});
}

class TempOrders{
  
}

class Order with ChangeNotifier {
  final Map<String, OrderItem> _items = {};

  var _totalPrice = 0.0;

  List<OrderItem> getShopOrders(String shopId) {
    List<OrderItem> tempItems = [];

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

  void addItem(String shopId, String orderId, String productId, String name,
      double price, String imageUrl) {
    if (_items.containsKey("$shopId$orderId$productId")) {
      _items.update(
        "$shopId$orderId$productId",
        (existingOrder) => OrderItem(
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
        "$shopId$orderId$productId",
        () => OrderItem(
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

  void removeItem(String shopId, String orderId, String productId, String name,
      double price) {
    if (_items.containsKey("$shopId$orderId$productId")) {
      _items.update(
        "$shopId$orderId$productId",
        (existingOrder) => OrderItem(
            shopId: existingOrder.shopId,
            productId: existingOrder.productId,
            name: existingOrder.name,
            quantity: existingOrder.quantity - 1,
            price: existingOrder.price,
            imageUrl: existingOrder.imageUrl),
      );
      _totalPrice -= price;
    }
    if (_items["$shopId$orderId$productId"]?.quantity == 1) {
      _items.remove("$shopId$orderId$productId");
      _totalPrice -= price;
    }
    // print(_items["$shopId$orderId$productId"]?.quantity);
    notifyListeners();
  }

  int get getLength {
    return _items.length;
  }
}
