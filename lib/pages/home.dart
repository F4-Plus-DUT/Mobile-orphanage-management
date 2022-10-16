import 'package:flutter/material.dart';
import 'package:orphanage_management_system/models/category.dart';
import 'package:orphanage_management_system/pages/children_page.dart';
import 'package:orphanage_management_system/pages/utils.dart';
import 'package:orphanage_management_system/services/setting_constant.dart';
import 'package:orphanage_management_system/services/theme_manager.dart';
import 'package:orphanage_management_system/services/category_service.dart';

import '../services/theme_constant.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void dispose() {
    _themeManager.removeListener(themeListener);
    super.dispose();
  }

  @override
  void initState() {
    _themeManager.addListener(themeListener);
    super.initState();
  }

  themeListener() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: _themeManager.themeMode,
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

ThemeManager _themeManager = ThemeManager();

class _HomeState extends State<Home> {
  List<Category> categories = CategoryService.getAllCategories();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Home Page'),
        backgroundColor: Colors.blue,
        actions: [
          Switch(
              value: _themeManager.themeMode == ThemeMode.dark,
              onChanged: (newValue) {
                _themeManager.toggleTheme(newValue);
              }),
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
                onTap: () {
                  // print(categories[i].page);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ChildrenPage()));
                },
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
                                      ),
                                    );
                                  },
                                  child: CircleAvatar(
                                    backgroundColor: Colors.blue,
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
    if (choice == 'Display') {
    } else if (choice == 'Privacy') {
    } else if (choice == 'Subscribe') {
    } else if (choice == 'Help & Support') {
    } else if (choice == 'Feedback') {
    } else if (choice == 'Logout') {
      // Navigator.push(context, new MaterialPageRoute(
      //     builder: (context) =>
      //     new Login())
      // );
      // Navigator.pushNamed(context, '/login');
    }
  }
}
