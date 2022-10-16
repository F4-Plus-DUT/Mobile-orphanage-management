import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:orphanage_management_system/pages/utils.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Scaffold(
          body: Padding(
              padding: const EdgeInsets.all(20),
              child: Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment
                    .center, //Center Column contents vertically,
                crossAxisAlignment: CrossAxisAlignment
                    .center, //Center Column contents horizontally,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Input your email: ",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  TextField(
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey,
                        ),
                      ),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey)),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment
                        .center, //Center Row contents horizontally,
                    crossAxisAlignment: CrossAxisAlignment
                        .center, //Center Row contents vertically,

                    children: [
                      FloatingActionButton(
                        onPressed: () {
                          // Add your onPressed code here!
                        },
                        backgroundColor: Colors.grey[700],
                        child: Text("OK"),
                        foregroundColor: Colors.orange,
                        hoverColor: Colors.blue,
                      ),
                      FloatingActionButton(
                        onPressed: () {
                          // Add your onPressed code here!
                        },
                        backgroundColor: Colors.grey[700],
                        child: Text("Back"),
                        foregroundColor: Colors.orange,
                        hoverColor: Colors.blue,
                      ),
                    ],
                  ))
                ],
              )))),
    );
  }
}
