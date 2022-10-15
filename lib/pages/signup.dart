import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:orphanage_management_system/pages/utils.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String signup_url = Utility.BASE_URL + "api/v1/user/action/sign_up";
  Future<bool> sign_up(String name, String email, String pwd) async {
    bool isSuccessfully = false;
    print("This is sign up function");
    await http
        .post(Uri.parse(signup_url),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(<String, String>{
              'name': name,
              'email': email,
              'password': pwd
            }))
        .then((response) {
      // var body = json.decode(response.body);
      print(response.statusCode);
      // print(body);
      if (response.statusCode == 201) {
        isSuccessfully = true;
      }
    });
    return isSuccessfully;
  }

  //Controller
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController password2Controller = TextEditingController();

  //Regex
  RegExp hexEmail = RegExp(
      r'[a-zA-Z0-9.!#$%&*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$');

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('Sign Up Page'),
          elevation: 0,
          backgroundColor: Colors.lightBlueAccent,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios,
                size: 10,
                color: Colors.black,
              )),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              decoration: BoxDecoration(
                color: Color.fromARGB(100, 22, 44, 33),
                image: DecorationImage(
                    image: AssetImage("assets/images/sign_up_background.jpg"),
                    fit: BoxFit.cover),
              ),
              height: MediaQuery.of(context).size.height,
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              "Create an Account",
                              style: TextStyle(
                                fontSize: 25,
                                color: Colors.cyanAccent,
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            )
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 40),
                          child: Column(
                            children: [
                              makeInput(
                                  label: "Name", controller: nameController),
                              makeInput(
                                  label: "Email", controller: emailController),
                              makeInput(
                                  label: "Password",
                                  obsureText: true,
                                  controller: passwordController),
                              makeInput(
                                  label: "Confirm Password",
                                  obsureText: true,
                                  controller: password2Controller)
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 40),
                          child: Container(
                            //   padding: EdgeInsets.only(top: 3, left: 3),
                            //   decoration: BoxDecoration(
                            //       borderRadius: BorderRadius.circular(40),
                            //       border: Border(
                            //           bottom: BorderSide(color: Colors.black),
                            //           top: BorderSide(color: Colors.black),
                            //           right: BorderSide(color: Colors.black),
                            //           left: BorderSide(color: Colors.black))),
                            child: MaterialButton(
                              minWidth: double.infinity,
                              height: 50,
                              color: Colors.pink,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50)),
                              child: Text(
                                "SIGN UP",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    letterSpacing: 3,
                                    wordSpacing: 5),
                              ),
                              onPressed: () async {
                                String name = nameController.text;
                                String email = emailController.text;
                                String password = passwordController.text;
                                String password_2 = password2Controller.text;
                                //Xử lý regex cho name và email
                                if (!hexEmail.hasMatch(email)) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(const SnackBar(
                                    content: Text(
                                      'Email is not valid.',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                    backgroundColor: Colors.red,
                                  ));
                                }
                                if (password.compareTo(password_2) != 0) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(const SnackBar(
                                    content: Text(
                                      'Password does not match.',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                    backgroundColor: Colors.red,
                                  ));
                                }
                                if (await sign_up(name, email, password)) {
                                  print("Create successfully!");
                                  Navigator.pushNamed(context, '/login');
                                }
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Already have an account? "),
                            TextButton(
                              child: const Text(
                                "Login",
                                style: TextStyle(
                                    color: Colors.cyanAccent,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18),
                              ),
                              onPressed: () {
                                Navigator.pushNamed(context, '/login');
                              },
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Widget makeInput({label, obsureText = false, controller}) {
  return Container(
    child: Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400,
                color: Colors.black87,
                fontStyle: FontStyle.italic),
          ),
          SizedBox(
            height: 5,
          ),
          TextField(
            controller: controller,
            obscureText: obsureText,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
              enabledBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(width: 3, color: Colors.grey), //<-- SEE HERE
                borderRadius: BorderRadius.circular(50.0),
              ),
            ),
          ),
          SizedBox(
            height: 30,
          )
        ],
      ),
    ),
  );
}
