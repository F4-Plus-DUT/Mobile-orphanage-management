import 'package:flutter/material.dart';
import 'package:orphanage_management_system/models/activity.dart';
import 'package:orphanage_management_system/models/profile.dart';
import 'package:orphanage_management_system/pages/signup.dart';

class DonatePage extends StatefulWidget {
  late Activity? activity;
  late Profile current_user;
  DonatePage({this.activity, required this.current_user});
  @override
  State<DonatePage> createState() => _DonatePageState();
}

class _DonatePageState extends State<DonatePage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  TextEditingController amountController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameController.text = widget.current_user.name.toString();
    emailController.text = widget.current_user.email.toString();
    phoneController.text = widget.current_user.phone.toString();
    addressController.text = widget.current_user.address.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('Donate Page'),
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
                              "Donation",
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
                                  label: "Note", controller: noteController),
                              makeInput(
                                  label: "Amount", controller: amountController)
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
                                String activity = widget.activity?.id ?? "";
                                String email = emailController.text;
                                String note = noteController.text;
                                int amount = int.parse(amountController.text);
                                TextEditingController donate_email_Controller =
                                    TextEditingController();
                                TextEditingController
                                    donate_card_number_Controller =
                                    TextEditingController();
                                TextEditingController
                                    donate_card_cvc_Controller =
                                    TextEditingController();
                                TextEditingController donate_date_Controller =
                                    TextEditingController();
                                // ignore: todo
                                final result = await showDialog(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      AlertDialog(
                                    title: Center(child: const Text('Donate')),
                                    content: SafeArea(
                                      child: SingleChildScrollView(
                                          child: Container(
                                        height:
                                            MediaQuery.of(context).size.height,
                                        width: double.infinity,
                                        child: Column(children: [
                                          makeInput(
                                            label: "Email",
                                            controller: donate_email_Controller,
                                          ),
                                          makeInput(
                                            label: "Card Number",
                                            controller:
                                                donate_card_number_Controller,
                                          ),
                                          makeInput(
                                            label: "Card CVC",
                                            controller:
                                                donate_card_cvc_Controller,
                                          ),
                                          Container(
                                            child: Center(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Date",
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: Colors.black87,
                                                        fontStyle:
                                                            FontStyle.italic),
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  TextField(
                                                    enabled: true,
                                                    controller:
                                                        donate_date_Controller,
                                                    obscureText: false,
                                                    decoration: InputDecoration(
                                                      contentPadding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 0,
                                                              horizontal: 10),
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            width: 3,
                                                            color: Colors
                                                                .grey), //<-- SEE HERE
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(50.0),
                                                      ),
                                                    ),
                                                    onTap: () async {
                                                      final Date =
                                                          await showDatePicker(
                                                        context: context,
                                                        initialDate:
                                                            DateTime.now(),
                                                        firstDate:
                                                            DateTime(1950),
                                                        lastDate:
                                                            DateTime(3000),
                                                      ) as DateTime;
                                                      donate_date_Controller
                                                          .text = Date.month
                                                              .toString() +
                                                          "/" +
                                                          Date.year.toString();
                                                    },
                                                  ),
                                                  SizedBox(
                                                    height: 20,
                                                  )
                                                ],
                                              ),
                                            ),
                                          )
                                        ]),
                                      )),
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(context, 'OK'),
                                        child: const Text('OK'),
                                      ),
                                    ],
                                  ),
                                ) as String?;
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
