import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HelpAndSupport extends StatefulWidget{
  @override
  State<HelpAndSupport> createState() => _HelpAndSupportState();
}

class _HelpAndSupportState extends State<HelpAndSupport> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Help & Support"),
        centerTitle: true,
      ),
      body: Container(
        child: Text("Help & Support Page"),
      )


    );
  }
}