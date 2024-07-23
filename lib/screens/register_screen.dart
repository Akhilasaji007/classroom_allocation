import 'package:classroom_allocation/providers/register_provider.dart';
import 'package:classroom_allocation/screens/register_detail.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Registartions extends StatelessWidget {
  const Registartions({super.key});

  @override
  Widget build(BuildContext context) {
    final registarProvider =
        Provider.of<RegistrationProvider>(context, listen: false);
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
            child: Text('Registartions',
                style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w700)),
          ),
          Expanded(
            child: FutureBuilder(
              future: Provider.of<RegistrationProvider>(context, listen: false)
                  .fetchRegistartions(),
              builder: (ctx, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                      child: CircularProgressIndicator(
                    color: Color.fromARGB(255, 214, 214, 211),
                  ));
                } else if (registarProvider.registartions == null ||
                    registarProvider.registartions.isEmpty) {
                  return Column(
                    children: [
                      Expanded(child: Container()),
                      const Text(
                        "No Data",
                        style: TextStyle(
                          fontSize: 17.0,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Expanded(child: Container()),
                      const Text(
                        "Registration Deleted",
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w600,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  );
                } else {
                  return Consumer<RegistrationProvider>(
                    builder: (ctx, registartionProvider, _) => ListView.builder(
                      itemCount: registartionProvider.registartions.length,
                      itemBuilder: (ctx, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RegistrationDetail(
                                  studentId: registartionProvider
                                      .registartions[index].student,
                                  subjectId: registartionProvider
                                      .registartions[index].subject,
                                  registerId: registartionProvider
                                      .registartions[index].id,
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
                                borderRadius: BorderRadius.circular(9.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Row(
                                  children: [
                                    Text(
                                      'Registration Id : #${registartionProvider.registartions[index].id}',
                                      style: const TextStyle(
                                          fontSize: 17.0,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    Expanded(child: Container()),
                                    const Icon(Icons.arrow_forward_ios),
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
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/newregistration');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(251, 202, 224, 244),
              foregroundColor: Colors.blue,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(9.0),
              ),
            ),
            child: const Text(
              "New Registration",
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
            ),
          ),
          const SizedBox(height: 60),
        ],
      ),
    );
  }
}
