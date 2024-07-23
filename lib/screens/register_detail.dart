import 'package:classroom_allocation/providers/register_provider.dart';
import 'package:classroom_allocation/providers/student_provider.dart';
import 'package:classroom_allocation/providers/subject_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegistrationDetail extends StatefulWidget {
  final int subjectId;
  final int studentId;
  final int registerId;

  const RegistrationDetail({
    super.key,
    required this.studentId,
    required this.subjectId,
    required this.registerId,
  });

  @override
  State<RegistrationDetail> createState() => _RegistrationDetailState();
}

class _RegistrationDetailState extends State<RegistrationDetail> {
  @override
  Widget build(BuildContext context) {
    final studentProvider = Provider.of<StudentProvider>(context);
    final subjectProvider = Provider.of<SubjectProvider>(context);

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
            child: Text(
              'Registration',
              style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w700),
            ),
          ),
          FutureBuilder(
            future: Future.wait([
              studentProvider.fetchStudentDetail(widget.studentId),
              subjectProvider.fetchSubjectDetail(widget.subjectId),
            ]),
            builder: (ctx, snapshot) {
              // print(studentProvider.studentDetails);
              // if (snapshot.connectionState == ConnectionState.waiting) {
              //   return const Center(
              //     child: CircularProgressIndicator(
              //       color: Color.fromARGB(255, 214, 214, 211),
              //     ),
              //   );
              // } else if (snapshot.hasError) {
              //   return const Center(
              //     child: Text(
              //       'Error loading registration details',
              //       style: TextStyle(color: Colors.red),
              //     ),
              //   );
              // } else {
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Card(
                        color: const Color.fromARGB(209, 209, 209, 209),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(9.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                right: 16, left: 16, bottom: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Student Details',
                                  style: TextStyle(
                                    fontSize: 17.0,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                if (studentProvider.studentDetails != null) ...[
                                  Row(
                                    children: [
                                      Text(
                                        studentProvider.studentDetails!.name,
                                      ),
                                      Expanded(child: Container()),
                                      Text(
                                        'Age: ${studentProvider.studentDetails!.age}',
                                      ),
                                    ],
                                  ),
                                  Text(
                                    studentProvider.studentDetails!.email,
                                  ),
                                ] else ...[
                                  const Text(
                                    'No student details available',
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      Card(
                        color: const Color.fromARGB(209, 209, 209, 209),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(9.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                right: 16, left: 16, bottom: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Subject Details',
                                  style: TextStyle(
                                    fontSize: 17.0,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                if (subjectProvider.subjectDetails != null) ...[
                                  Row(
                                    children: [
                                      Text(
                                        subjectProvider.subjectDetails!.name,
                                      ),
                                      Expanded(child: Container()),
                                      Text(
                                        'Credit: ${subjectProvider.subjectDetails!.credits}',
                                      ),
                                    ],
                                  ),
                                  Text(
                                    subjectProvider.subjectDetails!.teacher,
                                  ),
                                ] else ...[
                                  const Text(
                                    'No student details available',
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
              // }
            },
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: () async {
              bool shouldDelete = await _showDeleteAlert(context);
              if (shouldDelete) {
                _deleteRegistration(widget.registerId);
                Navigator.pushNamed(context, '/registration');
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    backgroundColor: Color.fromARGB(227, 130, 172, 138),
                    content: Text(
                      'Registration deleted',
                      style: TextStyle(
                        color: Color.fromARGB(255, 79, 139, 93),
                        fontWeight: FontWeight.w600,
                        fontSize: 20.0,
                      ),
                    ),
                    duration: Duration(seconds: 2),
                  ),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 241, 104, 94),
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(9.0),
              ),
            ),
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
              child: Text(
                "Delete Registration",
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
              ),
            ),
          ),
          const SizedBox(height: 50),
        ],
      ),
    );
  }

  Future<void> _deleteRegistration(int registerId) async {
    await Provider.of<RegistrationProvider>(context, listen: false)
        .deleteRegistration(registerId)
        .catchError((e) {});
  }

  Future<bool> _showDeleteAlert(BuildContext context) async {
    final bool? shouldDelete = await showCupertinoDialog<bool>(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: const Text('Delete'),
        content: const Text('Do you want to delete?'),
        actions: [
          CupertinoDialogAction(
            child: const Text(
              'No',
              style: TextStyle(color: Colors.blue),
            ),
            onPressed: () {
              Navigator.of(context).pop(false);
            },
          ),
          CupertinoDialogAction(
            child: const Text(
              'Yes',
            ),
            onPressed: () {
              Navigator.of(context).pop(true);
            },
          ),
        ],
      ),
    );

    return shouldDelete ?? false;
  }
}
