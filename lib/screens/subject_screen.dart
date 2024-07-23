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
                                const SnackBar(
                                  backgroundColor:
                                      Color.fromARGB(227, 130, 172, 138),
                                  content: Center(
                                    child: Text(
                                      "Subject Updated",
                                      style: TextStyle(
                                        color: Color.fromARGB(255, 79, 139, 93),
                                        fontWeight: FontWeight.w600,
                                        fontSize: 20.0,
                                      ),
                                    ),
                                  ),
                                  duration: Duration(seconds: 2),
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
                                              fontSize: 17,
                                              fontWeight: FontWeight.w400),
                                        ),
                                        Text(
                                          subjectProvider
                                              .subjects[index].teacher,
                                          style: const TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ],
                                    ),
                                    Expanded(child: Container()),
                                    Column(
                                      children: [
                                        Text(
                                          '${subjectProvider.subjects[index].credits}',
                                          style: const TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.w400),
                                        ),
                                        const Text(
                                          "Credit",
                                          style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w400),
                                        ),
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
