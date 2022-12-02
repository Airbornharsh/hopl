import 'package:flutter/material.dart';
import 'package:hopl_app/providers/shopkeeperOrders.dart';
import 'package:hopl_app/providers/user.dart';
import 'package:provider/provider.dart';

class ShopkeeperOrderScreen extends StatefulWidget {
  static const routeName = "/shopkeeper-list";
  var start = 1;

  ShopkeeperOrderScreen({super.key});

  @override
  State<ShopkeeperOrderScreen> createState() => _ShopkeeperOrderScreenState();
}

class _ShopkeeperOrderScreenState extends State<ShopkeeperOrderScreen> {
  ShopkeeperOrder order = ShopkeeperOrder(
      user: UserData(
          name: "",
          phoneNumber: 0,
          address: "",
          imgUrl:
              "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png",
          createdAt: ""),
      userId: "",
      orderId: "",
      shopId: "",
      products: [],
      totalPrice: 0,
      createdAt: "",
      confirm: false);
  bool _confirmSnackBar = false;
  bool _isOrderConfirm = false;

  @override
  Widget build(BuildContext context) {
    var orderId = ModalRoute.of(context)?.settings.arguments as String;

    if (widget.start == 1) {
      Provider.of<ShopkeeperOrders>(context, listen: false)
          .onOrderLoad(orderId)
          .then((e) {
        setState(() {
          order = e;
          widget.start = 0;
          _isOrderConfirm = order.confirm;
        });
      });
    }

    void confirmProductFn(String userProductId) {
      Provider.of<ShopkeeperOrders>(context, listen: false)
          .confirmProduct(userProductId)
          .then((e) {
        // setState(() {
        var snackBar = const SnackBar(
          content: Text('Confirmed'),
          duration: Duration(milliseconds: 600),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        // });
      });
    }

    void confirmOrderFn(String orderId) {
      Provider.of<ShopkeeperOrders>(context, listen: false)
          .confirmOrder(orderId)
          .then((e) {
        // setState(() {
        var snackBar = const SnackBar(
          content: Text('Confirmed'),
          duration: Duration(milliseconds: 600),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        // });
      });
    }

    return Scaffold(
      floatingActionButton: GestureDetector(
        onTap: _isOrderConfirm
            ? null
            : () {
                confirmOrderFn(order.orderId);
                order.confirm = true;
                setState(() {
                  _isOrderConfirm = true;
                });
              },
        child: Container(
          padding:
              const EdgeInsets.only(top: 10, bottom: 10, right: 12, left: 12),
          decoration: BoxDecoration(
              color: _isOrderConfirm ? Colors.grey : Colors.purple,
              borderRadius: BorderRadius.circular(8)),
          child: _isOrderConfirm
              ? const Text(
                  "Confirmed",
                  style: TextStyle(color: Colors.white, fontSize: 17),
                )
              : const Text(
                  "Confirm Order",
                  style: TextStyle(color: Colors.white, fontSize: 17),
                ),
        ),
      ),
      appBar: AppBar(
        title: const Text(
          "HOPL",
          style: TextStyle(color: Colors.black),
        ),
        iconTheme: const IconThemeData(color: Colors.black, size: 35),
        backgroundColor: Colors.white,
        actions: [
          Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(300)),
            margin: const EdgeInsets.only(right: 10, top: 5, bottom: 5),
            child: CircleAvatar(
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(300),
                  child: Image.network(
                    Provider.of<User>(context, listen: false).getDetails.imgUrl,
                    height: 40,
                    width: 40,
                    fit: BoxFit.cover,
                  )),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height - 100,
          child: Column(
            children: [
              const SizedBox(
                height: 15,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Image.network(
                      order.user.imgUrl,
                      width: MediaQuery.of(context).size.width / 3,
                      height: 150,
                    ),
                    Container(
                      height: 150,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // ignore: prefer_const_constructors
                          SizedBox(
                            height: 12,
                          ),
                          Row(
                            children: [
                              const Text(
                                "Name: ",
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                              Text(order.user.name)
                            ],
                          ),
                          const SizedBox(
                            height: 7,
                          ),
                          Row(
                            children: [
                              const Text(
                                "Number: ",
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                              Text(order.user.phoneNumber.toString())
                            ],
                          ),
                          const SizedBox(
                            height: 7,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Address: ",
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                              SizedBox(
                                width: 150,
                                child: Text(order.user.address),
                              )
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height - 280,
                child: ListView.builder(
                    itemCount: order.products.length,
                    itemBuilder: (context, index) {
                      var isConfirm = order.products[index].confirm;

                      return Container(
                        height: 100,
                        width: MediaQuery.of(context).size.width - 60,
                        margin: const EdgeInsets.only(
                            bottom: 10, right: 20, left: 20),
                        padding: const EdgeInsets.only(
                            bottom: 10, top: 15, left: 4, right: 4),
                        decoration: const BoxDecoration(boxShadow: [
                          BoxShadow(
                              color: Colors.black38,
                              offset: Offset(0.1, 2),
                              blurRadius: 7,
                              spreadRadius: 0.6,
                              blurStyle: BlurStyle.outer)
                        ]),
                        child: ListTile(
                          leading: Image.network(
                            order.products[index].imgUrl,
                            width: 70,
                            height: 90,
                          ),
                          title: SizedBox(
                              width: MediaQuery.of(context).size.width - 100,
                              height: 32,
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                          order.products[index].name.toString(),
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 13))
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const Text("Quantity: ",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 13)),
                                      Text(
                                          order.products[index].quantity
                                              .toString(),
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 13)),
                                    ],
                                  ),
                                ],
                              )),
                          subtitle: SizedBox(
                            width: MediaQuery.of(context).size.width - 100,
                            child: Row(
                              children: const [
                                Text(
                                  "Ordered At: ",
                                  style: TextStyle(fontWeight: FontWeight.w600),
                                ),
                                // Expanded(child: Text(order.products[index].productId))
                                Text("Ordered")
                              ],
                            ),
                          ),
                          trailing: SizedBox(
                            width: 60,
                            child: Row(children: [
                              if (isConfirm == false)
                                SizedBox(
                                    width: 25,
                                    child: Center(
                                      child: TextButton(
                                          onPressed: () {
                                            confirmProductFn(order
                                                .products[index].userProductId);
                                            order.products[index].confirm =
                                                true;
                                            setState(() {
                                              isConfirm = true;
                                            });
                                          },
                                          child: const Text("✅")),
                                    )),
                            ]),
                          ),
                        ),
                      );
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
