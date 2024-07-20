import 'package:flutter/material.dart';

class HomePage1 extends StatelessWidget {
  HomePage1({super.key});
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  final List<Map<String, dynamic>> items = [
    {
      'text': 'Students',
      'color': const Color.fromARGB(123, 201, 244, 217),
    },
    {
      'text': 'Subjetcs',
      'color': const Color.fromARGB(220, 226, 235, 244),
    },
    {
      'text': 'Class Rooms',
      'color': const Color.fromARGB(252, 243, 219, 219),
    },
    {
      'text': 'Registration',
      'color': const Color.fromARGB(255, 246, 235, 219),
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
            icon: const Icon(Icons.widgets),
            onPressed: () {},
          ),
        ],
        toolbarHeight: 100.0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 150.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            mainAxisSpacing: 18.0,
            childAspectRatio: 7.45,
          ),
          itemCount: items.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              color: items[index]['color'],
              child: Center(
                child: Text(
                  items[index]['text'],
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 17.0,
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
