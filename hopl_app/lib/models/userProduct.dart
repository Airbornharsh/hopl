class UserProduct {
  final String shopId;
  final String productId;
  final String name;
  final int quantity;
  final double price;
  final String imageUrl;

  UserProduct({
    required this.shopId,
    required this.productId,
    required this.name,
    required this.quantity,
    required this.price,
    required this.imageUrl,
  });
}

class shopkeeperUserProduct {
  final String userProductId;
  final String name;
  final String productId;
  final String orderId;
  final int quantity;
  final double price;
  final String imgUrl;
  bool confirm = false;

  shopkeeperUserProduct(
      {required this.userProductId,
      required this.name,
      required this.productId,
      required this.orderId,
      required this.quantity,
      required this.price,
      required this.imgUrl,
      required this.confirm});
}
