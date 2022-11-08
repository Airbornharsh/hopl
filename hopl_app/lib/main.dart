import 'package:flutter/material.dart';
import 'package:hopl_app/providers/orders.dart';
import 'package:hopl_app/providers/shops.dart';
import 'package:hopl_app/screens/HomeScreen.dart';
import 'package:hopl_app/screens/ShopScreen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: Shops()),
        ChangeNotifierProvider.value(value: Orders()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.purple,
        ),
        home: const HomeScreen(),
        routes: {
          ShopScreen.routeName: (ctx) => const ShopScreen(),
        },
      ),
    );
  }
}
