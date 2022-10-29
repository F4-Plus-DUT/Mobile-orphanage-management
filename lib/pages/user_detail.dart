import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:orphanage_management_system/pages/edit_user_info.dart';
import 'package:orphanage_management_system/pages/utils.dart';
import '../models/user.dart';

class UserDetail extends StatefulWidget {
  final User user;

  const UserDetail({super.key, required this.user});
  @override
  State<StatefulWidget> createState() => _UserDetailState();
}

class _UserDetailState extends State<UserDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User Detail Page"),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)),
                color: Colors.grey,
              ),
              width: MediaQuery.of(context).size.width,
              height: 16,
            ),
            Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 110,
                  color: Colors.grey,
                ),
                Center(
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white)),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(99),
                          child: Image.network(
                            widget.user.avatar ?? Utility.DEFAULT_AVATAR,
                            width: 150,
                            height: 150,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        left: 110,
                        top: 115,
                        child: InkWell(
                          child: Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.grey,
                                border: Border.all(color: Colors.white)),
                            child: Center(
                              child: Icon(Icons.camera_alt),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 16,
            ),
            Center(
              child: Text(
                widget.user.name ?? "-",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            ElevatedButton(
              // Edit
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditUser(user: widget.user),
                    ));
              },
              child: Text('Edit User Profile'),
            ),
            ProfileInfo(
              widget: widget,
              label: "Email",
              value: widget.user.email.toString(),
            ),
            ProfileInfo(
              widget: widget,
              label: "Birthday",
              value: DateFormat("yyyy-MM-dd")
                  .format(DateFormat("yyyy-MM-dd'T'HH:mm:ss")
                      .parse(widget.user.birthday ?? "2022-01-01T00:00:00"))
                  .toString(),
            ),
            ProfileInfo(
              widget: widget,
              label: "Address",
              value: widget.user.address.toString(),
            ),
            ProfileInfo(
              widget: widget,
              label: "Occupation",
              value: widget.user.occupation.toString(),
            ),
            ProfileInfo(
              widget: widget,
              label: "Phone",
              value: widget.user.phone.toString(),
            )
          ],
        ),
      ),
    );
  }
}

class ProfileInfo extends StatelessWidget {
  final String label;
  final String value;
  const ProfileInfo({
    Key? key,
    required this.widget,
    required this.label,
    required this.value,
  }) : super(key: key);

  final UserDetail widget;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 4,
          child: Text(
            label,
            style: TextStyle(fontSize: 16),
          ),
        ),
        Expanded(
            flex: 1,
            child: Text(
              " : ",
              style: TextStyle(fontSize: 16),
            )),
        Expanded(
            flex: 7,
            child: Text(
              value,
              style: TextStyle(fontSize: 16),
            ))
      ],
    );
  }
}
