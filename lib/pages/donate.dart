import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:orphanage_management_system/models/activity.dart';
import 'package:orphanage_management_system/models/profile.dart';
import 'package:orphanage_management_system/network/donor.dart';
import 'package:orphanage_management_system/pages/signup.dart';
import 'package:http/http.dart' as http;

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
  Map<String, dynamic>? paymentIntent;
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
                                await makePayment(amountController.text);
                                // ignore: todo
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

  Future<void> makePayment(String amount) async {
    try {
      paymentIntent = await createPaymentIntent(amount, 'VND');
      //Payment Sheet
      await Stripe.instance
          .initPaymentSheet(
              paymentSheetParameters: SetupPaymentSheetParameters(
                  paymentIntentClientSecret: paymentIntent!['client_secret'],
                  // applePay: const PaymentSheetApplePay(merchantCountryCode: '+92',),
                  // googlePay: const PaymentSheetGooglePay(testEnv: true, currencyCode: "US", merchantCountryCode: "+92"),
                  style: ThemeMode.dark,
                  merchantDisplayName: 'TyrPhoon'))
          .then((value) {});

      ///now finally display payment sheeet
      displayPaymentSheet();
    } catch (e, s) {
      print('exception:$e$s');
    }
  }

  displayPaymentSheet() async {
    try {
      String activity = widget.activity?.id ?? "";
      String email = emailController.text;
      String note = noteController.text;
      int amount = int.parse(amountController.text);
      await Stripe.instance.presentPaymentSheet().then((value) async {
        final a = await DonateNetWork.Donate(email, activity, amount, note);
        print(a);
        if (a == 201) {
          showDialog(
              context: context,
              builder: (_) => AlertDialog(
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: const [
                            Icon(
                              Icons.check_circle,
                              color: Colors.green,
                            ),
                            Text("Payment Successfull"),
                          ],
                        ),
                      ],
                    ),
                  ));

          Navigator.pop(context);
        } else {
          showDialog(
              context: context,
              builder: (_) => AlertDialog(
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: const [
                            Icon(
                              Icons.check_circle,
                              color: Colors.red,
                            ),
                            Text("Payment Failure"),
                          ],
                        ),
                      ],
                    ),
                  ));

          Navigator.pop(context);
        }
        // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("paid successfully")));

        paymentIntent = null;
      }).onError((error, stackTrace) {
        print('Error is:--->$error $stackTrace');
      });
    } on StripeException catch (e) {
      print('Error is:---> $e');
      showDialog(
          context: context,
          builder: (_) => const AlertDialog(
                content: Text("Cancelled "),
              ));
    } catch (e) {
      print('$e');
    }
  }

  //  Future<Map<String, dynamic>>
  createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': amount,
        'currency': currency,
        'payment_method_types[]': 'card'
      };

      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization':
              'Bearer sk_test_51M59gTFiFkOTv4wYruzIyhJFlTPkx5vifwn9UZmHuvx8RUT4FmlcTuxkEYs1DfFWx6ZCnIcpb9fnVPbuvP2ZCXma00JvFiyMG0',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: body,
      );
      // ignore: avoid_print
      print('Payment Intent Body->>> ${response.body.toString()}');
      return jsonDecode(response.body);
    } catch (err) {
      // ignore: avoid_print
      print('err charging user: ${err.toString()}');
    }
  }

  // calculateAmount(String amount) {
  //   final calculatedAmout = (int.parse(amount)) / 1000;
  //   return calculatedAmout.toString();
  // }
}
