import 'package:classroom_allocation/providers/student_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StudentDetail extends StatefulWidget {
  final int studentId;

  const StudentDetail({required this.studentId, super.key});

  @override
  State<StudentDetail> createState() => _StudentDetailState();
}

class _StudentDetailState extends State<StudentDetail> {
  bool _isInit = true;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      Provider.of<StudentProvider>(context, listen: false)
          .fetchStudentDetail(widget.studentId)
          .catchError((e) {});
      _isInit = false;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final studentProvider = Provider.of<StudentProvider>(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Student Detail',
              style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w700),
            ),
            Expanded(
              child: studentProvider.isLoading
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: Color.fromARGB(255, 214, 214, 211),
                      ),
                    )
                  : studentProvider.error != null
                      ? const Center(
                          child: Text('No Student details available'))
                      : studentProvider.studentDetails == null
                          ? const Center(
                              child: Text('No Student details available'))
                          : Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 180),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const CircleAvatar(
                                    backgroundImage:
                                        AssetImage('assets/images/profile.png'),
                                    backgroundColor:
                                        Color.fromARGB(255, 233, 228, 228),
                                    radius: 68.0,
                                  ),
                                  const SizedBox(height: 12.0),
                                  Text(
                                    studentProvider.studentDetails!.name,
                                    style: const TextStyle(
                                        fontSize: 22.47,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  const SizedBox(height: 12.0),
                                  Text(
                                    'Age : ${studentProvider.studentDetails!.age}',
                                    style: const TextStyle(
                                        fontSize: 22.47,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  const SizedBox(height: 12.0),
                                  Text(
                                    studentProvider.studentDetails!.email,
                                    style: const TextStyle(
                                        fontSize: 17.18,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                            ),
            ),
          ],
        ),
      ),
    );
  }
}
