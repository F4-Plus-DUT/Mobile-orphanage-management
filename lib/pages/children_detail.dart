import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:orphanage_management_system/models/children.dart';
import 'package:orphanage_management_system/pages/edit_children_info.dart';
import 'package:orphanage_management_system/pages/utils.dart';

import '../network/children.dart';

class ChildrenDetail extends StatefulWidget {
  final Children children;
  const ChildrenDetail({
    super.key,
    required this.children,
  });
  @override
  State<StatefulWidget> createState() => _ChildrenDetailState();
}

class _ChildrenDetailState extends State<ChildrenDetail> {
  final ImagePicker _picker = ImagePicker();

  Future<void> _onImageButtonPressed(
      {BuildContext? context, String? id}) async {
    await _displayPickImageDialog(context!, (ImageSource? source) async {
      try {
        if (source == null) {
          setState(() {
            ChildrenNetWork.RemoveChildrenAvatar(widget.children.id)
                .then((value) => {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ChildrenDetail(
                                children: value,
                              )))
                    });
          });
        } else {
          final XFile? pickedFile = await _picker.pickImage(
            source: source,
          );
          setState(() {
            ChildrenNetWork.UpdateChildrenAvatar(
                    widget.children.id, pickedFile!.path)
                .then((value) => {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ChildrenDetail(
                                children: value,
                              )))
                    });
          });
        }
      } catch (e) {
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (Utility.CURRENT_PROFILE.roles.levels < 4) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Children Detail Page"),
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
                              widget.children.personal_picture ??
                                  Utility.DEFAULT_AVATAR,
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
                            onTap: () {
                              _onImageButtonPressed(
                                  context: context, id: widget.children.id);
                            },
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
                  widget.children.name,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              ElevatedButton(
                // Edit
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              EditChildren(children: widget.children)));
                },
                child: Text('Edit Children Profile'),
              ),
              ChildrenInfo(
                widget: widget,
                label: "Gender",
                value: widget.children.gender.toString(),
              ),
              ChildrenInfo(
                widget: widget,
                label: "Age",
                value: widget.children.age.toString(),
              ),
              ChildrenInfo(
                widget: widget,
                label: "Status",
                value: widget.children.status.toString(),
              ),
              ChildrenInfo(
                widget: widget,
                label: "Join Date",
                value: DateFormat("yyyy-MM-dd")
                    .format(DateFormat("yyyy-MM-dd'T'HH:mm:ss").parse(
                        widget.children.join_date ?? "2022-01-01T00:00:00"))
                    .toString(),
              ),
              ChildrenInfo(
                widget: widget,
                label: "Active",
                value: widget.children.is_active.toString(),
              ),
              ChildrenInfo(
                widget: widget,
                label: "Identifier",
                value: widget.children.identifier.toString(),
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            // Add your onPressed code here!
          },
          label: const Text('Request Adoption'),
          icon: const Icon(Icons.request_page),
          backgroundColor: Colors.lightBlue,
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text("Children Detail Page"),
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
                              widget.children.personal_picture ??
                                  Utility.DEFAULT_AVATAR,
                              width: 150,
                              height: 150,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
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
                  widget.children.name,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              ChildrenInfo(
                widget: widget,
                label: "Gender",
                value: widget.children.gender.toString(),
              ),
              ChildrenInfo(
                widget: widget,
                label: "Age",
                value: widget.children.age.toString(),
              ),
              ChildrenInfo(
                widget: widget,
                label: "Status",
                value: widget.children.status.toString(),
              ),
              ChildrenInfo(
                widget: widget,
                label: "Join Date",
                value: DateFormat("yyyy-MM-dd")
                    .format(DateFormat("yyyy-MM-dd'T'HH:mm:ss").parse(
                        widget.children.join_date ?? "2022-01-01T00:00:00"))
                    .toString(),
              ),
              ChildrenInfo(
                widget: widget,
                label: "Active",
                value: widget.children.is_active.toString(),
              ),
              ChildrenInfo(
                widget: widget,
                label: "Identifier",
                value: widget.children.identifier.toString(),
              )
            ],
          ),
        ),
      );
    }
  }

  Future<void> _displayPickImageDialog(
      BuildContext context, OnPickImageCallback onPick) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Edit avatar'),
            actions: <Widget>[
              TextButton(
                child: const Text('Choose picture from camera'),
                onPressed: () {
                  onPick(ImageSource.camera);
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                  child: const Text('Choose picture from gallery'),
                  onPressed: () {
                    onPick(ImageSource.gallery);
                    Navigator.of(context).pop();
                  }),
              TextButton(
                child: const Text('Remove Avatar'),
                onPressed: () async {
                  onPick(null);
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: const Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }
}

class ChildrenInfo extends StatelessWidget {
  final String label;
  final String value;
  const ChildrenInfo({
    Key? key,
    required this.widget,
    required this.label,
    required this.value,
  }) : super(key: key);

  final ChildrenDetail widget;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 4,
          child: Text(
            label,
            style: TextStyle(fontSize: 24),
          ),
        ),
        Expanded(
            flex: 1,
            child: Text(
              " : ",
              style: TextStyle(fontSize: 24),
            )),
        Expanded(
            flex: 7,
            child: Text(
              value,
              style: TextStyle(fontSize: 24),
            ))
      ],
    );
  }
}

typedef OnPickImageCallback = void Function(ImageSource? source);
