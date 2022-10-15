import 'package:flutter/material.dart';
import 'package:orphanage_management_system/models/Account.dart';
import 'package:orphanage_management_system/models/Category.dart';
import 'package:orphanage_management_system/pages/utils.dart';
import 'package:orphanage_management_system/services/CategoryService.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Category> categories = CategoryService.getAllCategories();
  Account account = new Account(
      name: 'Tran Cong Viet',
      email: 'trancongviet0710@gmail.com',
      avatar:
          'https://images.unsplash.com/photo-1611915387288-fd8d2f5f928b?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxleHBsb3JlLWZlZWR8MXx8fGVufDB8fHx8&w=1000&q=80');
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
            onPressed: () {},
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
                                    radius: 30,
                                    backgroundColor: Colors.white,
                                    // backgroundImage: AssetImage(
                                    //   'assets/${categories[i].image}',
                                    // ),
                                    // backgroundColor: Colors.transparent,
                                    child: ClipOval(
                                      child: Image.asset(
                                        'assets/${categories[i].image}',
                                      ),
                                    ),
                                  ))),
                          Center(
                            child: Text(
                              '${categories[i].title}',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Center(
                            child: Text(
                              '${categories[i].subtitle}',
                              style: TextStyle(
                                fontSize: 12,
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
            childAspectRatio: 2,
            crossAxisSpacing: 30,
            mainAxisSpacing: 10,
            mainAxisExtent: 300,
          ),
        ),
      ),
      floatingActionButton: Container(
        width: 50.0,
        height: 50.0,
        child: FloatingActionButton(
          onPressed: () {

          },
          backgroundColor: Colors.pink,
          child: const Icon(Icons.settings),

        ),
      ),
    );
  }
}
