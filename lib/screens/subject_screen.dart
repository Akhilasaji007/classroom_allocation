import 'package:classroom_allocation/providers/classroom_provider.dart';
import 'package:classroom_allocation/providers/subject_provider.dart';
import 'package:classroom_allocation/screens/subject_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Subjects extends StatelessWidget {
  final int? classroomId;
  final bool register;

  const Subjects({
    super.key,
    required this.classroomId,
    required this.register,
  });

  @override
  Widget build(BuildContext context) {
    final classRoomProvider = Provider.of<ClassRoomProvider>(context);
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
            padding: EdgeInsets.all(16.0),
            child: Text('Subjects',
                style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w700)),
          ),
          Expanded(
            child: FutureBuilder(
              future: Provider.of<SubjectProvider>(context, listen: false)
                  .fetchSubjects(),
              builder: (ctx, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                      child: CircularProgressIndicator(
                    color: Color.fromARGB(255, 214, 214, 211),
                  ));
                } else {
                  return Consumer<SubjectProvider>(
                    builder: (ctx, subjectProvider, _) => ListView.builder(
                      itemCount: subjectProvider.subjects.length,
                      itemBuilder: (ctx, index) {
                        return GestureDetector(
                          onTap: () {
                            if (classroomId != null) {
                              final int subjectId =
                                  subjectProvider.subjects[index].id;

                              _handleUpdate(context, classroomId!, subjectId);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor:
                                      const Color.fromARGB(160, 146, 191, 155),
                                  content: Center(
                                    child: Text(
                                      classRoomProvider.isSuccess,
                                      style: const TextStyle(
                                        color: Color.fromARGB(255, 52, 120, 87),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20.0,
                                      ),
                                    ),
                                  ),
                                  duration: const Duration(seconds: 60),
                                ),
                              );

                              Navigator.pop(context, subjectId);
                            } else if (register == true) {
                              Navigator.pop(
                                context,
                                {
                                  'subId': subjectProvider.subjects[index].id,
                                  'subName':
                                      subjectProvider.subjects[index].name,
                                },
                              );
                            } else {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SubjectDetail(
                                    subjectId:
                                        subjectProvider.subjects[index].id,
                                  ),
                                ),
                              );
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(
                                right: 16, left: 16, bottom: 8),
                            child: Card(
                              color: const Color.fromARGB(209, 209, 209, 209),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(9.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          subjectProvider.subjects[index].name,
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400),
                                        ),
                                        Text(subjectProvider
                                            .subjects[index].teacher),
                                      ],
                                    ),
                                    Expanded(child: Container()),
                                    Column(
                                      children: [
                                        Text(
                                            '${subjectProvider.subjects[index].credits}'),
                                        const Text("Credit"),
                                      ],
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

  Future<void> _handleUpdate(
      BuildContext context, classroomId, int subjectId) async {
    await Provider.of<ClassRoomProvider>(context, listen: false)
        .updateClassroomSubject(classroomId, subjectId)
        .catchError((e) {});
  }
}
