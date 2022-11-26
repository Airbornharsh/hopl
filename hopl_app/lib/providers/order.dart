import 'package:flutter/cupertino.dart';
import 'package:hopl_app/models/userProduct.dart';

class TempOrder {
  String shopId;
  List<UserProduct> items;

  TempOrder({required this.shopId, required this.items});
}

class Order with ChangeNotifier {
  List<TempOrder> tempOrders = [];
  late TempOrder tempOrder;

  var _totalPrice = 0.0;

  List<UserProduct> getShopOrders(String shopId) {
    List<UserProduct> tempItems = [];

    if (tempOrders.isNotEmpty) {
      tempOrders.firstWhere((tempOrder) {
        if (tempOrder.shopId == shopId) {
          tempItems = tempOrder.items;
          return true;
        }
        return false;
      });
    }
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
    if (tempOrders.isNotEmpty) {
      tempOrders.firstWhere((tempOrder) {
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
              _totalPrice += price;
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
            _totalPrice += price;
          }

          return true;
        }
        return false;
      });
    } else {
      tempOrders.add(TempOrder(shopId: shopId, items: [
        UserProduct(
            shopId: shopId,
            productId: productId,
            name: name,
            quantity: 1,
            price: price,
            imageUrl: imageUrl)
      ]));
      _totalPrice += price;
    }
    notifyListeners();
  }

  void removeItem(String shopId, String productId, String name, double price) {
    tempOrders.firstWhere((tempOrder) {
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
            _totalPrice -= price;
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
    if (tempOrders.isNotEmpty) {
      tempOrders.firstWhere((tempOrder) {
        if (tempOrder.shopId == shopId) {
          if (tempOrder.items.isNotEmpty) {
            print("one");
            tempOrder.items.firstWhere((UserProduct) {
              print("Zero");
              // if(UserProduct)
              if (UserProduct.productId == productId) {
                print("two");
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

  // int get getLength {
  //   return _items.length;
  // }
}
