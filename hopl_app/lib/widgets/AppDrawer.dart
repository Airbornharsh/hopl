import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            color: Colors.purple,
            height: 300,
            child: Center(
              child: Container(
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(300),
                    child: Image.network(
                      "https://0.soompi.io/wp-content/uploads/2020/06/27114627/Nancy-3.jpg",
                      height: 150,
                      width: 150,
                      fit: BoxFit.cover,
                    )),
              ),
            ),
          ),
          const Divider(),
          // ListTile(
          //   leading: const Icon(Icons.shop),
          //   title: const Text('Shop'),
          //   onTap: () {
          //     Navigator.of(context).pushReplacementNamed('/');
          //   },
          // ),
          // const Divider(),
          ListTile(
            leading: const Icon(Icons.payment),
            title: const Text('Orders'),
            onTap: () {
              // Navigator.of(context)
              //     .pushReplacementNamed(OrdersScreen.routeName);
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.edit),
            title: const Text('Manage Products'),
            onTap: () {
              // Navigator.of(context)
              //     .pushReplacementNamed(UserProductsScreen.routeName);
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text('Log Out'),
            onTap: () {
              // Provider.of<Auth>(context, listen: false).logout();
            },
          ),
        ],
      ),
    );
  }
}
