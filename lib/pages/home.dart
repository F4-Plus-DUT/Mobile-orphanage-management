import 'package:flutter/material.dart';
import 'package:orphanage_management_system/models/Category.dart';
import 'package:orphanage_management_system/services/CategoryService.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Category> categories = CategoryService.getAllCatories();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          itemCount: 4,
          itemBuilder: (ctx, i) {
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
                              // child: Image.network(
                              //   'https://tech.pelmorex.com/wp-content/uploads/2020/10/flutter.png',
                              //   fit: BoxFit.fill,
                              // ),
                              child: CircleAvatar(
                            backgroundImage: AssetImage(
                              'assets/images/flutter.png',
                            ),
                            backgroundColor: Colors.transparent,
                            // radius: 20.0,
                          )),
                          Center(
                            child: Text(
                              'Title',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Center(
                            child: Text(
                              'Sub Title',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          // Row(
                          //   children: [
                          //     Text(
                          //       'Subtitle',
                          //       style: TextStyle(
                          //         fontWeight: FontWeight.bold,
                          //         fontSize: 15,
                          //       ),
                          //     ),
                          //   ],
                          // )
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
            childAspectRatio: 1.0,
            crossAxisSpacing: 0.0,
            mainAxisSpacing: 5,
            mainAxisExtent: 264,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your onPressed code here!
        },
        backgroundColor: Colors.grey[700],
        child: const Icon(Icons.settings),
      ),
    );
  }
}
