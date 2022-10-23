import 'package:flutter/material.dart';
import 'package:orphanage_management_system/pages/utils.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}
TextEditingController emailController = TextEditingController();
class _ResetPasswordState extends State<ResetPassword> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text("Reset Password Page"),
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
                      "Enter your registered email",
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
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green),
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                    ),
                    controller: emailController,
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
                      ElevatedButton(
                        onPressed: () {
                          String email = emailController.text;
                          if (!Utility.hexEmail.hasMatch(email)){
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
                          else {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text(
                                'A recover password was sent to your mail. \nPlease check and get it to change your password!',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              duration: const Duration(seconds: 8),
                              backgroundColor: Colors.green,
                            ));
                          }
                        },
                        child: Text(
                          "Send Reset Link",
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
                ],
              )))),
    );
  }
}
