import 'package:classroom_allocation/providers/register_provider.dart';
import 'package:classroom_allocation/screens/student_screen.dart';
import 'package:classroom_allocation/screens/subject_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NewRegistration extends StatefulWidget {
  const NewRegistration({super.key});

  @override
  State<NewRegistration> createState() => _NewRegistrationState();
}

class _NewRegistrationState extends State<NewRegistration> {
  String? studName;
  int? studId;
  String? subName;
  int? subId;

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
          const Text(
            'New Registration',
            style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 25.0),
          Padding(
            padding: const EdgeInsets.only(right: 16, left: 16, bottom: 8),
            child: GestureDetector(
              onTap: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Students(register: true),
                  ),
                );

                if (result != null) {
                  setState(() {
                    studName = result['studName'];
                    studId = result['studId'];
                  });
                }
              },
              child: Card(
                color: const Color.fromARGB(209, 209, 209, 209),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(9.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 8.0),
                    child: Row(
                      children: [
                        Text(
                          studName ?? 'Select a Student',
                          style: const TextStyle(
                              fontSize: 17.0, fontWeight: FontWeight.w400),
                        ),
                        Expanded(child: Container()),
                        const Icon(Icons.arrow_forward_ios),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 16, left: 16, bottom: 8),
            child: GestureDetector(
              onTap: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        const Subjects(register: true, classroomId: null),
                  ),
                );

                if (result != null) {
                  setState(() {
                    subName = result['subName'];
                    subId = result['subId'];
                  });
                }
              },
              child: Card(
                color: const Color.fromARGB(209, 209, 209, 209),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(9.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 8.0),
                    child: Row(
                      children: [
                        Text(
                          subName ?? 'Select a Subject',
                          style: const TextStyle(
                              fontSize: 17.0, fontWeight: FontWeight.w400),
                        ),
                        Expanded(child: Container()),
                        const Icon(Icons.arrow_forward_ios),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: () {
              _createRegistration(context, studId!, subId!);
              Navigator.pushNamed(context, '/registration');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(185, 49, 142, 78),
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(9.0),
              ),
            ),
            child: const Padding(
              padding: EdgeInsets.all(12.0),
              child: Text(
                "Register",
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _createRegistration(
      BuildContext context, studentId, int subjectId) async {
    await Provider.of<RegistrationProvider>(context, listen: false)
        .studentRegistration(studentId, subjectId)
        .catchError((e) {});
  }
}
