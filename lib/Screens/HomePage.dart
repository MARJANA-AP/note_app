import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:note_app/Screens/Addnotes.dart';
import 'package:note_app/Screens/updatepage.dart';
import 'package:note_app/colorTheme/colorpalette.dart';
import 'package:note_app/firebase/firebaseservice.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  FirestoreService fbserve = FirestoreService();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
        Color.fromARGB(255, 233, 210, 166),
        Color.fromARGB(255, 198, 191, 156),
        Color.fromARGB(255, 175, 160, 82),
        Color.fromARGB(255, 159, 159, 113)
      ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: const Color(0x00000000),
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            actions: [
              IconButton(
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                  },
                  icon: const Icon(Icons.logout))
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const EditPage(),
              ));
            },
            child: const Icon(Icons.add),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: double.infinity,
              width: double.infinity,
              child: Column(
                children: [
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        "Notes:",
                        style: TextStyle(
                            fontSize: 40, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                  StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection("NoteApp")
                          .doc(FirebaseAuth.instance.currentUser?.uid)
                          .collection("notes")
                          .orderBy("timestamp", descending: true)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          final notesList = snapshot.data!.docs;

                          return Expanded(
                            child: ListView.builder(
                              itemCount: notesList.length,
                              itemBuilder: (context, index) {
                                QueryDocumentSnapshot data = notesList[index];
                                var id = data.id; //id
                                int selectColorIndex = data['colorIndex'];
                                String note = data['title'];
                                String desc = data['desc'];

                                return Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Container(
                                    height: 80,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        color: bgColor[selectColorIndex],
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Align(
                                                alignment: Alignment.topLeft,
                                                child: Text(
                                                  note,
                                                  // overflow: TextOverflow.ellipsis,
                                                  style: const TextStyle(
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                              ),
                                              Align(
                                                alignment: Alignment.topLeft,
                                                child: Text(
                                                  desc,
                                                  // overflow: TextOverflow.ellipsis,
                                                  style: const TextStyle(
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Column(
                                          children: [
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            InkWell(
                                              onTap: () {
                                                final nid = id;
                                                fbserve.deleteData(nid);
                                              },
                                              child: Container(
                                                height: 20,
                                                width: 60,
                                                decoration: BoxDecoration(
                                                    color: const Color.fromARGB(
                                                        255, 234, 211, 156),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                child: const Center(
                                                    child: Text("delete")),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            InkWell(
                                              onTap: () {
                                                Navigator.of(context)
                                                    .push(MaterialPageRoute(
                                                  builder: (context) =>
                                                      UpdatePage(
                                                    id: id,
                                                    txt: data['title'],
                                                    desc: data['desc'],
                                                    currentcolor:
                                                        selectColorIndex, //to transfer data to update page
                                                  ),
                                                ));
                                              },
                                              child: Container(
                                                height: 20,
                                                width: 60,
                                                decoration: BoxDecoration(
                                                    color: const Color.fromARGB(
                                                        255, 234, 211, 156),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                child: const Center(
                                                    child: Text("update")),
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        } else {
                          return const Center(
                            child: Text("no notes"),
                          );
                        }
                      }),
                ],
              ),
            ),
          )),
    );
  }
}
