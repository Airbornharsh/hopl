import 'package:flutter/material.dart';
import 'package:hopl_app/providers/user.dart';
import 'package:provider/provider.dart';

class AuthScreen extends StatefulWidget {
  static const routeName = "/auth";
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  var isLogin = true;
  final _nameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _emailIdController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _phoneNumberController.dispose();
    _emailIdController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Container(
      padding: const EdgeInsets.only(top: 20, left: 10, right: 10, bottom: 20),
      width: (MediaQuery.of(context).size.width - 70),
      // height: 500,
      constraints: BoxConstraints(maxHeight: (isLogin ? 270 : 490)),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: const [
            BoxShadow(
                color: Colors.black38,
                offset: Offset(0.1, 2),
                blurRadius: 7,
                spreadRadius: 0.6,
                blurStyle: BlurStyle.outer)
          ]),
      child: Column(
        children: isLogin
            ? [
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  padding: const EdgeInsets.only(top: 4),
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.purple)),
                  child: TextField(
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "Email Id",
                      fillColor: Colors.white,
                      filled: true,
                    ),
                    controller: _emailIdController,
                  ),
                ),
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  padding: const EdgeInsets.only(top: 4),
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.purple)),
                  child: TextField(
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "Password",
                      fillColor: Colors.white,
                      filled: true,
                    ),
                    controller: _passwordController,
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                TextButton(
                    onPressed: () async {
                      Provider.of<User>(context, listen: false).LoginHandler(
                          _emailIdController.text, _passwordController.text);
                    },
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.purple)),
                    child: const Text(
                      "Login",
                      style: TextStyle(color: Colors.white),
                    )),
                const SizedBox(
                  height: 7,
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isLogin = false;
                    });
                  },
                  child: const Text(
                    "Create an New Account",
                    style: TextStyle(fontSize: 14, color: Colors.purple),
                  ),
                )
              ]
            : [
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  padding: const EdgeInsets.only(top: 4),
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.purple)),
                  child: TextField(
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
                  margin:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  padding: const EdgeInsets.only(top: 4),
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.purple)),
                  child: TextField(
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "Phone Number",
                      fillColor: Colors.white,
                      filled: true,
                    ),
                    controller: _phoneNumberController,
                  ),
                ),
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  padding: const EdgeInsets.only(top: 4),
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.purple)),
                  child: TextField(
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "Email Id",
                      fillColor: Colors.white,
                      filled: true,
                    ),
                    controller: _emailIdController,
                  ),
                ),
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  padding: const EdgeInsets.only(top: 4),
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.purple)),
                  child: TextField(
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "Password",
                      fillColor: Colors.white,
                      filled: true,
                    ),
                    controller: _confirmPasswordController,
                  ),
                ),
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  padding: const EdgeInsets.only(top: 4),
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.purple)),
                  child: TextField(
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "Confirm Password",
                      fillColor: Colors.white,
                      filled: true,
                    ),
                    controller: _passwordController,
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                TextButton(
                    onPressed: () {},
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.purple)),
                    child: const Text(
                      "Sign Up",
                      style: TextStyle(color: Colors.white),
                    )),
                const SizedBox(
                  height: 7,
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isLogin = true;
                    });
                  },
                  child: const Text(
                    "Login Instead",
                    style: TextStyle(fontSize: 14, color: Colors.purple),
                  ),
                )
              ],
      ),
    )
            // : SingleChildScrollView(
            //     child: Container(
            //       padding: const EdgeInsets.only(
            //           top: 20, left: 10, right: 10, bottom: 20),
            //       width: (MediaQuery.of(context).size.width - 70),
            //       // height: 500,
            //       constraints: const BoxConstraints(maxHeight: 540),
            //       decoration: BoxDecoration(
            //           color: Colors.white,
            //           borderRadius: BorderRadius.circular(15),
            //           boxShadow: const [
            //             BoxShadow(
            //                 color: Colors.black38,
            //                 offset: Offset(0.1, 2),
            //                 blurRadius: 7,
            //                 spreadRadius: 0.6,
            //                 blurStyle: BlurStyle.outer)
            //           ]),
            //       child: Column(
            //         children: ,
            //       ),
            //     ),
            //   ),
            ));
  }
}
