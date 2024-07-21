import 'package:classroom_allocation/providers/classroom_provider.dart';
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

  @override
  void initState() {
    super.initState();
    _fetchData = Provider.of<ClassRoomProvider>(context, listen: false)
        .fetchClassRoomDetail(widget.classroomId);
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
            final subject = classroomProvider.classroomDetails?.subject ?? '';

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
                      child: Row(
                        children: [
                          subject.isEmpty
                              ? const Text("Add Subject")
                              : Column(
                                  children: [
                                    Text(subject),
                                    Text(classroomProvider
                                        .classroomDetails!.name),
                                  ],
                                ),
                          Expanded(child: Container()),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Subjects(
                                    classroomId:
                                        classroomProvider.classroomDetails!.id,
                                  ),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(161, 128, 169, 136),
                              foregroundColor:
                                  const Color.fromARGB(207, 52, 152, 49),
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                            ),
                            child: Text(subject.isEmpty ? "Add " : "Change "),
                          ),
                        ],
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
