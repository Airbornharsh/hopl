import 'package:flutter/material.dart';
import 'package:hopl_app/providers/user.dart';
import 'package:hopl_app/screens/Auth_Screen.dart';
import 'package:hopl_app/screens/HomeScreen.dart';
import 'package:hopl_app/screens/OrdersScreen.dart';
import 'package:hopl_app/screens/ShopkeeperHomeScreen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            color: Colors.purple,
            padding: const EdgeInsets.all(25),
            child: Center(
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(300),
                        child: Image.network(
                          Provider.of<User>(context).getDetails.imgUrl,
                          height: 100,
                          width: 100,
                          fit: BoxFit.cover,
                        )),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    Provider.of<User>(context).getDetails.name,
                    style: const TextStyle(color: Colors.white, fontSize: 19),
                  )
                ],
              ),
            ),
          ),
          const Divider(),
          if (!Provider.of<User>(context).getAuth)
            ListTile(
              leading: const Icon(Icons.login),
              title: const Text('Login'),
              onTap: () {
                Navigator.of(context).pushNamed(AuthScreen.routeName);
              },
            ),
          ListTile(
            leading: const Icon(Icons.local_activity),
            title: const Text("Orders"),
            onTap: () {
              Navigator.of(context).pushNamed(OrdersScreen.routeName);
            },
          ),
          if (Provider.of<User>(context).getAuth)
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Log Out'),
              onTap: () async {
                Navigator.of(context).pop();
                var prefs = await SharedPreferences.getInstance();
                Provider.of<User>(context, listen: false).setIsAuth(false);
                prefs.setString("hopl_accessToken", "");

                var snackBar = const SnackBar(
                  content: Text('Logged Out'),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              },
            ),
          Expanded(
            child: Container(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Provider.of<User>(context).getShopkeeperActive
                  ? const Text("Switch as Shopkeeper")
                  : const Text("Switch as Shopkeeper"),
              const SizedBox(
                width: 10,
              ),
              Switch(
                  value: Provider.of<User>(context, listen: false)
                      .getShopkeeperActive,
                  onChanged: (val) {
                    if (val) {
                      Navigator.of(context)
                          .pushReplacementNamed(ShopkeeperHomeScreen.routeName);
                    } else {
                      Navigator.of(context)
                          .pushReplacementNamed(HomeScreen.routeName);
                    }
                    Provider.of<User>(context, listen: false)
                        .setShopkeeperActive(val);
                  })
            ],
          )
        ],
      ),
    );
  }
}
