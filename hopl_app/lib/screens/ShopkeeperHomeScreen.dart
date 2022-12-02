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

  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _qunatityController = TextEditingController();
  final _priceController = TextEditingController();
  final _imgUrlController = TextEditingController();
  final _categoryController = TextEditingController();

  int productIsActive = -1;

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
        margin: const EdgeInsets.only(top: 20),
        child: ListView.builder(
            itemCount: products.length,
            itemBuilder: ((ctx, i) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    if (productIsActive == i) {
                      productIsActive = -1;
                    } else {
                      productIsActive = i;
                    }
                  });
                },
                child: Container(
                  margin:
                      const EdgeInsets.only(bottom: 10, right: 20, left: 20),
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 2),
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
                            products[i].imgUrl,
                            // height: 110,
                          ),
                          title: Row(
                            children: [
                              const Text(
                                "Name: ",
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                              Text(products[i].name),
                            ],
                          ),
                          subtitle: Column(
                            children: [
                              Row(
                                children: [
                                  const Text(
                                    "Category: ",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w600),
                                  ),
                                  Expanded(child: Text(products[i].category))
                                ],
                              ),
                              Row(
                                children: [
                                  const Text(
                                    "Price: ",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w600),
                                  ),
                                  Expanded(
                                      child: Text(
                                          "₹${products[i].price.toString()}"))
                                ],
                              )
                            ],
                          ),
                          trailing: Text("${products[i].quantity}"),
                        ),
                      ),
                      if (productIsActive == i)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            GestureDetector(
                              onTap: () {
                                _nameController.text = products[i].name;
                                _descriptionController.text =
                                    products[i].description;
                                _priceController.text =
                                    products[i].price.toString();
                                _qunatityController.text =
                                    products[i].quantity.toString();
                                _imgUrlController.text = products[i].imgUrl;
                                _categoryController.text = products[i].category;
                                modalProduct(
                                    "edit", context, products[i].productId);
                              },
                              child: Container(
                                width:
                                    (MediaQuery.of(context).size.width - 41) /
                                        2,
                                height: 40,
                                decoration: const BoxDecoration(
                                    color: Color.fromARGB(255, 218, 218, 218),
                                    border: Border.fromBorderSide(BorderSide(
                                        width: 1,
                                        strokeAlign: StrokeAlign.center))),
                                child: Center(
                                    child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Icon(Icons.edit,
                                        color: Colors.purple, size: 19),
                                    SizedBox(
                                      width: 4,
                                    ),
                                    Text(
                                      "Edit",
                                      style: TextStyle(color: Colors.purple),
                                    )
                                  ],
                                )),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: ((context) {
                                      return AlertDialog(
                                        title: const Text("Confirmation"),
                                        content: const Text(
                                            "Do You Want to Delete This Item "),
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                Provider.of<ShopkeeperShop>(
                                                        context,
                                                        listen: false)
                                                    .deleteProduct(
                                                        products[i].productId)
                                                    .then((el) {
                                                  if (el) {
                                                    var snackBar =
                                                        const SnackBar(
                                                      content:
                                                          Text("Item Deleted"),
                                                      duration: Duration(
                                                          milliseconds: 600),
                                                    );
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(snackBar);
                                                    Navigator.of(context).pop();
                                                  }
                                                });
                                              },
                                              child: const Text("Yes")),
                                          TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: const Text("No")),
                                        ],
                                      );
                                    }));
                              },
                              child: Container(
                                width:
                                    (MediaQuery.of(context).size.width - 41) /
                                        2,
                                height: 40,
                                decoration: const BoxDecoration(
                                    color: Color.fromARGB(255, 218, 218, 218),
                                    border: Border.fromBorderSide(BorderSide(
                                        width: 1,
                                        strokeAlign: StrokeAlign.center))),
                                child: Center(
                                    child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Icon(Icons.delete,
                                        color: Colors.purple, size: 19),
                                    SizedBox(
                                      width: 4,
                                    ),
                                    Text(
                                      "Delete",
                                      style: TextStyle(color: Colors.purple),
                                    )
                                  ],
                                )),
                              ),
                            ),
                          ],
                        )
                    ],
                  ),
                ),
              );
            })),
      )
    ];

    return Scaffold(
      resizeToAvoidBottomInset: false,
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
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          if (_selectedIndex == 1)
            FloatingActionButton(
              onPressed: () {
                _nameController.clear();
                _descriptionController.clear();
                _qunatityController.clear();
                _priceController.clear();
                _imgUrlController.clear();
                _categoryController.clear();
                modalProduct("add", context, "");
              },
              child: const Icon(Icons.add),
            )
        ],
      ),
      body: RefreshIndicator(
          onRefresh: () async {
            if (_selectedIndex == 0) {
              shopkeeperOrders.onLoad().then((el) {
                setState(() {
                  orders = el;
                  widget.start = 0;
                });
              });
            } else {
              shopkeeperShop.onLoad().then((el) {
                setState(() {
                  products = el;
                  widget.start = 0;
                });
              });
            }
          },
          child: Render[_selectedIndex]),
    );
  }

  Future<dynamic> modalProduct(
      String use, BuildContext context, String productId) {
    double upwards = 250;

    void addUpwards() {
      setState(() {
        upwards = 250;
      });
    }

    return showModalBottomSheet(
        context: context,
        builder: ((ctx) {
          return SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(top: 12, bottom: upwards + 12),
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    padding: const EdgeInsets.only(top: 4),
                    decoration:
                        BoxDecoration(border: Border.all(color: Colors.purple)),
                    child: TextField(
                      autofocus: true,
                      onTap: addUpwards,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "Name",
                        fillColor: Colors.white,
                        filled: true,
                      ),
                      controller: _nameController,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    padding: const EdgeInsets.only(top: 4),
                    decoration:
                        BoxDecoration(border: Border.all(color: Colors.purple)),
                    child: TextField(
                      onTap: addUpwards,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "Description",
                        fillColor: Colors.white,
                        filled: true,
                      ),
                      controller: _descriptionController,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    padding: const EdgeInsets.only(top: 4),
                    decoration:
                        BoxDecoration(border: Border.all(color: Colors.purple)),
                    child: TextField(
                      onTap: addUpwards,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "Qunatity",
                        fillColor: Colors.white,
                        filled: true,
                      ),
                      controller: _qunatityController,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    padding: const EdgeInsets.only(top: 4),
                    decoration:
                        BoxDecoration(border: Border.all(color: Colors.purple)),
                    child: TextField(
                      onTap: addUpwards,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "Price",
                        fillColor: Colors.white,
                        filled: true,
                      ),
                      controller: _priceController,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    padding: const EdgeInsets.only(top: 4),
                    decoration:
                        BoxDecoration(border: Border.all(color: Colors.purple)),
                    child: TextField(
                      onTap: addUpwards,
                      keyboardType: TextInputType.url,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "Image Url",
                        fillColor: Colors.white,
                        filled: true,
                      ),
                      controller: _imgUrlController,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    padding: const EdgeInsets.only(top: 4),
                    decoration:
                        BoxDecoration(border: Border.all(color: Colors.purple)),
                    child: TextField(
                      onTap: addUpwards,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "Category",
                        fillColor: Colors.white,
                        filled: true,
                      ),
                      controller: _categoryController,
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  TextButton(
                      onPressed: () {
                        if (use == "add") {
                          Provider.of<ShopkeeperShop>(context, listen: false)
                              .addProduct(
                                  _nameController.text,
                                  _descriptionController.text,
                                  int.parse(_qunatityController.text),
                                  double.parse(_priceController.text),
                                  _categoryController.text,
                                  _imgUrlController.text)
                              .then((el) {
                            if (el) {
                              var snackBar = const SnackBar(
                                content: Text("Product Added"),
                                duration: Duration(milliseconds: 600),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);

                              Navigator.of(context).pop();

                              _nameController.clear();
                              _descriptionController.clear();
                              _qunatityController.clear();
                              _priceController.clear();
                              _imgUrlController.clear();
                              _categoryController.clear();
                            }
                          });
                        } else if (use == "edit") {
                          Provider.of<ShopkeeperShop>(context, listen: false)
                              .editProduct(
                                  productId,
                                  _nameController.text,
                                  _descriptionController.text,
                                  int.parse(_qunatityController.text),
                                  double.parse(_priceController.text),
                                  _categoryController.text,
                                  _imgUrlController.text)
                              .then((el) {
                            if (el) {
                              var snackBar = const SnackBar(
                                content: Text("Product Updated"),
                                duration: Duration(milliseconds: 600),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);

                              // Navigator.of(context).pop();

                              // _nameController.clear();
                              // _descriptionController.clear();
                              // _qunatityController.clear();
                              // _priceController.clear();
                              // _imgUrlController.clear();
                              // _categoryController.clear();
                            }
                          });
                        }
                      },
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.purple)),
                      child: Text(
                        use == "add" ? "Add Product" : "Update product",
                        style: const TextStyle(color: Colors.white),
                      )),
                  const SizedBox(
                    height: 4,
                  )
                ],
              ),
            ),
          );
        }));
  }
}
