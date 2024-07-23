import 'package:classroom_allocation/providers/classroom_provider.dart';
import 'package:classroom_allocation/providers/subject_provider.dart';
import 'package:classroom_allocation/screens/subject_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ClassRoomDetail extends StatefulWidget {
  final int classroomId;

  const ClassRoomDetail({required this.classroomId, super.key});

  @override
  State<ClassRoomDetail> createState() => _ClassRoomDetailState();
}

class _ClassRoomDetailState extends State<ClassRoomDetail> {
  late Future<void> _fetchData;
  Future<String?>? _subjectNameFuture;

  @override
  void initState() {
    super.initState();
    _fetchData = Provider.of<ClassRoomProvider>(context, listen: false)
        .fetchClassRoomDetail(widget.classroomId);
  }

  Future<String?> _fetchSubjectName(int subjectId) async {
    await Provider.of<SubjectProvider>(context, listen: false)
        .fetchSubjectDetail(subjectId)
        .catchError((e) {});
    final subjectProvider =
        Provider.of<SubjectProvider>(context, listen: false);
    return subjectProvider.subjectDetails?.name;
  }

  @override
  Widget build(BuildContext context) {
    final classroomProvider = Provider.of<ClassRoomProvider>(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: FutureBuilder(
        future: _fetchData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('No classroom details available'));
          } else if (classroomProvider.classroomDetails == null) {
            return const Center(child: Text('No classroom details available'));
          } else {
            final subjectId = classroomProvider.classroomDetails?.subject ?? '';
            if (subjectId.isNotEmpty && _subjectNameFuture == null) {
              final subId = int.tryParse(subjectId);
              if (subId != null) {
                _subjectNameFuture = _fetchSubjectName(subId);
              }
            }

            return Column(
              children: [
                Text(
                  classroomProvider.classroomDetails!.name,
                  style: const TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 15.0),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Card(
                    color: const Color.fromARGB(209, 209, 209, 209),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(9.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20.0,
                        vertical: 8.0,
                      ),
                      child: FutureBuilder<String?>(
                        future: _subjectNameFuture,
                        builder: (context, snapshot) {
                          final subjectName = snapshot.data ?? '';
                          return Row(
                            children: [
                              (subjectName.isEmpty)
                                  ? const Text(
                                      "Add Subject",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400),
                                    )
                                  : Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          subjectName,
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400),
                                        ),
                                        Text(
                                          classroomProvider
                                              .classroomDetails!.name,
                                          style: const TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ],
                                    ),
                              Expanded(child: Container()),
                              ElevatedButton(
                                onPressed: () async {
                                  final result = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Subjects(
                                        classroomId: classroomProvider
                                            .classroomDetails!.id,
                                        register: false,
                                      ),
                                    ),
                                  );
                                  if (result != null && result is int) {
                                    setState(() {
                                      _subjectNameFuture =
                                          _fetchSubjectName(result);
                                    });
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      const Color.fromARGB(161, 128, 169, 136),
                                  foregroundColor:
                                      const Color.fromARGB(207, 40, 112, 38),
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                ),
                                child: Text(
                                  (subjectName.isEmpty) ? "Add " : "Change ",
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 15.0),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 30),
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        childAspectRatio: 1,
                        mainAxisSpacing: 15.0,
                        crossAxisSpacing: 15.0,
                      ),
                      itemCount: classroomProvider.classroomDetails!.size,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 1.0),
                          ),
                          child: const Icon(
                            Icons.airline_seat_recline_normal,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
