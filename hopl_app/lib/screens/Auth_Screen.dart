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
  // var isConfirmCode = false;
  var isLoading = false;
  final _nameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _emailIdController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _confirmCodeController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _phoneNumberController.dispose();
    _emailIdController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  // void changeConfirmCode(bool data) {
  //   setState(() {
  //     isConfirmCode = data;
  //   });
  // }

  void changeRoute(String routeName, BuildContext context) {
    Navigator.of(context).pushReplacementNamed(routeName);
  }

  @override
  Widget build(BuildContext context) {
    var login = Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          padding: const EdgeInsets.only(top: 4),
          decoration: BoxDecoration(border: Border.all(color: Colors.purple)),
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
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          padding: const EdgeInsets.only(top: 4),
          decoration: BoxDecoration(border: Border.all(color: Colors.purple)),
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
              setState(() {
                isLoading = true;
              });
              var loginRes = await Provider.of<User>(context, listen: false)
                  .LoginHandler(
                      _emailIdController.text, _passwordController.text);

              if (loginRes) {
                var snackBar = SnackBar(
                  content: const Text('Logged In'),
                  action: SnackBarAction(
                    label: 'Undo',
                    onPressed: () {
                      // Some code to undo the change.
                    },
                  ),
                );
                Navigator.of(context).pop();
              } else {
                var snackBar = const SnackBar(
                  content: Text('Try Again'),
                  // action: SnackBarAction(
                  //   label: 'Undo',
                  //   onPressed: () {
                  //     // Some code to undo the change.
                  //   },
                  // ),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                // _emailIdController.clear();
                // _passwordController.clear();
              }
              setState(() {
                isLoading = false;
              });
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
        ),
      ],
    );

    var register = Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          padding: const EdgeInsets.only(top: 4),
          decoration: BoxDecoration(border: Border.all(color: Colors.purple)),
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
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          padding: const EdgeInsets.only(top: 4),
          decoration: BoxDecoration(border: Border.all(color: Colors.purple)),
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
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          padding: const EdgeInsets.only(top: 4),
          decoration: BoxDecoration(border: Border.all(color: Colors.purple)),
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
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          padding: const EdgeInsets.only(top: 4),
          decoration: BoxDecoration(border: Border.all(color: Colors.purple)),
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
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          padding: const EdgeInsets.only(top: 4),
          decoration: BoxDecoration(border: Border.all(color: Colors.purple)),
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
            onPressed: () async {
              setState(() {
                isLoading = true;
              });
              try {
                var Res = await Provider.of<User>(context, listen: false)
                    .RegisterHandler(
                        _nameController.text,
                        int.parse(_phoneNumberController.text),
                        _emailIdController.text,
                        _passwordController.text,
                        _confirmPasswordController.text);

                if (Res) {
                  setState(() {
                    isLogin = true;
                  });
                } else {
                  var snackBar = const SnackBar(content: Text("Try Again"));
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  // _nameController.clear();
                  // _phoneNumberController.clear();
                  // _emailIdController.clear();
                  // _passwordController.clear();
                  // _confirmCodeController.clear();
                }
                // setState(() {
                //   isConfirmCode = true;
                // });
              } catch (e) {
                print(e);
              }
              setState(() {
                isLoading = false;
              });
            },
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
    );

    // var verify = Column(
    //   children: [
    //     Container(
    //       margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
    //       padding: const EdgeInsets.only(top: 4),
    //       decoration: BoxDecoration(border: Border.all(color: Colors.purple)),
    //       child: TextField(
    //         decoration: const InputDecoration(
    //           border: InputBorder.none,
    //           hintText: "Code",
    //           fillColor: Colors.white,
    //           filled: true,
    //         ),
    //         controller: _confirmCodeController,
    //       ),
    //     ),
    //     const SizedBox(
    //       height: 4,
    //     ),
    //     TextButton(
    //         onPressed: () async {
    //           setState(() {
    //             isLoading = true;
    //           });
    //           var res = await Provider.of<User>(context, listen: false)
    //               .CodeHandler(_confirmCodeController.text);

    //           if (res) {
    //             setState(() {
    //               isLogin = true;
    //             });
    //           } else {
    //             var snackBar =
    //                 const SnackBar(content: Text("Enter the Otp Correctly"));
    //             ScaffoldMessenger.of(context).showSnackBar(snackBar);
    //             _confirmCodeController.clear();
    //           }
    //           setState(() {
    //             isLoading = false;
    //           });
    //         },
    //         style: ButtonStyle(
    //             backgroundColor:
    //                 MaterialStateProperty.all<Color>(Colors.purple)),
    //         child: const Text(
    //           "Confirm Code",
    //           style: TextStyle(color: Colors.white),
    //         )),
    //     const SizedBox(
    //       height: 7,
    //     ),
    //     GestureDetector(
    //       onTap: () {
    //         setState(() {
    //           isConfirmCode = false;
    //         });
    //       },
    //       child: const Text("Re-Enter the Details"),
    //     ),
    //     const SizedBox(
    //       height: 7,
    //     ),
    //     GestureDetector(
    //       onTap: () {
    //         setState(() {
    //           isLogin = true;
    //         });
    //       },
    //       child: const Text(
    //         "Login Instead",
    //         style: TextStyle(fontSize: 14, color: Colors.purple),
    //       ),
    //     )
    //   ],
    // );

    return Scaffold(
      body: Stack(
        children: <Widget>[
          SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Center(
              child: Container(
                padding: const EdgeInsets.only(
                    top: 20, left: 10, right: 10, bottom: 20),
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
                child: Container(
                  child: isLogin ? login : register,
                ),
              ),
            ),
          ),
          if (isLoading)
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
