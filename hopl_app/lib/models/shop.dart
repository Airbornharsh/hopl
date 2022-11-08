import 'package:hopl_app/models/shopItem.dart';

class Shop {
  final String shopName;
  final String shopId;
  final String imgUrl;
  final int rating;
  final String category;
  final List<ShopItem> items;

  Shop(
      {required this.shopName,
      required this.shopId,
      required this.rating,
      required this.category,
      required this.items,
      required this.imgUrl});
}
