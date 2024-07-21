import 'package:classroom_allocation/providers/classroom_provider.dart';
import 'package:classroom_allocation/providers/student_provider.dart';
import 'package:classroom_allocation/providers/subject_provider.dart';
import 'package:classroom_allocation/screens/classroom_screen.dart';
import 'package:classroom_allocation/screens/home_screen.dart';
import 'package:classroom_allocation/screens/home1_screen.dart';
import 'package:classroom_allocation/screens/student_screen.dart';
import 'package:classroom_allocation/screens/subject_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => StudentProvider()),
          ChangeNotifierProvider(create: (_) => SubjectProvider()),
          ChangeNotifierProvider(create: (_) => ClassRoomProvider()),
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
                seedColor: const Color.fromARGB(255, 146, 145, 148)),
            useMaterial3: true,
          ),
          routes: {
            '/home1': (context) => HomePage1(),
            '/students': (context) => const Students(),
            '/subjects': (context) => const Subjects(classroomId: null,),
            '/classrooms': (context) => const ClassRooms(),
          },
          home: HomePage(),
        ));
  }
}
