import 'package:flutter/cupertino.dart';
import 'package:hopl_app/models/shop.dart';
import 'package:hopl_app/models/shopItem.dart';

class Shops with ChangeNotifier {
  final List<Shop> _items = [
    Shop(
        shopName: "Harsh Grocery ",
        shopId: "893hfy34brw9u34u3494h",
        rating: 4,
        category: "grocery",
        items: [
          ShopItem(
              name: "Chips",
              price: 5,
              quantity: 20,
              imgUrl:
                  "https://images.unsplash.com/photo-1613919113640-25732ec5e61f?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80",
              category: "food",
              productId: "7hy8f734u3r",
              shopId: "893hfy34brw9u34u3494h"),
          ShopItem(
              name: "Chips",
              price: 50,
              quantity: 20,
              imgUrl:
                  "https://images.unsplash.com/photo-1613919113640-25732ec5e61f?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80",
              category: "food",
              productId: "7hy8f734uwer",
              shopId: "893hfy34brw9u34u3494h"),
          ShopItem(
              name: "Chips",
              price: 100,
              quantity: 20,
              imgUrl:
                  "https://images.unsplash.com/photo-1613919113640-25732ec5e61f?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80",
              category: "food",
              productId: "7hy8f24534u3r",
              shopId: "893hfy34brw9u34u3494h"),
          ShopItem(
              name: "Chips",
              price: 100,
              quantity: 20,
              imgUrl:
                  "https://images.unsplash.com/photo-1613919113640-25732ec5e61f?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80",
              category: "food",
              productId: "7hy8f234534u3r",
              shopId: "893hfy34brw9u34u3494h"),
          ShopItem(
              name: "Chips",
              price: 100,
              quantity: 20,
              imgUrl:
                  "https://images.unsplash.com/photo-1613919113640-25732ec5e61f?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80",
              category: "food",
              productId: "42y8f24534u3r",
              shopId: "893hfy34brw9u34u3494h"),
          ShopItem(
              name: "Chips",
              price: 100,
              quantity: 20,
              imgUrl:
                  "https://images.unsplash.com/photo-1613919113640-25732ec5e61f?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80",
              category: "food",
              productId: "7hy8f3456534u3r",
              shopId: "893hfy34brw9u34u3494h"),
          ShopItem(
              name: "Chips",
              price: 100,
              quantity: 20,
              imgUrl:
                  "https://images.unsplash.com/photo-1613919113640-25732ec5e61f?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80",
              category: "food",
              productId: "456464gfdftggtr",
              shopId: "893hfy34brw9u34u3494h"),
        ],
        imgUrl:
            "https://images.unsplash.com/photo-1604719312566-8912e9227c6a?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1074&q=80"),
  ];

  List<Shop> get items {
    return _items;
  }

  Shop filterById(String shopId) {
    Shop data = _items.firstWhere((shop) => shop.shopId == shopId);

    return data;
  }
}
