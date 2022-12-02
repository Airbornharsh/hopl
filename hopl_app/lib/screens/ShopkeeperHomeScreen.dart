import 'package:flutter/material.dart';
import 'package:hopl_app/providers/shopkeeperOrders.dart';
import 'package:hopl_app/providers/shopkeeperShop.dart';
import 'package:hopl_app/providers/user.dart';
import 'package:hopl_app/screens/HomeScreen.dart';
import 'package:hopl_app/screens/ShopkeeperOrderScreen.dart';
import 'package:hopl_app/widgets/AppDrawer.dart';
import 'package:provider/provider.dart';

class ShopkeeperHomeScreen extends StatefulWidget {
  static const routeName = "/shopkeeper";
  var start = 1;
  ShopkeeperHomeScreen({super.key});

  @override
  State<ShopkeeperHomeScreen> createState() => _ShopkeeperHomeScreenState();
}

class _ShopkeeperHomeScreenState extends State<ShopkeeperHomeScreen> {
  int _selectedIndex = 0;
  List<ShopkeeperOrder> orders = [];
  List<Product> products = [];

  @override
  Widget build(BuildContext context) {
    var shopkeeperOrders =
        Provider.of<ShopkeeperOrders>(context, listen: false);
    var shopkeeperShop = Provider.of<ShopkeeperShop>(context, listen: false);

    if (widget.start == 1) {
      shopkeeperOrders.onLoad().then((el) {
        setState(() {
          orders = el;
          widget.start = 0;
        });
      });

      shopkeeperShop.onLoad().then((el) {
        setState(() {
          products = el;
          widget.start = 0;
        });
      });
    }

    List<Widget> Render = [
      Container(
        margin: const EdgeInsets.only(top: 20),
        child: ListView.builder(
            itemCount: orders.length,
            itemBuilder: ((ctx, i) {
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(
                      ShopkeeperOrderScreen.routeName,
                      arguments: orders[i].orderId);
                },
                child: Container(
                  margin:
                      const EdgeInsets.only(bottom: 10, right: 20, left: 20),
                  padding: const EdgeInsets.only(
                      bottom: 10, top: 15, left: 10, right: 10),
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
                      orders[i].user.imgUrl,
                      // height: 110,
                    ),
                    title: Row(
                      children: [
                        const Text(
                          "Name: ",
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        Text(orders[i].user.name),
                      ],
                    ),
                    subtitle: Row(
                      children: [
                        const Text(
                          "Ordered At: ",
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        Expanded(child: Text(orders[i].createdAt))
                      ],
                    ),
                    trailing: Text("₹${orders[i].totalPrice}"),
                    // subtitle: Column(
                    //   crossAxisAlignment: CrossAxisAlignment.start,
                    //   children: [
                    //     const SizedBox(
                    //       height: 5,
                    //     ),
                    //     Text("price: Rs${orders[i].price.toString()}"),
                    //     const SizedBox(
                    //       height: 5,
                    //     ),
                    //     Text("quantity: ${orders[i].quantity.toString()}")
                    //   ],
                    // ),
                    // trailing: Text(
                    //   "Rs ${(orders[i].quantity * orders[i].price).toString()}",
                    //   style: const TextStyle(fontSize: 20),
                    // ),
                  ),
                ),
              );
            })),
      ),
      Container(
        child: const Text("Stocks"),
      )
    ];

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
              label: "Order List", icon: Icon(Icons.dangerous)),
          BottomNavigationBarItem(label: "Stocks", icon: Icon(Icons.add)),
        ],
        onTap: ((value) {
          setState(() {
            _selectedIndex = value;
          });
        }),
        currentIndex: _selectedIndex,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedFontSize: 13,
        unselectedFontSize: 13,
        selectedLabelStyle: const TextStyle(fontSize: 13),
        unselectedLabelStyle: const TextStyle(fontSize: 13),
        elevation: 0,
      ),
      drawer: const AppDrawer(),
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
      body: RefreshIndicator(
          onRefresh: () async {
            shopkeeperOrders.onLoad().then((el) {
              setState(() {
                orders = el;
                widget.start = 0;
              });
            });
          },
          child: Render[_selectedIndex]),
    );
  }
}
