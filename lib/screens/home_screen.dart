import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  final List<Map<String, dynamic>> items = [
    {
      'text': 'Students',
      'iconData': 'img1.png',
      'color': const Color.fromARGB(123, 201, 244, 217),
      'route': '/students',
    },
    {
      'text': 'Subjetcs',
      'iconData': 'img2.png',
      'color': const Color.fromARGB(220, 226, 235, 244),
      'route': '/subjects',
    },
    {
      'text': 'Class Rooms',
      'iconData': 'img3.png',
      'color': const Color.fromARGB(250, 248, 222, 222),
      'route': '/classrooms',
    },
    {
      'text': 'Registration',
      'iconData': 'img4.png',
      'color': const Color.fromARGB(255, 255, 244, 211),
      'route': '/registration',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Hello,",
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 28.0),
            ),
            Text(
              "Good Morning",
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 22.0),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.menu,
              size: 32,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/home1');
            },
          ),
        ],
        toolbarHeight: 100.0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 30.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 0.0,
            mainAxisSpacing: 18.0,
            childAspectRatio: 0.81,
          ),
          itemCount: items.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, items[index]['route']);
              },
              child: Card(
                color: items[index]['color'],
                child: Padding(
                  padding: const EdgeInsets.only(top: 110.0),
                  child: Column(
                    children: [
                      Image.asset('assets/images/${items[index]['iconData']}'),
                      const SizedBox(height: 10),
                      Text(
                        items[index]['text'],
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 17.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
