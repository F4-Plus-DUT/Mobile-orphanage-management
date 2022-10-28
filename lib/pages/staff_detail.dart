import 'package:flutter/material.dart';
import 'package:orphanage_management_system/models/profile.dart';

class StaffDetail extends StatefulWidget {
  final Profile profile;

  const StaffDetail({super.key, required this.profile});
  @override
  State<StatefulWidget> createState() => _StaffDetailState();
}

class _StaffDetailState extends State<StaffDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Staff Detail Page"),
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
                            widget.profile.avatar ??
                                "https://t3.ftcdn.net/jpg/02/09/37/00/360_F_209370065_JLXhrc5inEmGl52SyvSPeVB23hB6IjrR.jpg",
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
                widget.profile.name!,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            ElevatedButton(
              // Edit
              onPressed: () {},
              child: Text('Edit Staff Profile'),
            ),
            ProfileInfo(
              widget: widget,
              label: "Email",
              value: widget.profile.email.toString(),
            ),
            ProfileInfo(
              widget: widget,
              label: "Age",
              value: widget.profile.age.toString(),
            ),
            ProfileInfo(
              widget: widget,
              label: "Address",
              value: widget.profile.address.toString(),
            ),
            ProfileInfo(
              widget: widget,
              label: "Occupation",
              value: widget.profile.occupation.toString(),
            ),
            ProfileInfo(
              widget: widget,
              label: "Phone",
              value: widget.profile.phone.toString(),
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

  final StaffDetail widget;

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
