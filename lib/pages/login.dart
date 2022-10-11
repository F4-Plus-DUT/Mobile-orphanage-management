import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:orphanage_management_system/pages/utils.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String login_url = Utility.BASE_URL + "api/v1/user/action/login";
  Future<bool> loginToServer(username, password) async {
    bool isSuccessfully = false;
    await http
        .post(Uri.parse(login_url),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(
                <String, String>{'email': username, 'password': password}))
        .then((response) {
      // var body = json.decode(response.body);
      print(response.statusCode);
      // print(body);
      if (response.statusCode == 200) {
        isSuccessfully = true;
      }
    });
    return isSuccessfully;
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Center(
      // child: Column(
      //   mainAxisAlignment: MainAxisAlignment
      //       .center, //Center Column contents vertically,
      //   crossAxisAlignment: CrossAxisAlignment
      //       .center, //Center Column contents horizontally,
      //   children: [
          child: Scaffold(
              body: Padding(
                  padding: const EdgeInsets.all(10),
                  child:
                  ListView(
                    children: <Widget>[
                      Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.all(10),
                          child: const Text(
                            'F5 DUT',
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                                fontSize: 50),
                          )),
                      DecoratedBox(
                      decoration: BoxDecoration(
                      ),
                      child: Center(child: FlutterLogo(size: 200))),
                      Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.all(10),
                          child: const Text(
                            'Login',
                            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.blue,),
                          ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(10),
                        child: TextField(
                          controller: nameController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'User Name',
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                        child: TextField(
                          obscureText: true,
                          controller: passwordController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Password',
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          //forgot password screen
                          Navigator.pushNamed(context, '/resetpwd');
                        },
                        child: const Text(
                          'Forgot Password',
                        ),
                      ),
                      Container(
                          height: 50,
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: ElevatedButton(
                            child: const Text('Login'),
                            onPressed: () async {
                              // String username = nameController.text;
                              // String password = passwordController.text;
                              // if (await loginToServer(username, password)) {
                                Navigator.pushNamed(context, '/home');
                              // } else {
                              //   ScaffoldMessenger.of(context)
                              //       .showSnackBar(const SnackBar(
                              //     content: Text(
                              //       'Account is invalid. Please try again!',
                              //       style: TextStyle(
                              //         color: Colors.white,
                              //       ),
                              //     ),
                              //     backgroundColor: Colors.red,
                              //   ));
                              // }
                            },
                          )),
                      Row(
                        mainAxisAlignment: MainAxisAlignment
                            .center, //Center Row contents horizontally,
                        crossAxisAlignment: CrossAxisAlignment
                            .center, //Center Row contents vertically,
                        children: <Widget>[
                          const Text('Does not have account?'),
                          TextButton(
                            child: const Text(
                              'Sign up',
                              style: TextStyle(fontSize: 20),
                            ),
                            onPressed: () {
                              Navigator.pushNamed(context, '/signup');
                            },
                          )
                        ],
                      ),
                    ],
                  ),

              )),
      //   ],
      // ),
    );
  }
}
