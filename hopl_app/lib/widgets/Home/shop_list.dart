import 'package:flutter/material.dart';
import 'package:hopl_app/providers/shops.dart';
import 'package:hopl_app/screens/ShopScreen.dart';
import 'package:provider/provider.dart';

class ShopList extends StatelessWidget {
  const ShopList({super.key});

  @override
  Widget build(BuildContext context) {
    final shops = Provider.of<Shops>(context).items;

    return Expanded(
      child: Container(
        margin: const EdgeInsets.only(top: 20, left: 22, right: 22),
        child: ListView.builder(
            itemCount: shops.length,
            itemBuilder: (ctx, i) {
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(
                    ShopScreen.routeName,
                    arguments: shops[i].shopId,
                  );
                },
                child: Container(
                  height: 140,
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  margin: const EdgeInsets.only(bottom: 20),
                  decoration: const BoxDecoration(boxShadow: [
                    BoxShadow(
                        color: Colors.black38,
                        offset: Offset(0.1, 2),
                        blurRadius: 7,
                        spreadRadius: 0.6,
                        blurStyle: BlurStyle.outer)
                  ], color: Colors.white),
                  child: Row(
                    children: [
                      Image.network(
                        "https://images.unsplash.com/photo-1604719312566-8912e9227c6a?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1074&q=80",
                      ),
                      const SizedBox(
                        width: 14,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            shops[i].shopName,
                            style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                                color: Colors.purple),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Category: ${shops[i].category}",
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              const Text(
                                "Rating: ",
                                style: TextStyle(fontSize: 16),
                              ),
                              if (shops[i].rating == 5)
                                Row(
                                  children: const [
                                    Icon(Icons.star, color: Colors.yellow),
                                    Icon(Icons.star, color: Colors.yellow),
                                    Icon(Icons.star, color: Colors.yellow),
                                    Icon(Icons.star, color: Colors.yellow),
                                    Icon(Icons.star, color: Colors.yellow),
                                  ],
                                )
                              else if (shops[i].rating == 4)
                                Row(
                                  children: const [
                                    Icon(Icons.star, color: Colors.yellow),
                                    Icon(Icons.star, color: Colors.yellow),
                                    Icon(Icons.star, color: Colors.yellow),
                                    Icon(Icons.star, color: Colors.yellow),
                                  ],
                                )
                              else if (shops[i].rating == 3)
                                Row(
                                  children: const [
                                    Icon(Icons.star, color: Colors.yellow),
                                    Icon(Icons.star, color: Colors.yellow),
                                    Icon(Icons.star, color: Colors.yellow),
                                  ],
                                )
                              else if (shops[i].rating == 2)
                                Row(
                                  children: const [
                                    Icon(Icons.star, color: Colors.yellow),
                                    Icon(Icons.star, color: Colors.yellow),
                                  ],
                                )
                              else if (shops[i].rating == 1)
                                Row(
                                  children: const [
                                    Icon(Icons.star, color: Colors.yellow),
                                  ],
                                )
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}
