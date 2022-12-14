import 'package:flutter/material.dart';
import 'package:hopl_app/models/shop.dart';
import 'package:hopl_app/providers/order.dart';
import 'package:provider/provider.dart';

class ShopGridItem extends StatefulWidget {
  final int i;
  final Shop shop;
  const ShopGridItem({super.key, required this.i, required this.shop});

  @override
  State<ShopGridItem> createState() => _ShopGridItemState();
}

class _ShopGridItemState extends State<ShopGridItem> {
  int quantity = 0;

  @override
  Widget build(BuildContext context) {
    final shopId = ModalRoute.of(context)?.settings.arguments as String;
    var shop = widget.shop;
    quantity = Provider.of<Order>(context, listen: false)
        .getProductQuantity(shopId, shop.items[widget.i].productId);

    return Container(
      height: 300,
      margin: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
              margin: const EdgeInsets.only(bottom: 10),
              decoration: const BoxDecoration(boxShadow: [
                BoxShadow(
                    color: Colors.black38,
                    offset: Offset(0.1, 2),
                    blurRadius: 7,
                    spreadRadius: 0.6,
                    blurStyle: BlurStyle.outer)
              ]),
              child: Image.network(shop.items[widget.i].imgUrl,
                  fit: BoxFit.cover)),
          Text(
            shop.items[widget.i].name,
            style: const TextStyle(fontSize: 17, color: Colors.purple),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            "Price: ${shop.items[widget.i].price.toString()}",
            style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  if (quantity > 0) {
                    setState(() {
                      quantity -= 1;
                    });
                  }
                  Provider.of<Order>(context, listen: false).removeItem(
                      shop.shopId,
                      // "63728e2cb5f2ed1c362922ad",
                      shop.items[widget.i].productId,
                      shop.items[widget.i].name,
                      shop.items[widget.i].price);
                },
                child: Container(
                  color: Colors.purple,
                  height: 30,
                  width: 30,
                  child: const Center(
                    child: Text(
                      "-",
                      style: TextStyle(fontSize: 25, color: Colors.white),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                quantity.toString(),
                style: const TextStyle(fontSize: 22),
              ),
              const SizedBox(
                width: 10,
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    quantity += 1;
                  });
                  Provider.of<Order>(context, listen: false).addItem(
                      shop.shopId,
                      // "63728e2cb5f2ed1c362922ad",
                      shop.items[widget.i].productId,
                      shop.items[widget.i].name,
                      shop.items[widget.i].price,
                      shop.items[widget.i].imgUrl);
                },
                child: Container(
                  color: Colors.purple,
                  height: 30,
                  width: 30,
                  child: const Center(
                    child: Text(
                      "+",
                      style: TextStyle(fontSize: 25, color: Colors.white),
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
