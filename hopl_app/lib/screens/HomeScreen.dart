import 'package:flutter/material.dart';
import 'package:hopl_app/providers/user.dart';
import 'package:hopl_app/widgets/AppDrawer.dart';
import 'package:hopl_app/widgets/Home/shop_list.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context, listen: false);
    
    

    return Scaffold(
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
                    "https://0.soompi.io/wp-content/uploads/2020/06/27114627/Nancy-3.jpg",
                    height: 40,
                    width: 40,
                    fit: BoxFit.cover,
                  )),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            padding: const EdgeInsets.only(top: 5),
            decoration: const BoxDecoration(boxShadow: [
              BoxShadow(
                  color: Colors.black38,
                  offset: Offset(0.1, 2),
                  blurRadius: 7,
                  spreadRadius: 0.6,
                  blurStyle: BlurStyle.outer)
            ]),
            child: TextField(
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: "Enter to Search Here",
                fillColor: Colors.white,
                filled: true,
              ),
              controller: _searchController,
            ),
          ),
          const ShopList()
        ],
      ),
    );
  }
}
