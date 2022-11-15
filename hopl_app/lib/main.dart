import 'package:flutter/material.dart';
import 'package:hopl_app/providers/orders.dart';
import 'package:hopl_app/providers/shops.dart';
import 'package:hopl_app/providers/user.dart';
import 'package:hopl_app/screens/Auth_Screen.dart';
import 'package:hopl_app/screens/HomeScreen.dart';
import 'package:hopl_app/screens/OrdersScreen.dart';
import 'package:hopl_app/screens/ShopScreen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  void initState() {
    void onLoad() async {
      final prefs = await SharedPreferences.getInstance();
      prefs.setString("hopl_backend_uri", "http://localhost:3000");
      // prefs.setString("hopl_backend_uri", "http://localhost:3000");
    }

    onLoad();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: User()),
        ChangeNotifierProvider.value(value: Shops()),
        ChangeNotifierProvider.value(value: Orders()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.purple,
        ),
        // home: const HomeScreen(),
        home: const HomeScreen(),
        routes: {
          ShopScreen.routeName: (ctx) => const ShopScreen(),
          OrdersScreen.routeName: (ctx) => const OrdersScreen(),
          AuthScreen.routeName: (ctx) => const AuthScreen()
        },
      ),
    );
  }
}
