import 'package:flutter/material.dart';
import 'package:hopl_app/providers/order.dart';
import 'package:hopl_app/providers/orders.dart';
import 'package:hopl_app/providers/shopkeeperOrders.dart';
import 'package:hopl_app/providers/shopkeeperShop.dart';
import 'package:hopl_app/providers/shops.dart';
import 'package:hopl_app/providers/user.dart';
import 'package:hopl_app/screens/Auth_Screen.dart';
import 'package:hopl_app/screens/HomeScreen.dart';
import 'package:hopl_app/screens/OrderScreen.dart';
import 'package:hopl_app/screens/OrdersScreen.dart';
import 'package:hopl_app/screens/ShopScreen.dart';
import 'package:hopl_app/screens/ShopkeeperHomeScreen.dart';
import 'package:hopl_app/screens/ShopkeeperOrderScreen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: User()),
        ChangeNotifierProvider.value(value: Shops()),
        ChangeNotifierProvider.value(value: Order()),
        ChangeNotifierProvider.value(value: Orders()),
        ChangeNotifierProvider.value(value: ShopkeeperOrders()),
        ChangeNotifierProvider.value(value: ShopkeeperShop()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.purple,
        ),
        // home: const HomeScreen(),
        home: HomeScreen(),
        routes: {
          ShopkeeperHomeScreen.routeName: (ctx) => ShopkeeperHomeScreen(),
          ShopScreen.routeName: (ctx) => ShopScreen(),
          OrderScreen.routeName: (ctx) => const OrderScreen(),
          AuthScreen.routeName: (ctx) => const AuthScreen(),
          OrdersScreen.routeName: (ctx) => OrdersScreen(),
          ShopkeeperOrderScreen.routeName: (ctx) => ShopkeeperOrderScreen(),
        },
      ),
    );
  }
}
