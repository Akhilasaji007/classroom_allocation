import 'package:classroom_allocation/providers/subject_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SubjectDetail extends StatefulWidget {
  final int subjectId;

  const SubjectDetail({required this.subjectId, super.key});

  @override
  State<SubjectDetail> createState() => _SubjectDetailState();
}

class _SubjectDetailState extends State<SubjectDetail> {
  bool _isInit = true;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      Provider.of<SubjectProvider>(context, listen: false)
          .fetchSubjectDetail(widget.subjectId)
          .catchError((e) {});
      _isInit = false;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final subjectProvider = Provider.of<SubjectProvider>(context);

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
              'Subject Detail',
              style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w700),
            ),
            Expanded(
              child: subjectProvider.isLoading
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: Color.fromARGB(255, 214, 214, 211),
                      ),
                    )
                  : subjectProvider.error != null
                      ? const Center(
                          child: Text('No Subject details available'))
                      : subjectProvider.subjectDetails == null
                          ? const Center(
                              child: Text('No Subject details available'))
                          : Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 180),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const CircleAvatar(
                                    backgroundColor:
                                        Color.fromARGB(255, 233, 228, 228),
                                    radius: 50.0,
                                  ),
                                  const SizedBox(height: 12.0),
                                  Text(
                                    subjectProvider.subjectDetails!.name,
                                    style: const TextStyle(fontSize: 18),
                                  ),
                                  const SizedBox(height: 12.0),
                                  Text(
                                    subjectProvider.subjectDetails!.teacher,
                                    style: const TextStyle(fontSize: 18),
                                  ),
                                  const SizedBox(height: 12.0),
                                  Text(
                                    'Credit : ${subjectProvider.subjectDetails!.credits}',
                                    style: const TextStyle(fontSize: 18),
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
