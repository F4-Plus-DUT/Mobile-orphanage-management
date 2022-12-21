import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:orphanage_management_system/pages/home.dart';
import 'package:orphanage_management_system/pages/utils.dart';
import 'package:http/http.dart' as http;

class ChangePassword extends StatefulWidget {
  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  TextEditingController old_password_controller = TextEditingController();
  TextEditingController new_password_controller = TextEditingController();
  String change_pwd_url =
      Utility.BASE_URL + "api/v1/user/account/change_password";

  Future<bool> changePasswordSuccessfully(old_password, new_password) async {
    bool isSuccessfully = false;
    await http
        .post(Uri.parse(change_pwd_url),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              HttpHeaders.authorizationHeader: 'Bearer ' + Utility.ACCESS_TOKEN,
            },
            body: jsonEncode(<String, String>{
              'old_password': old_password,
              'new_password': new_password
            }))
        .then((response) {
      if (response.statusCode == 200) {
        isSuccessfully = true;
      }
    });
    return isSuccessfully;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Change Password Page"),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Color.fromARGB(100, 22, 44, 33),
          image: DecorationImage(
              image: AssetImage("assets/images/change_password_background.jpg"),
              fit: BoxFit.cover),
        ),
        child: Column(
            mainAxisAlignment:
                MainAxisAlignment.center, //Center Column contents vertically,
            children: [
              TextField(
                style: TextStyle(color: Colors.white),
                obscureText: true,
                controller: old_password_controller,
                decoration: InputDecoration(
                  labelStyle: TextStyle(color: Colors.white),
                  labelText: 'Old Password',
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        width: 1, color: Colors.green), //<-- SEE HERE
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              TextField(
                style: TextStyle(color: Colors.white),
                obscureText: true,
                controller: new_password_controller,
                decoration: InputDecoration(
                  labelText: 'New Password',
                  labelStyle: TextStyle(color: Colors.white),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        width: 1, color: Colors.green), //<-- SEE HERE
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment
                    .center, //Center Row contents horizontally,
                crossAxisAlignment:
                    CrossAxisAlignment.center, //Center Row contents vertically,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      String old_password = old_password_controller.text;
                      String new_password = new_password_controller.text;
                      if (old_password == '' || new_password == '') {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text(
                            'Please fill in all the fields!',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          backgroundColor: Colors.red,
                        ));
                      } else if (await changePasswordSuccessfully(
                          old_password, new_password)) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text(
                            'Change password successfully!',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          duration: const Duration(seconds: 5),
                          backgroundColor: Colors.green,
                        ));
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => MyApp()));
                      } else {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text(
                            'Please fill in the correct old password!',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          backgroundColor: Colors.red,
                        ));
                      }
                    },
                    child: Text(
                      "Change Password",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.pink,
                        fixedSize: const Size(300, 50),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50))),
                  ),
                ],
              ))
            ]),
      ),
    );
  }
}
