import 'package:flutter/material.dart';
import 'package:orphanage_management_system/models/children.dart';
import 'package:orphanage_management_system/pages/signup.dart';

import '../network/children.dart';
import 'children_detail.dart';

class EditChildren extends StatefulWidget {
  late Children children;
  EditChildren({
    Key? key,
    required this.children,
  }) : super(key: key);
  @override
  State<EditChildren> createState() => _EditChildrenState();
}

class _EditChildrenState extends State<EditChildren> {
  TextEditingController nameController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController statusController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameController.text = widget.children.name.toString();
    genderController.text = widget.children.gender.toString();
    ageController.text = widget.children.age.toString();
    statusController.text = widget.children.status.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('Edit Children Page'),
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
                              "Edit Children Information",
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
                                  label: "Gender",
                                  controller: genderController),
                              makeInput(
                                  label: "Age", controller: ageController),
                              makeInput(
                                  label: "Status", controller: statusController)
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
                                widget.children.name = nameController.text;
                                widget.children.gender =
                                    int.parse(genderController.text);
                                widget.children.age =
                                    int.parse(ageController.text);
                                widget.children.status = statusController.text;
                                ChildrenNetWork.UpdateChildrenInfo(
                                        widget.children)
                                    .then((value) => {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ChildrenDetail(
                                                        children: value,
                                                      )))
                                        });
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
