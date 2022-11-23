import 'package:flutter/material.dart';
import 'package:orphanage_management_system/pages/signup.dart';
import 'package:orphanage_management_system/pages/utils.dart';

class RequestAdoptionPage extends StatefulWidget {
  @override
  State<RequestAdoptionPage> createState() => _RequestAdoptionPageState();
}

class _RequestAdoptionPageState extends State<RequestAdoptionPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  TextEditingController occupationController = TextEditingController();
  TextEditingController amountController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameController.text = Utility.CURRENT_PROFILE.name.toString();
    emailController.text = Utility.CURRENT_PROFILE.email.toString();
    phoneController.text = Utility.CURRENT_PROFILE.phone.toString();
    addressController.text = Utility.CURRENT_PROFILE.address.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('Request Adoption Page'),
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
                              "Request Adoption",
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
                                  label: "Name",
                                  controller: nameController,
                                  enabled: false),
                              makeInput(
                                  label: "Email",
                                  controller: emailController,
                                  enabled: false),
                              makeInput(
                                  label: "Phone",
                                  controller: phoneController,
                                  enabled: false),
                              makeInput(
                                  label: "Address",
                                  controller: addressController,
                                  enabled: false),
                              makeInput(
                                  label: "Amount",
                                  controller: amountController),
                              makeInput(
                                  label: "Note", controller: noteController)
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 40),
                          child: Container(
                            child: MaterialButton(
                              minWidth: double.infinity,
                              height: 50,
                              color: Colors.blueAccent,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50)),
                              child: Text(
                                "Donate",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    letterSpacing: 3,
                                    wordSpacing: 5),
                              ),
                              onPressed: () async {
                                String email = emailController.text;
                                String note = noteController.text;
                                int amount = int.parse(amountController.text);
                                // ignore: todo
                                // TODO: Call edit children infor here
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
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
