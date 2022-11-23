import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:orphanage_management_system/models/profile.dart';
import 'package:orphanage_management_system/pages/signup.dart';
import 'package:orphanage_management_system/pages/staff_detail.dart';

import '../network/profile.dart';

class EditStaff extends StatefulWidget {
  late Profile profile;
  EditStaff({
    Key? key,
    required this.profile,
  }) : super(key: key);
  @override
  State<EditStaff> createState() => _EditStaffState();
}

class _EditStaffState extends State<EditStaff> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController occupationController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameController.text = widget.profile.name.toString();
    emailController.text = widget.profile.email.toString();
    addressController.text = widget.profile.address.toString();
    phoneController.text = widget.profile.phone.toString();
    occupationController.text = widget.profile.occupation.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('Edit Profile Page'),
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
                              "Edit Profile Information",
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
                                  label: "Address",
                                  controller: addressController),
                              makeInput(
                                  label: "Phone", controller: phoneController),
                              makeInput(
                                  label: "Occupation",
                                  controller: occupationController)
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 40),
                          child: Container(
                            child: MaterialButton(
                              minWidth: double.infinity,
                              height: 50,
                              color: Colors.pink,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50)),
                              child: Text(
                                "Save",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    letterSpacing: 3,
                                    wordSpacing: 5),
                              ),
                              onPressed: () async {
                                widget.profile.name = nameController.text;
                                widget.profile.email = emailController.text;
                                widget.profile.address = addressController.text;
                                widget.profile.phone = phoneController.text;
                                widget.profile.occupation =
                                    occupationController.text;
                                ProfileNetWork.UpdateProfileInfo(widget.profile)
                                    .then((value) => {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      StaffDetail(
                                                        profile: value,
                                                      )))
                                        });
                                // ignore: todo
                                // TODO: Call edit profile infor here
                              },
                            ),
                          ),
                        ),
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
