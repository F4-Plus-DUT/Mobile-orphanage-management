import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:orphanage_management_system/pages/home.dart';
import 'package:orphanage_management_system/pages/reset_pwd.dart';
import 'package:orphanage_management_system/pages/signup.dart';
import 'package:orphanage_management_system/pages/utils.dart';

import '../models/profile.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  String login_url = Utility.BASE_URL + "api/v1/user/action/login";

  Future<bool> loginToServer(username, password) async {
    print("Login to Server function");
    bool isSuccessfully = false;
    await http
        .post(Uri.parse(login_url),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(
                <String, String>{'email': username, 'password': password}))
        .then((response) {
      if (response.statusCode == 200) {
        var body = json.decode(response.body);
        isSuccessfully = true;
        Utility.ACCESS_TOKEN = body['token'];
        Map<String, dynamic> profile = body['profile'].cast<String, dynamic>();
        Utility.CURRENT_PROFILE = Profile.fromJson(profile);
      }
    });
    return isSuccessfully;
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  FocusNode myFocusNode = new FocusNode();
  bool _value = false;
  Future<void> validateLogin() async {
    String username = nameController.text;
    String password = passwordController.text;
    if (await loginToServer(username, password)) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => MyApp()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
          'Account is invalid. Please try again!',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.red,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Scaffold(
          body: Center(
        child: Container(
          decoration: BoxDecoration(
            color: Color.fromARGB(100, 22, 44, 33),
            image: DecorationImage(
                image: AssetImage("assets/images/background.jpg"),
                fit: BoxFit.cover),
          ),
          child: ListView(
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
              Container(
                child: Image.asset(
                  'assets/images/login_logo.png',
                  width: 100,
                  height: 100,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  onSubmitted: (value) {
                    validateLogin();
                  },
                  style: TextStyle(color: Colors.white),
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: 'User Name',
                    labelStyle: TextStyle(
                        color: myFocusNode.hasFocus
                            ? Colors.yellow
                            : Colors.white),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(width: 3, color: Colors.greenAccent),
                      //<-- SEE HERE
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  onSubmitted: (value) {
                    validateLogin();
                  },
                  style: TextStyle(color: Colors.white),
                  obscureText: true,
                  controller: passwordController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                    labelStyle: TextStyle(
                        color: myFocusNode.hasFocus
                            ? Colors.yellow
                            : Colors.white),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(width: 3, color: Colors.greenAccent),
                      //<-- SEE HERE
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  new Flexible(
                    child: CheckboxListTile(
                      title: Text(
                        "Remember me",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                            fontSize: 15),
                      ),
                      autofocus: false,
                      activeColor: Colors.green,
                      checkColor: Colors.white,
                      tileColor: Colors.orange,
                      selectedTileColor: Colors.red,
                      selected: _value,
                      value: _value,
                      onChanged: (bool? value) {
                        setState(() {
                          _value = value!;
                        });
                      },
                      controlAffinity: ListTileControlAffinity
                          .leading, //  <-- leading Checkbox
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 24),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ResetPassword()));
                      },
                      child: Text(
                        "Forgot Password?",
                        style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                  height: 50,
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: ElevatedButton(
                    child: const Text('LOGIN',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            letterSpacing: 5)),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.pink,
                        fixedSize: const Size(300, 100),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50))),
                    onPressed: () {
                      validateLogin();
                    },
                  )),
              Container(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment
                      .center, //Center Row contents horizontally,
                  crossAxisAlignment: CrossAxisAlignment
                      .center, //Center Row contents vertically,
                  children: <Widget>[
                    const Text(
                      "Don't have an account?",
                      style: TextStyle(color: Colors.white),
                    ),
                    TextButton(
                      child: const Text(
                        'Sign up',
                        style: TextStyle(
                            fontSize: 15,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => SignUp()));
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
