import 'package:flutter/material.dart';
import 'package:hopl_app/providers/order.dart';
import 'package:hopl_app/providers/shops.dart';
import 'package:provider/provider.dart';

class OrderScreen extends StatefulWidget {
  static const routeName = "/order";
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  Widget build(BuildContext context) {
    final shopId = ModalRoute.of(context)?.settings.arguments as String;
    final shop = Provider.of<Shops>(context, listen: false).filterById(shopId);
    Provider.of<Order>(context, listen: false).createOrder(shopId);
    final orders =
        Provider.of<Order>(context, listen: false).getShopOrders(shopId);
    final totalPrice =
        Provider.of<Order>(context, listen: false).getTotalPrice(shopId);

    void confirmOrderFn() {
      Provider.of<Order>(context, listen: false).AddOrder(shopId).then((el) {
        setState(() {
          var snackBar = SnackBar(
            content: Text(el),
            action: SnackBarAction(
              label: 'Undo',
              onPressed: () {},
            ),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        });
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          shop.shopName,
          style: const TextStyle(color: Colors.black),
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
                    "https://0.soompi.io/wp-content/uploads/2020/06/27114627/Nancy-3.jpg",
                    height: 40,
                    width: 40,
                    fit: BoxFit.cover,
                  )),
            ),
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.only(top: 20),
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            const Text("Orders"),
            const SizedBox(
              height: 20,
            ),
            if (orders.isNotEmpty)
              Expanded(
                child: Container(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: ListView.builder(
                    itemCount: orders.length,
                    itemBuilder: ((ctx, i) {
                      return Container(
                        margin: const EdgeInsets.only(bottom: 10),
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
                            orders[i].imageUrl,
                            height: 100,
                          ),
                          title: Text(orders[i].name),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 5,
                              ),
                              Text("price: Rs${orders[i].price.toString()}"),
                              const SizedBox(
                                height: 5,
                              ),
                              Text("quantity: ${orders[i].quantity.toString()}")
                            ],
                          ),
                          trailing: Text(
                            "Rs ${(orders[i].quantity * orders[i].price).toString()}",
                            style: const TextStyle(fontSize: 20),
                          ),
                          isThreeLine: true,
                        ),
                      );
                    }),
                  ),
                ),
              ),
            if (orders.isEmpty)
              const Text(
                "No Orders To Show",
                style: TextStyle(fontSize: 20),
              ),
            if (orders.isNotEmpty)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black38,
                        offset: Offset(0.1, 2),
                        blurRadius: 7,
                        spreadRadius: 0.6,
                        blurStyle: BlurStyle.outer)
                  ],
                ),
                height: 55,
                child: Row(
                  children: [
                    const Text(
                      "Total Price",
                      style: TextStyle(fontSize: 15, color: Colors.purple),
                    ),
                    const Expanded(child: Text("")),
                    Text(
                      "Rs $totalPrice",
                      style:
                          const TextStyle(fontSize: 15, color: Colors.purple),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    TextButton(
                      onPressed: () {
                        confirmOrderFn();
                      },
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.purple)),
                      child: const Text(
                        "Confirm",
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  ],
                ),
              )
          ],
        ),
      ),
    );
  }
}
