import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hopl_app/providers/order.dart';
import 'package:hopl_app/providers/orders.dart';
import 'package:provider/provider.dart';

class OrdersScreen extends StatefulWidget {
  static const routeName = "/orders";
  var start = 1;

  OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  var _isLoading = false;

  @override
  Widget build(BuildContext context) {
    var orders = Provider.of<Orders>(context, listen: false).getItems;

    if (widget.start == 1) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<Orders>(context, listen: false).onLoad().then((el) {
        setState(() {
          _isLoading = false;
          orders = el;
          widget.start = 0;
        });
      });
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Orders")),
      body: Stack(
        children: <Widget>[
          SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: SingleChildScrollView(
              child: SizedBox(
                // height: MediaQuery.of(context).size.height - 100,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height - 110,
                      child: ListView.builder(
                          itemCount: orders.length,
                          itemBuilder: (context, index) {
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
                                onTap: () {},
                                // leading: Image.network(
                                //   order.products[index].imgUrl,
                                //   width: 70,
                                //   height: 90,
                                // ),
                                title: SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width - 100,
                                    height: 32,
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            // Text(
                                            //     order.products[index].name.toString(),
                                            //     style: const TextStyle(
                                            //         fontWeight: FontWeight.w600,
                                            //         fontSize: 13))
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            const Text("Price: ",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 13)),
                                            const Text(
                                                // order.products[index].quantity
                                                //     .toString(),
                                                "2",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 13)),
                                          ],
                                        ),
                                      ],
                                    )),
                                subtitle: SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width - 100,
                                  child: Row(
                                    children: [
                                      const Text(
                                        "Ordered At: ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Text(
                                          orders[index].createdAt.split("T")[0])
                                    ],
                                  ),
                                ),
                                trailing: SizedBox(
                                  width: 60,
                                  child: Row(children: [
                                    if (!orders[index].confirm)
                                      SizedBox(
                                          width: 40,
                                          height: 40,
                                          child: Center(
                                            child: TextButton(
                                                onPressed: () {},
                                                child:
                                                    const CircularProgressIndicator()),
                                          )),
                                    if (orders[index].confirm)
                                      SizedBox(
                                          width: 40,
                                          height: 40,
                                          child: Center(
                                            child: TextButton(
                                                onPressed: () {},
                                                child: const Icon(Icons
                                                    .check_circle_rounded)),
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
          ),
          if (_isLoading)
            Positioned(
              top: 0,
              left: 0,
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Container(
                color: const Color.fromRGBO(80, 80, 80, 0.3),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: const Center(child: CircularProgressIndicator()),
              ),
            ),
        ],
      ),
    );
  }
}
