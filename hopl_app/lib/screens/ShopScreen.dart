import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:hopl_app/models/shop.dart';
import 'package:hopl_app/providers/order.dart';
import 'package:hopl_app/providers/shops.dart';
import 'package:hopl_app/screens/OrderScreen.dart';
import 'package:hopl_app/widgets/Shop/ShopGridItem.dart';
import 'package:provider/provider.dart';

class ShopScreen extends StatefulWidget {
  static const routeName = "/shop";
  var start = 1;

  ShopScreen({super.key});

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  var shop = Shop(
      shopName: "",
      description: "",
      shopId: "",
      rating: 0,
      category: "",
      items: [],
      imgUrl:
          "https://images.unsplash.com/photo-1604719312566-8912e9227c6a?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1074&q=80");

  @override
  Widget build(BuildContext context) {
    final shopId = ModalRoute.of(context)?.settings.arguments as String;

    if (widget.start == 1) {
      Provider.of<Shops>(context, listen: false).onShopLoad(shopId).then((e) {
        setState(() {
          shop = e;
          widget.start = 0;
        });
      });
    }


    return Scaffold(
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
        padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              shop.shopName,
              style: const TextStyle(fontSize: 30, color: Colors.purple),
            ),
            const SizedBox(
              height: 20,
            ),
            Image.network(
              shop.imgUrl,
              height: 170,
              width: 400,
              fit: BoxFit.cover,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "Category: ${shop.category}",
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                const Text(
                  "Rating: ",
                  style: TextStyle(fontSize: 16),
                ),
                if (shop.rating == 5)
                  Row(
                    children: const [
                      Icon(Icons.star, color: Colors.yellow),
                      Icon(Icons.star, color: Colors.yellow),
                      Icon(Icons.star, color: Colors.yellow),
                      Icon(Icons.star, color: Colors.yellow),
                      Icon(Icons.star, color: Colors.yellow),
                    ],
                  )
                else if (shop.rating == 4)
                  Row(
                    children: const [
                      Icon(Icons.star, color: Colors.yellow),
                      Icon(Icons.star, color: Colors.yellow),
                      Icon(Icons.star, color: Colors.yellow),
                      Icon(Icons.star, color: Colors.yellow),
                    ],
                  )
                else if (shop.rating == 3)
                  Row(
                    children: const [
                      Icon(Icons.star, color: Colors.yellow),
                      Icon(Icons.star, color: Colors.yellow),
                      Icon(Icons.star, color: Colors.yellow),
                    ],
                  )
                else if (shop.rating == 2)
                  Row(
                    children: const [
                      Icon(Icons.star, color: Colors.yellow),
                      Icon(Icons.star, color: Colors.yellow),
                    ],
                  )
                else if (shop.rating == 1)
                  Row(
                    children: const [
                      Icon(Icons.star, color: Colors.yellow),
                    ],
                  )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Products:-",
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: GridView.builder(
                itemCount: shop.items.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 2 / 3,
                  crossAxisSpacing: 40,
                  mainAxisSpacing: 10,
                ),
                itemBuilder: ((ctx, i) {
                  return ShopGridItem(
                    i: i,
                    shop: shop,
                  );
                }),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: GestureDetector(
        onTap: (() {
          Navigator.pushNamed(context, OrderScreen.routeName,
              arguments: shopId);
        }),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.purple,
            borderRadius: BorderRadius.circular(10),
          ),
          height: 40,
          width: 120,
          child: const Center(
            child: Text("Order",
                style: TextStyle(color: Colors.white, fontSize: 20)),
          ),
        ),
      ),
    );
  }
}
