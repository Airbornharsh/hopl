class UserDetails {
  String name;
  String emailId;
  int phoneNumber;
  List<dynamic> orders;
  bool shopkeeper;
  String address;
  String imgUrl;
  String createdAt;
  String token;
  bool isAuth;

  UserDetails(
      {required this.name,
      required this.emailId,
      required this.phoneNumber,
      required this.orders,
      required this.shopkeeper,
      required this.address,
      required this.imgUrl,
      required this.createdAt,
      required this.token,
      required this.isAuth});
}