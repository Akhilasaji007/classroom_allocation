import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  final List<Map<String, dynamic>> items = [
    {
      'text': 'Students',
      'iconData': Icons.school_outlined,
      'color': const Color.fromARGB(123, 201, 244, 217),
      'iconcolor': Colors.green,
      'route': '/students',
    },
    {
      'text': 'Subjetcs',
      'iconData': Icons.import_contacts_outlined,
      'color': const Color.fromARGB(220, 226, 235, 244),
      'iconcolor': Colors.blue,
      'route': '/students',
    },
    {
      'text': 'Class Rooms',
      'iconData': Icons.meeting_room_outlined,
      'color': const Color.fromARGB(252, 243, 219, 219),
      'iconcolor': const Color.fromARGB(235, 231, 111, 102),
      'route': '/students',
    },
    {
      'text': 'Registration',
      'iconData': Icons.edit_outlined,
      'color': const Color.fromARGB(255, 246, 235, 219),
      'iconcolor': const Color.fromARGB(255, 228, 183, 93),
      'route': '/students',
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
            icon: const Icon(Icons.menu),
            onPressed: () {
              Navigator.pushNamed(context, '/student_detail');
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
                      Icon(
                        items[index]['iconData'],
                        size: 48.0,
                        color: items[index]['iconcolor'],
                      ),
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
