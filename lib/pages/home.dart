import 'package:flutter/material.dart';
import 'package:orphanage_management_system/models/Account.dart';
import 'package:orphanage_management_system/models/Category.dart';
import 'package:orphanage_management_system/pages/utils.dart';
import 'package:orphanage_management_system/services/CategoryService.dart';
import 'package:orphanage_management_system/services/SettingConstant.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Category> categories = CategoryService.getAllCategories();
  Account account = new Account(
      name: 'Tran Cong Viet', email: 'trancongviet0710@gmail.com', avatar: '');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Home Page'),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            tooltip: 'Notifications',
            mouseCursor: MouseCursor.defer,
            hoverColor: Colors.red,
            onPressed: () {
              print("Notifications");
            },
          ),
        ],
      ),
      body: Center(
        child: GridView.builder(
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(horizontal: 30),
          itemCount: categories.length,
          itemBuilder: (context, i) {
            return Center(
              child: InkWell(
                child: Container(
                  height: 290,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(20)),
                  margin: EdgeInsets.all(5),
                  padding: EdgeInsets.all(5),
                  child: Stack(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                              child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            Utility.getStatefulWidget(
                                                categories[i].name),
                                        settings:
                                            RouteSettings(arguments: account),
                                      ),
                                    );
                                  },
                                  child: CircleAvatar(
                                    backgroundColor: Colors.white,
                                    child: ClipOval(
                                      child: Padding(
                                        padding: const EdgeInsets.all(15),
                                        child: Container(
                                          child: Image.asset(
                                              'assets/${categories[i].image}'),
                                        ),
                                      ),
                                    ),
                                  ))),
                          Center(
                            child: Text(
                              '${categories[i].title}',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Center(
                            child: Text(
                              '${categories[i].subtitle}',
                              style: TextStyle(
                                fontSize: 10,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1,
            crossAxisSpacing: 50,
            mainAxisSpacing: 10,
            mainAxisExtent: 300,
          ),
        ),
      ),
      floatingActionButton: Container(
          width: 50.0,
          height: 50.0,
          decoration: new BoxDecoration(
              color: Colors.pink, borderRadius: BorderRadius.circular(50.0)),
          child: Container(
            child: PopupMenuButton<String>(
              color: Colors.pinkAccent,
              icon: Icon(Icons.settings),
              onSelected: choiceAction,
              itemBuilder: (BuildContext context) {
                return SettingConstant.choices.map((choice) {
                  return PopupMenuItem<String>(
                    height: 30,
                    padding: EdgeInsets.all(5),
                    mouseCursor: MaterialStateMouseCursor.clickable,
                    value: choice,
                    child: Text(
                      choice,
                      style: TextStyle(color: Colors.white, fontSize: 15.0),
                    ),
                  );
                }).toList();
              },
            ),
          )),
    );
  }

  void choiceAction(String choice) {
    print(choice);
  }
}
