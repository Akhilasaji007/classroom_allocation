import 'package:classroom_allocation/providers/student_provider.dart';
import 'package:classroom_allocation/screens/student_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Students extends StatelessWidget {
  const Students({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(20.0),
            child: Text('Students',
                style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w700)),
          ),
          Expanded(
            child: FutureBuilder(
              future: Provider.of<StudentProvider>(context, listen: false)
                  .fetchStudents(),
              builder: (ctx, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                      child: CircularProgressIndicator(
                    color: Color.fromARGB(255, 214, 214, 211),
                  ));
                } else {
                  return Consumer<StudentProvider>(
                    builder: (ctx, studentProvider, _) => ListView.builder(
                      itemCount: studentProvider.students.length,
                      itemBuilder: (ctx, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => StudentDetail(
                                  studentId: studentProvider.students[index].id,
                                ),
                              ),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(
                                right: 16, left: 16, bottom: 8),
                            child: Card(
                              color: const Color.fromARGB(209, 209, 209, 209),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(studentProvider
                                            .students[index].name),
                                        Text(studentProvider
                                            .students[index].email),
                                      ],
                                    ),
                                    Expanded(child: Container()),
                                    Text(
                                      ' Age: ${studentProvider.students[index].age}',
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
